---
layout: post
title: "Add Types to  RegExp Matches in Typescript"
date: 2022-10-19
comments: false
tags:

- software development
- typescript
- advanced typescript
- regular expressions
---

I've been diving into advanced Typescript, hoping to grow less befuddled when encountering complex type definitions. I've converted several projects to Typescript, explored writing typed routers and database adapters, and then, a few days ago, thought of this challenge. I'm a bit of a RegExp nerd, so I wondered if I could make Typescript provide me with  type-ahead for the results of a regular expression match. I suspected it was possible.

### Named Groups

It makes sense to use "named groups" for this project. They are a less-used featured of regular expressions, so I'll recap: they are, as you might expect, a way of naming matching groups. In a pattern, they are specified using a `(?<` identifier. Here's an example capturing a "protocol" group:

```typescript
const proto = RegExp('^(?<protocol>http|https|ftp|mailto).*')
```

The rather funky `(?<some-name>...)` identifies the named group along with the pattern (between the `>` and the closing `)`). When you get the result of your regular expression match, you receive a "match" record (or null if there's no match). This match record has a `groups` property, and the value of the groups property, if present, is an object mapping of the named groups to the matched values. It's easier to see as an example:

```typescript
proto.exec('http://example.co').groups.protocol // => "http"
```

This is nice, and more clear than digging item 4 (or was it 3?) out of an array. It makes your regular expressions easier to maintain (although a bit bulky). There are a few complexities I'm glossing over, but that's the crux of it.

### The Mission

With the built-in types, the `groups` property contains a generic record:

```typescript
groups?: {
    [key: string]: string
}
```

I used a string-literal to input my regular expression, so it would be nice if Typescript would use what it knows to prevent typos in the matched names. Here how I imagine it would suggest property names:

![](/assets/posts/2022/regexp-types.png)

And showing a typo:

![protocall](/assets/posts/2022/protocall.png)

Below, I'll show you how I did this.

### Patch in

Typescript allows you to supplement built-in types. I haven't experienced this in other languages, and although it can feel like too much flexibility, it also has provided us the ability to create types for hundreds of existing libraries, without having to convert them to Typescript. This was one of the killer features of Typescript that led to its wide adoption, and we're going to use it here. 

My first thought was to modify the existing RegExp object, and make it generic and subtyped on the regular expression. But Typescript objected; we can't just create a templated RegExp object (ie. `RegExp<T>`). It would be too confusing. Learning this, I almost gave up, but I realized there are other routes. 

Although I couldn't make RegExp generic, I could create my own generic subclass, and patch the standard RegExp code to return my new type. That actually seems like a reasonable way to solve these problems in Typescript. I called the new type `RegexWithNamedGroup`, and here is an overloaded `new` operation that returns it.

```typescript
interface RegExpConstructor {
  new<T extends string> (pattern: T, flags?: string): RegexWithNamedGroup<T>;
} 
```

(For all this to work in a fully fleshed out solution, I'd also have to patch a few other regular expression methods involved, like `String.prototype.match`, `String.prototype.matchAll`.)

What I've found is generic types will often have to pass the types to other types to get them where they are needed. We need to do that here. The build-in types of a RegExp's `exec` function returns a `RegExpExecArray` (or `RegExpMatchArray`-- same thing). These are arrays of the index matches supplemented with a `groups` wildcard object of strings for the named matches. Here's the supplement:

```typescript
interface RegExpExecArray {
  groups?: {
    [key: string]: string
  }
}
```
We want to make this more specific.  So, instead of returning the `RegExpExecArray`, we return our own RegExp type that has its own `exec` function that returns its own type.

```typescript
// template-ized RegExp type
interface RegexWithNamedGroup<S extends string> extends RegExp {
  exec (s: string): RegExpMatchedGroups<S> // my override of RegExpExecArray
}

// template-ized results type
interface RegExpMatchedGroups<S> extends RegExpExecArray {
  groups?: ExtractGroupNames<S>
}
```
The groups have a specific type, based on the original RegExp string passed to the constructor. How this works is shown below.

### The Magic

You may be thinking I haven't done anything. Well, just give me a sec. We need to parse through the regular expression string.  The type `ExtractGroupNames` builds a record of the specific names found in the regular expression:

```typescript
    type ExtractGroupNames<S extends string> =
      S extends `${string}(?<${infer Name}>${infer Rest}`
        ? (Record<Name, string> & ExtractGroupNames<Rest>)
        : Record<never, any>
```

This looks weird at first, but not actually that hard to follow, and can be read iteratively. 

* Line 2: if the type passed in is a string with a named group within in it, do line 3; otherwise, line 4
* Line 3: return a Record matching the named group name intersected with the type of the "rest" of the string. This is basically a recursive call to build up the full type.
* Line 4: If there is no (more) named groups, it simply returns an empty object type, represented as `Record<never, any>`.

### In Conclusion

Typescript is a fun language. This particular exercise may be a demonstration of one of the complaints about Typescript: fussing with static types can  be a distraction from solving the important problems. But it was fun to figure out, and after struggling over some related tough problems, felt fairly straightforward. These techniques are applicable for routers and pattern-matching type of code. Let me know if you have an interesting Typescript puzzles-- or serious problems-- to work out.

