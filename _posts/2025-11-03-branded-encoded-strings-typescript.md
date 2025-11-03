---
layout: post
title: "Using Branded Types to Track String Encodings in Typescript"
date: 2025-11-03
comments: false
tags:
- software development
- Typescript
- branded types
- encoding
---
Have you ever caught yourself coding by trial and error, randomly tweaking properties until something works? Perhaps adding CSS font properties without understanding why, or appending wildcards to a regular expression hoping it will match? You're not alone.

This trial-and-error trap is particularly common with complex technical domains like regular expressions, character encoding, and CSS. Even experienced engineers fall into blindly modifying code until it appears to work, skipping the crucial step of understanding the underlying mechanisms. I once watched a developer attempt to fix garbled database text by cycling through character encodings until the problematic characters disappeared. While this approach might temporarily solve the visible issue, it often masks the root cause and creates harder-to-debug problems down the line.

This article focuses on text encoding, though the principles apply broadly. During my work on AmpWhat (a Unicode exploration tool), I learned firsthand the importance of careful, deliberate encoding handling. The application needed to process any possible Unicode character correctly, and any encoding mistakes would cascade into downstream errors. Through this experience, I discovered many popular libraries handled text encoding too casually to be reliable. Let's explore a more rigorous approach.


## Branding to Track Encodings

"Branded Types" are a technique in TypeScript that allows you to create distinct types based on existing ones, without adding any runtime overhead. This is particularly useful for ensuring type safety in scenarios where you want to differentiate between similar types that have different meanings or contexts.

Let's apply this to string encoding. When working with encoded strings, we often make mistakes like:
- Double-encoding a URL string
- Forgetting to HTML-escape text before inserting it into HTML
- Decoding a string that wasn't encoded in the first place

We can use branded types to catch these errors at compile time. Here's how:

```ts
type Encoding = 'URL' | 'base64' | 'HTML' | 'XML' | 'SQL' | 'Shell' // some examples 
declare const _encoding: unique symbol;  
export type EncodedString<E extends Encoding = []> = string & { readonly [_encoding]: E };  
```
This _parameterized_ branded type will let you create types that represent strings with specific encodings. For example, a URL-encoded string would have the type `EncodedString<'URL'>`. You could then create functions that only accept strings with certain encodings, preventing accidental misuse.

This creates a type that "brands" strings with their encoding. For example:
```ts
export function urlEncode<S extends string>(s: S): EncodedString<'URL'> {  
   return encodeURIComponent(s) as EncodedString<'URL'>;  
}  

export function urlDecode<S extends EncodedString<'URL'>>(s: S): string {  
   return decodeURIComponent(s as unknown as string);  
}  
```
This function only accepts strings that are known to be URL-encoded, preventing accidental decoding of already decoded strings. 

Now Typescript will prevent common encoding mistakes:
```ts
const plain = 'hello world'
const encoded = urlEncode(plain)      // OK
urlDecode(encoded)                  // OK
urlDecode(plain)                      // Error: Expected EncodedString<'URL'>
urlEncode(encoded)                    // OK (but we can improve this later)
```

## Layers of Encoding
After building the initial solution, I discovered an important limitation: strings often need multiple encodings applied in sequence. For example:

- A base64-encoded string placed in a URL needs URL encoding on top
- Text in a URL parameter that goes into HTML needs both URL and HTML encoding
- Database text that gets base64-encoded and then URL-encoded for transport

To track this encoding chain, we need to modify our branded type to maintain a stack of encodings. Instead of a single encoding type, we'll track an ordered sequence:
```ts
type EncodingSequence = Array<Encoding>

export type EncodedString<E extends EncodingSequence = []> = string & { readonly [_encoding]: E };  
```

