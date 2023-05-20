---
layout: post
title: "A type-narrowing Typescript isPromise"
date: 2023-05-20
comments: false
tags:
- Typescript
- Promise
- software development
- Advanced Javascript
- Javascript
---

On a recent project, I needed to detect whether I was given a promise or not. This seems like a weird requirement, but I was writing a "makeRetryable" function that I wanted to work for both synchronous or asynchronous code. Trust me, it was real.

Anyway, I poked around the internet and found various `isPromise` functions. They "worked" in Typescript, but none of them seemed to do the logical thing: narrow the type of the Promise in the process of detecting it. This involves that weird Typescript dance of implementing the same logic in both Javascript and Typescript's type language (whatever that is called). Here's my solution:

```typescript
/*
An `isPromise` detector that narrows the type of the promise return type, when returning `true`.
 */
export function isPromise<T = unknown>(obj: unknown):
  obj is T extends { then: (...args: unknown[]) => unknown } ? Promise<Awaited<T>> : never {
  return !!obj &&
    (typeof obj === 'object' || typeof obj === 'function') &&
    typeof obj.then === 'function';
}
```
That's it.

For those who want to see the tests, they are here:

```typescript
import {strict as assert} from 'assert'
import type {Equal, Expect} from '@type-challenges/utils'

function testIsPromise() {
  // Happy path
  const maybe = Math.random() < 2
  const fooPromise = maybe ? Promise.resolve('foo' as const) : 'bar'
  assert.equal(isPromise(fooPromise), true)

  // Show that the types are narrowed properly
  if (isPromise(fooPromise))
    type cases1 = [
      Expect<Equal<typeof fooPromise, Promise<'foo'>>>
    ]
  else
    type cases2 = [
      Expect<Equal<typeof fooPromise, 'bar'>>
    ]

  const rejectedPromise = Promise.reject('foo');
  assert.equal(isPromise(rejectedPromise), true)
  // Catch that to prevent "unhandled rejection" warning from TS
  rejectedPromise.catch(() => 0)

  // A promise is just an object with a .then function property
  assert.equal(isPromise({then: () => null}), true)

  // Then a whole bunch of non-promises...
  assert.equal(isPromise(null), false)
  assert.equal(isPromise(undefined), false)
  assert.equal(isPromise(0), false)
  assert.equal(isPromise(1), false)
  assert.equal(isPromise(''), false)
  assert.equal(isPromise('then'), false)
  assert.equal(isPromise(false), false)
  assert.equal(isPromise(true), false)
  assert.equal(isPromise({}), false)
  assert.equal(isPromise({'then': true}), false)
  assert.equal(isPromise({'then': 1}), false)
  assert.equal(isPromise([]), false)
  assert.equal(isPromise([true]), false)
  assert.equal(isPromise(['then']), false)
  assert.equal(isPromise(() => null), false)
}
```