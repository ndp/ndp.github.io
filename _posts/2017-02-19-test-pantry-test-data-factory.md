---
layout: post
title: "Introducing Test Pantry"
date: 2017-02-19
comments: false
url: /2017/02/test-pantry-test-data-factory.html
tags:
 - software development
 - unit testing
 - ES6
 - javascript
 - prototyping
 - mini-project
 - agile
 - mock objects
 - coding
 - expectations
---

  
On two recent Javascript projects, we needed good tools for building test data. I'm used to [Thoughtbot's Factory Girl](https://github.com/thoughtbot/factory_girl) for Ruby, but didn't find the equivalent. There are several around, but the syntax is picky, and it didn't seem like they offered enough advantages over going it alone. In Javascript, because of the nice object literal format, it's pretty easy to just hard-code yourself, and that must be what most people do. But having a few tools to make it easier really helps, so I created [Test Pantry](https://github.com/ndp-software/test-pantry).  
  
This library takes care of some of the problems you run into when you do it yourself. For example, all of your objects may have unique IDs, but writing this into every single factory method is a bit tedious. Test Pantry allows you to define a single factory/trait such as `has-id`, and mix it into any all your model objects.  
  
Another mess is creating networks of objects with relationships to each other. Custom-built functions get complex fast. Test Pantry provides a couple tools to make this easier.  
  
Finally, I&nbsp;incorporated a unique feature to test data factories: seedable random data. Test Pantry will generate random values, but each factory has its own "seed" that causes a predictable sequence to be emitted. From the docs:  

```
pantry.recipeFor('randomSequence', function() {
 return this.randomInt(10)
})

pantry.randomSequence() // --\> 9
pantry.randomSequence() // --\> 6
pantry.randomSequence() // --\> 2
pantry.randomSequence() // --\> 5

pantry.randomSequence.reset() // let's start over
pantry.randomSequence() // --\> 9&nbsp
pantry.randomSequence() // --\> 6 ...
```
  
 This allows your tests to express the notion that they don't care what the data is, but at the same time make assertions about the results. You can definitely live without this, but removing some of the "randomness" makes writing tests quicker. More and more we're writing probabilistic code&nbsp;and having this at the core really speeds things up.  
  
If you are writing ECMA/JavaScript, and writing tests-- and who's isn't--&nbsp;[check it out](https://github.com/ndp-software/test-pantry)!