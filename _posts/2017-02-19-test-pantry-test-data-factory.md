---
layout: post
title: "Introducing Test Pantry"
date: 2017-02-19
comments: false
url: /2017/02/test-pantry-test-data-factory.html
permalink: /2017/02/test-pantry-test-data-factory.html
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


On two recent Javascript data-based projects, we needed to data to feed into our tests. For many years I've used [Thoughtbot's Factory Girl](https://github.com/thoughtbot/factory_girl) for Ruby, but couldn't find the equivalent for Javascript. There are several, but I found the syntax baroque, and the benefits didn't justify the complexity. And of course in Javascript, because of the nice object literal format, it's pretty easy to just hard-code  test data yourself. And that must be what most people do. But as I built out more and more tests, I saw how a tool would help. So I created [Test Pantry](https://github.com/ndp-software/test-pantry).  

Test Pantry takes care of problems you run into when you do it yourself. **Common fields** or will appear across multiple object literals. Let's say all objects have unique IDs. Writing this into every single factory method is a bit tedious. Test Pantry allows you to DRY these up, and define a single factory trait and mix it into any of your model objects.  

Another hassle is having to create a network of objects, with inter-dependent relationships. With more than a couple objects, this grows complex. Test Pantry provides a couple tools to make this easier.  

Finally, I incorporated a unique feature to test data factories: seedable random data. Test Pantry will generate random values, but each factory has its own "seed" that causes a predictable sequence to be emitted. From the docs:  

```
pantry.recipeFor('randomSequence', function() {
 return this.randomInt(10)
})

pantry.randomSequence() // --\> 9
pantry.randomSequence() // --\> 6
pantry.randomSequence() // --\> 2
pantry.randomSequence() // --\> 5

pantry.randomSequence.reset() // let's start over
pantry.randomSequence() // --\> 9
pantry.randomSequence() // --\> 6 ...
```

This allows your tests to express that values don't matter (ie. `random`), but also assert that something isn't amiss. You can definitely live without this, but removing the "randomness" makes writing tests easier to maintain. More and more we're writing probabilistic code and having this at the core  speeds things up.  

If you are writing ECMA/JavaScript, and writing tests-- and who's isn't-- [check it out](https://github.com/ndp-software/test-pantry)! 