There are a few more pieces that go into play, but let’s look at a new basic encoding function:
```ts  
export function urlEncode<S extends string>(s: S) {
    return encodeURIComponent(s) as AddEncoding<'URL', S>
}
```
This requires a utility type to add the new encoding to the stack:
```ts
type AddEncoding<NewEncoding extends Encoding, ExistingStr extends string> =
    ExistingStr extends EncodedString<infer ExistingEncodings>
        ? EncodedString<Push<ExistingEncodings, NewEncoding>>
        : EncodedString<[NewEncoding]>;
```
And of course you need to decode a string:
```ts
// (incomplete)
export function urlDecode<S extends EncodedString<EncodingSequence>>(encoded: S) {  
   return decodeURIComponent(encoded as unknown as string) as unknown as EncodedString<PreviousEncodingOf<S>>;  
}

type PreviousEncodingOf<S extends string> = Pop<EncodingsOf<S>>
type EncodingsOf<S extends string> = S extends EncodedString<infer T> ? T : []
type Pop<T extends Encoding[]> = T extends [...infer U, Encoding] ? U : never
```
But this doesn't verify the encoding parameter. To do that we need a way to verify the last encoding matches:
```ts   
export function urlDecode<S extends EncodedString<EncodingSequence>>(encoded: HasLast<S, 'URL'>) {  
   return decodeURIComponent(encoded as unknown as string) as unknown as EncodedString<PreviousEncodingOf<S>>;  
}  
```
We'll need a couple more utility types to get the last encoding and the previous encoding:
```ts
type HasLast<S extends string, E extends Encoding> = S extends EncodedString<infer T>
    ? T extends [...infer Rest, infer L]
        ? L extends E
            ? S
            : `Expected last encoding to be ${E}, but got ${L}`
        : `String has no encodings`
    : `String has no encodings`;

```

### Double Encoding
This worked great, but I quickly ran into a common problem: **double encoding**. This happens when a string is encoded multiple times with the same encoding, and I would say is one of the more common bugs. For example, URL-encoding an already URL-encoded string leads to incorrect results. This can be prevented with an additional type check in the encoding function:
```ts
export function urlEncode<S extends string>(s: NotLast<S, 'URL'>) {
    return encodeURIComponent(s) as AddEncoding<'URL', S>
}

// helper: get the last encoding only if it is NOT E; otherwise never
type NotLast<S, E extends Encoding> = S extends EncodedString<infer T>
    ? T extends [...infer Rest, infer L]
        ? L extends E
            ? `Already encoded as ${L}`
            : S
        : S
    : S
```

There are a few pieces there, but they all work together to prevent double encoding. The `NotLast` type checks if the last encoding in the stack is the same as the new encoding being applied. If it is, it produces a compile-time error message instead of allowing the encoding to proceed.

## The Code

All these together allow us to create a type-safe encoding/decoding system that prevents double encoding and ensures proper decode order. You can look around at the code [here](https://github.com/ndp/ts-playground/tree/main/src/encoded-string) if you want to see the implementation.


## Wrapping Up

Years ago I encountered a library that tried to solve text-encoding problems once and for all. I don't remember the language or the name, but it introduced a string class that tracked encodings and used operator overloading to apply the correct encoding automatically. For example, inserting a string into an HTML document would automatically apply HTML encoding — it felt like magic.

That idea stayed with me. While working extensively in TypeScript recently, I wondered whether a similar approach could be practical there. The original library's main drawback was that every piece of text had to live inside the library, which broke compatibility with the wider ecosystem. Although not quite as magical, I think TypeScript's type erasure reduces that interoperability problem.

A sensible next step would be to update existing library signatures to accept and return `EncodedString` types instead of only exposing encode/decode helpers. That would add compile‑time encoding protection without changing runtime behavior.

Spiking this idea convinced me there is real potential with little overhead. For any system that pipes strings through multiple stages, I would seriously consider this approach.

I've been curious about branded types for a while — they remind me of Java's marker interfaces. They feel a bit like a hack, but they work well in TypeScript, and I plan to keep using them.

