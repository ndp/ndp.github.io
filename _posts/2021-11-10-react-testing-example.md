---
layout: post
title: "Simple Example of Testing a React Component"
date: 2021-11-10
tags:
- software development
- testing
- react
- mocking
- jest
---

Here's a simple example of a React component test. There are lots of examples of this out there, but most of them are outdated. I couldn't find one that showed exactly what I wanted: 
  - waiting on a promise
  - mocking

The following example works as of November 11, 2021 with this setup:

```sh
$ npx create-react-app react-testing
...
$ cd react-testing
$ yarn test
```
---
We'll start out with the component:

{% gist 24b0bbac24ba40d750e62fd30bf2c936 Tile.jsx %}

The service is as simple as can be: 

{% gist 24b0bbac24ba40d750e62fd30bf2c936 thing-api-service.js %}

Now, to write a test, use `@testing-library/react`, asserting that the data provided by the service shows up:

{% gist 24b0bbac24ba40d750e62fd30bf2c936 Tile.test.jsx %}

Then, to add in mocking. Here is one way (there are several different ways that work):

{% gist 24b0bbac24ba40d750e62fd30bf2c936 Tile.with-mocking.test.jsx %}

