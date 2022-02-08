---
layout: post
title: "Testing React is Testing Me"
date: 2021-11-09
comments: false
tags:
- software development
- testing
- react
- sheetshow
---

# Testing React is Testing Me

I needed to help a student at @techtonica write a test for a React component. It wasn't the simplest, as it called a backend API for its data, but it shouldn't have been as hard as it was. 

Whereas high-level components actually made it easier to test code, by separating out concerns, hooks mushed everything together. I didn't understand how this was supposed to work, and resisted hooks initially, waiting for the testing patterns to emerge. I can't find them!



I was a "jumping back in" to testing React after a couple of years. (I've been noodling on [Thoreau](https://github.com/ndp/thoreau) and [gauge](https://gauge.org/). Last time I'd written React, it was fancy with Enzyme and Jest. I weathered the transition from Jasmine to native-Jest tests. Jumping back in, I was surprised and disappointed at how quickly disruptions piled up:

- evolution of Jest and configuration changes, [version 23 or 24](https://testing-library.com/docs/react-testing-library/setup#jest-24-or-lower-and-defaults) or [version 27](https://testing-library.com/docs/react-testing-library/setup#jest-27)? 
- abandonment of Enzyme
- abandonment of class-components for "functional" ones, coupled with adoption of hooks to write code (although leen information on how to test components that use hooks).
- addition of [React Testing Library](https://testing-library.com/docs/react-testing-library/intro/)
- inconsistent naming of libries, such that the names don't always match the package names.

Mocking seems to have evolved in different ways, and it's hard to find any two example that agree on what a `mock()` function should do. There are, in fact, at least 4 ways to mock a module using jest, as explained [here](https://jestjs.io/docs/es6-class-mocks). The designers of this library could have helped users by coming up with simpler usage patterns.


Half the examples feature setup/teardown blocks to place the rendered component in the DOM, and the other half seem to skip this step. (Or maybe they just don't show it.) The secret is that the code examples are using two different `render` methods from different libraries, and if you're not tuned into this, you'll miss it.  It's the generically named "React Testing Library" to the rescue here, as it's got it's own `render` method that obviates the need for this setup and teardown code. Progress, but a bit subtle for someone trying to digest all the libraries. To make things slightly more confusing, it's a commonly recommended practice to override one of these `render` methods in the test setup code, to inject whatever context your app needs. Readers are suitably confused when they see `render` in a test.

I discovered quickly that React-testing-library re-exports all dom-testing-library utilities. Good luck if you skip the last sentence of paragraph 4: "so, in the next examples, we will import from @testing-library/react instead of @testing-library/dom." 

Here's a brief overview of relevant libraries:

* The React site itself points you here: https://reactjs.org/docs/testing.html. This gives you a somewhat incomplete answer to testing react components.
* [*Jest*](https://jestjs.io/) is a JavaScript test runner that lets you access the DOM. This is what most React tests are built upon.

* *React DOM* is the library where `render` comes from in your normal React app. It's intuitive and many example show [writing tests with this ReactDOM.render() method](https://noriste.github.io/reactjsday-2019-testing-course/book/intro-to-react-testing/react-dom-test-utils.html). This can be slow and cumbersome and more than some tests need. This technique requires setup and teardown methods to make sure the DOM is ready and cleaned up after tests. Streamlined tools like Enzyme and then DOM Testing Library came in to solve these problems. Sadly, examples using technique look quite similar but are not compatible with DOM Testing Library.

* *DOM Testing Library* is a very light-weight solution for testing DOM nodes. It just looks for nodes in a DOM tree, like `getBy` and `queryBy`.  You need this when you're in the process of writing a test, but you'll need to [skim the documentation](https://noriste.github.io/reactjsday-2019-testing-course/book/react-testing-library/dom-testing-library.html) before you start writing tests so you know what's there.

* [Test Utilities, ReactTestUtils, or `react-dom/test-utils`](https://reactjs.org/docs/test-utils.html#) looks to be outdated. Watch out for these examples and the inconsistent naming here. It has an `act` method, but you're better off heading for `React Testing Library`.

* *React Testing Library* (in package.json is known as `@testing-library/react`) is a set of helpers on top of DOM Testing Library to let you test React components. This is a higher-level library than others, and a good place to start if you're looking for working examples. Here's an intro: https://noriste.github.io/reactjsday-2019-testing-course/book/react-testing-library/. There are both familiar and unfamiliar function signatures here: it re-exports some stuff from DOM Testing library, and introduces its own `render` method that work well for most tests. Be careful of the overloaded names.

There are 

- render: test-utils -> @testing-library/react
- fireEvent: test-utils -> @testing-library/react
- waitFor: test-utils ->  @testing-library/react

[ReactJSDay 2019 Testing Course](https://noriste.github.io/reactjsday-2019-testing-course/) has sorted it all out and has good, working examples to work from. I'd recommend that over the many medium posts and outdated stackoverflow posts.

A few lessons from this situation for developers:
- Your *project name* should match your *package name*. Abbreviating and rearranging words _will_ confuse people.
- Making a function like `render` work better is great, but if your function behaves differently, you've got to come up with another name. That's the rule. If you really can't, do something responsible. For example, use a name spacing convention in all your examples: eg. `import MyLib from 'my-lib'; MyLib.render(<Yeah />);`. It's not only less confusing, it's better branding!
- Re-exporting all the functions of another package is a sign that you're not adding any abstraction. This is ultimately a net increase of complexity in the ecosystem, and just have people use the other package directly.