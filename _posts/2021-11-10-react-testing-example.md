---
layout: post
title: "Simple Example of Testing a React Component"
date: 2021-11-10
comments: false
url: /2021/11/react-component-test-example.html
permalink: /2021/11/react-component-test-example.html
tags:
- software development
- testing
- react
- mocking
- jest
---

I put together a simple example of a React component test. There are lots of examples of this out there, but most of them are outdated. This just shows the basics of testing a component with an external service that you want to mock.

First, we'll start out with a simple component:

{% gist 24b0bbac24ba40d750e62fd30bf2c936 Tile.jsx %}

The service is as simple as can be: 

{% gist 24b0bbac24ba40d750e62fd30bf2c936 thing-api-service.js %}

Now, to write a test, use `@testing-library/react` and it's pretty straightforward:

{% gist 24b0bbac24ba40d750e62fd30bf2c936 Tile.test.jsx %}

Then, to add a mocking, here is one way (there are several different ways that work):

{% gist 24b0bbac24ba40d750e62fd30bf2c936 Tile.with-mocking.test.jsx %}

