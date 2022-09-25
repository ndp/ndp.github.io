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

While helping a student at @techtonica write a test for a React component, what would seem to be a trivial task, I discovered a mess just under the surface of React testing.

## What I Found

I  jumped back in to testing React (after a couple of years of React-free and noodling on [Thoreau](https://github.com/ndp/thoreau), [gauge](https://gauge.org/) and [Playwright](https://playwright.dev/).) Last time I'd written React, I used Enzyme and Jest, although Enzyme was on its way out. I weathered the transition from Jasmine to native-Jest tests, but I wasn't ready for the transitions that had piled up during my absence. Jumping back in, I discovered:

- incompatible Jest configuration changes, [version 23 or 24](https://testing-library.com/docs/react-testing-library/setup#jest-24-or-lower-and-defaults) or [version 27](https://testing-library.com/docs/react-testing-library/setup#jest-27)? 
- abandonment of Enzyme (but 1000s of examples abound) on Google
- The big change we all know about: the abandonment of class-components for "functional" ones, coupled with adoption of hooks to write code. But I was surprised on how little information there is on testing hooks within components.
- the addition of [React Testing Library](https://testing-library.com/docs/react-testing-library/intro/), replacing many other solutions.
- inconsistent naming of libries. For example, names of libraries don't always match their package names, so to a new person, the system seems more complicated than it actually is.
- Mocking seems to have evolved in different ways, and it's hard to find any two example that agree on what a `mock()` functions do. There are, in fact, at least 4 ways to mock a module using Jest, as explained [here](https://jestjs.io/docs/es6-class-mocks). The designers of this library could have helped users by coming up with simpler usage patterns.
- Render means different things to different people. Documentation is confusing because half the examples feature setup/teardown blocks to place the rendered component in the DOM, and the other half seem to skip this step. It's not clear when copying code from StackOverflow and blogs whether there's code omitted. 
  
  The surprise here is that the code examples are using two different `render` methods from different libraries. Gotcha! If you're not paying attention, you'll miss it.  The generically named "React Testing Library" is responsible, with it's own `render` method to remove the frustration of needing a setup and teardown step for all tests. This goal is commendable, but using the same name is inexcuseable. 
  
  To make this slightly more confusing, for quite some time it was recommended practice to override the DOM `render` methods in the test setup code, to inject application-specific context. This cleaned up tests, but it also adds a third possibility of what `render` might mean. Readers are suitably confused when they see `render` in a test.
- As a not particularly helpful convenience, `react-testing-library` re-exports all `dom-testing-library` utilities. The same names mean the same thing, but you would not be crazy to wonder. Good luck if you skip the last sentence of paragraph 4: "so, in the next examples, we will import from @testing-library/react instead of @testing-library/dom." 

## Orientation

Given all that, here's a brief overview of relevant libraries:

* (Not recommended) The React site itself points you here: https://reactjs.org/docs/testing.html. This gives you a somewhat incomplete answer to testing React components. 
* [**Jest**](https://jestjs.io/) is a JavaScript test runner that lets you access the DOM. This is what most React tests are built upon. It gives you what you need out of the box quite without fuss.
* **React Testing Library** (in package.json is known as `@testing-library/react`) combines useful functions of _DOM Testing Library_ with a set of convenient helpers, to provide a unified place to look to test React components. This is a higher-level library than others, and a good place to start if you're looking for working examples. Here's a nice intro: https://noriste.github.io/reactjsday-2019-testing-course/book/react-testing-library/. There are both familiar and unfamiliar function signatures here: it re-exports some functions from DOM Testing library, and introduces its own `render` method that work well for most tests. Be careful of the overloaded names! But this + Jest and you should be good to go.
* **React DOM** is the library that implements `render`  in your production React app code. The initial approach to testing components used this, and there are many example that show [writing tests with this ReactDOM.render() method](https://noriste.github.io/reactjsday-2019-testing-course/book/intro-to-react-testing/react-dom-test-utils.html). Using this, you're testing the real-life code and behavior with a real DOM library. But this technique requires setup and teardown methods to make sure the DOM is ready and cleaned up after tests. It become tedious. Streamlined tools like Enzyme and then DOM Testing Library came in to solve these problems. Sadly, examples using technique look similar _but are not compatible with_ DOM Testing Library. You'll use this in your app, but not your testing-- but watch for examples that use it.
* **DOM Testing Library** is a very light-weight solution for answering questions about DOM nodes. It looks for nodes in a DOM tree, using `getBy` and `queryBy`.  The usage is a bit surprising, but works. You definitely need to [read the documentation](https://noriste.github.io/reactjsday-2019-testing-course/book/react-testing-library/dom-testing-library.html) before you start writing tests, so you know what's there.
* The thrice named [Test Utilities, ReactTestUtils, or `react-dom/test-utils`](https://reactjs.org/docs/test-utils.html#) looks to be outdated. Watch out for these examples and the inconsistent naming here. It has an `act` method, but you're better off heading for `React Testing Library`.

## Wrap-up & Lessons

[ReactJSDay 2019 Testing Course](https://noriste.github.io/reactjsday-2019-testing-course/) has sorted it all out-- as of 2019. It's long but clear. It shows you all the ways to write tests and how they relate. It has good, working examples. I didn't find another source that described all the pieces like this site does. I'd recommend that over the many medium posts and outdated StackOverflow posts, but you don't need to read all of this.

## Lessons to Learn

To my eye, this is all a bit messy, but somehow the community tolerates it. Although I've touched on all this above, a few lessons I wish developers of these tools had learned:
- Your *project name* should match your *package name*. Abbreviating and rearranging words _will_ confuse people.
- Making a function like `render` work better is great, but if your function behaves differently, you've got to come up with another name. That's the rule. 
  If you really can't use a new name, do something that won't confuse. In this case, you could use a name-spacing convention in all your examples: instead of `import { render } from MyLib`, use `import MyLib from 'my-lib'; MyLib.render(<Yeah />);`. Not great, but less confusing.
- Re-exporting all the functions of another package is a sign that you're not adding any abstraction. No abstraction means more complexity. A move like this is ultimately a net increase of complexity in the ecosystem and can and should be avoided. Just recommend people use the other package directly.