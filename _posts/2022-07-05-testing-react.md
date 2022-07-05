---
layout: post
title: "Testing React is Testing Me"
date: 2022-07-05
comments: false
tags:
- software development
- testing
- react
- sheetshow
---

I needed to help a student at @techtonica write a test for a React component. It wasn't trivial, as it called a backend API for its data, but it shouldn't have been as hard as it was. 

## What I Found

So I jumped back in to testing React after a couple of years. (I've been noodling on [Thoreau](https://github.com/ndp/thoreau), [gauge](https://gauge.org/) and [Playwright](https://playwright.dev/). Last time I'd written React, we used Enzyme and Jest. I weathered the transition from Jasmine to native-Jest tests. Jumping back in, I was surprised and disappointed at how many stumbling blocks had piled up:

- incompatible Jest configuration changes, [version 23 or 24](https://testing-library.com/docs/react-testing-library/setup#jest-24-or-lower-and-defaults) or [version 27](https://testing-library.com/docs/react-testing-library/setup#jest-27)? 
- abandonment of Enzyme (but 1000s of examples abound)
- abandonment of class-components for "functional" ones, coupled with adoption of hooks to write code (although leen information on how to test components that use hooks).
- the addition of [React Testing Library](https://testing-library.com/docs/react-testing-library/intro/)
- inconsistent naming of libries, such that the names don't always match the package names.
- Mocking seems to have evolved in different ways, and it's hard to find any two example that agree on what a `mock()` function should do. There are, in fact, at least 4 ways to mock a module using Jest, as explained [here](https://jestjs.io/docs/es6-class-mocks). The designers of this library could have helped users by coming up with simpler usage patterns.
- `render('huh?')` Documentation is confusing because half the examples feature setup/teardown blocks to place the rendered component in the DOM, and the other half seem to skip this step. (Or maybe they just don't show it.) The surprise is that the code examples are using two different `render` methods from different libraries. Gotcha! If you're not tuned into this, you'll miss it.  The generically named "React Testing Library" is responsible, with it's own `render` method that obviates the need for this setup and teardown code. Progress, but too subtle for someone trying to digest all the documentation and libraries. 
  To make this slightly more confusing, it's a commonly recommended practice to override (one of) the `render` methods in the test setup code, to inject application-specific context, adding a third version of what `render` might mean. Readers are suitably confused when they see `render` in a test.
- I also discovered that `react-testing-library` re-exports all `dom-testing-library` utilities. In this case, the same names mean the same thing. Good luck if you skip the last sentence of paragraph 4: "so, in the next examples, we will import from @testing-library/react instead of @testing-library/dom." 

## Orientation

Given all that, here's a brief overview of relevant libraries:

* The React site itself points you here: https://reactjs.org/docs/testing.html. This gives you a somewhat incomplete answer to testing react components.
* [*Jest*](https://jestjs.io/) is a JavaScript test runner that lets you access the DOM. This is what most React tests are built upon.

* *React DOM* is the library that implements `render`  in your React app code. It's intuitive and many example show [writing tests with this ReactDOM.render() method](https://noriste.github.io/reactjsday-2019-testing-course/book/intro-to-react-testing/react-dom-test-utils.html). Using this, you're testing the real-life code and behavior, but it can be awkward because of the setup code required. This technique requires setup and teardown methods to make sure the DOM is ready and cleaned up after tests. Streamlined tools like Enzyme and then DOM Testing Library came in to solve these problems. Sadly, examples using technique look similar _but are not compatible with_ DOM Testing Library.

* *DOM Testing Library* is a very light-weight solution for answering questions about DOM nodes. It looks for nodes in a DOM tree, using `getBy` and `queryBy`.  You need this when you're in the process of writing a test, but definitely [skim the documentation](https://noriste.github.io/reactjsday-2019-testing-course/book/react-testing-library/dom-testing-library.html) before you start writing tests, so you know what's there.

* Thrice named [Test Utilities, ReactTestUtils, or `react-dom/test-utils`](https://reactjs.org/docs/test-utils.html#) looks to be outdated. Watch out for these examples and the inconsistent naming here. It has an `act` method, but you're better off heading for `React Testing Library`.

* *React Testing Library* (in package.json is known as `@testing-library/react`) combines useful functions of _DOM Testing Library_ with a set of convenient helpers, to provide a unified place to look to test React components. This is a higher-level library than others, and a good place to start if you're looking for working examples. Here's a nice intro: https://noriste.github.io/reactjsday-2019-testing-course/book/react-testing-library/. There are both familiar and unfamiliar function signatures here: it re-exports some stuff from DOM Testing library, and introduces its own `render` method that work well for most tests. Be careful of the overloaded names.

## Wrap-up & Lessons

[ReactJSDay 2019 Testing Course](https://noriste.github.io/reactjsday-2019-testing-course/) has sorted it all out,  although it's long. It shows you all the ways to do it and how they relate. It has good, working examples. I didn't find another source that described all the pieces, which is what I needed. I'd recommend that over the many medium posts and outdated StackOverflow posts, but you don't need to read all of this.

To my eye, this is all a bit messy, but It seems like the community has come to tolerate it. A few lessons for developers of these tools:
- Your *project name* should match your *package name*. Abbreviating and rearranging words _will_ confuse people.
- Making a function like `render` work better is great, but if your function behaves differently, you've got to come up with another name. That's the rule. If you really can't, do something responsible. For example, use a name spacing convention in all your examples: instead of `import { render } from MyLib`, use `import MyLib from 'my-lib'; MyLib.render(<Yeah />);`. Not great, but clearer.
- Re-exporting all the functions of another package is a sign that you're not adding any abstraction. This is ultimately a net increase of complexity in the ecosystem. Just recomment people use the other package directly.