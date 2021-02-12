---
layout: post
title: "Exploring Dependency Injection in Javascript"
date: 2013-07-07
comments: false
url: /2013/07/javascript-dependency-injection.html
permalink: /2013/07/javascript-dependency-injection.html
tags:
 - software development
 - design
 - javascript
 - exploration
 - coffeescript
 - tdd
 - AngularJS
 - coding
---

Over the last month I've been wrapping my head around Angular JS. I ended up exploring Dependency Injection in depth, and I'd like to share my experiments.

Angular uses dependency injection everywhere. Dependency Injection, or "DI", means instead of using or looking up a service in the global name space, it is passed in to the code, or "injected." In the early 2000s in the Java world, when the Spring dependency injection framework came out, there was much rejoicing. A very basic example shows the principal:

<script src="https://gist.github.com/ndp/5915878.js?file=example.coffee"></script>

`console` is passed in, instead of being referenced off the global object. The advantages are:

1. A different console can be substituted. This is great for configuration, as you can write use a file-based logger without any change to client code. 
2. This is also good for testing, as you can very easily send in a mock console. But for the testing use case, it is less critical in Javascript than Java, because in Javascript it's straightforward to [replace nearly any function.](https://github.com/pivotal/jasmine/wiki/Spies)
3. We are not accessing some global value anymore, so the code is more modular. It can run in any environment, whether it has a global console or not. And if we want to change what console does in one part of the code and not the other, we have that level of control.

The disadvantage is simply that you need to find the service and inject it. Since passing services in everywhere becomes burdensome, DI frameworks automate this injection.

If you're familiar with the nodejs/require, you might think it's equivalent, but it's not. The require asks for a specific global resource explicitly. DI gives a level of indirection and allows plug in different resources.


#### What Angular Dependency Injection Looks Like

Within Angular, dependencies are injected using function parameters. This is a reasonable, functional language choice. Angular is responsible for calling the function with those dependencies injected. Let's say you have a couple services: 

<script src="https://gist.github.com/ndp/5915878.js?file=services.coffee"></script>

Here's a third service that uses them:

<script src="https://gist.github.com/ndp/5915878.js?file=angularStyleService.coffee"></script>

It's easy to define, but there's some awkwardness here: a function that returns another function? Ugh. It takes a while to be able to read through this code easily, since this pattern is nearly everywhere.

Now to call our service, we need it to be injected with its dependencies, which is also a little awkward, but accomplished with an additional function wrapper:

 <script src="https://gist.github.com/ndp/5915878.js?file=angularStyleInjectorSpec.coffee"></script> 
#### What Angular Dependency Injection REALLY Looks Like


Quickly you run into different ways to define functions within Angular. Since [Google's Closure Compile](https://developers.google.com/closure/compiler/docs/compilation_levels), and many other code compressors will rename parameters to save a few bytes, this technique doesn't work. So the solution worked out was to declare an array that lists the injected variables along with the function:

<script src="https://gist.github.com/ndp/5915878.js?file=angularStyle2.coffee"></script>

This ends up looking pretty awkward to my eye, and I was wondering if there was a better way.

 

Well, first I had to deconstruct how Angular does it.


#### How the magic is implemented

How this works is interesting. The secret behind all of this is something I found a little counter-intuitive: when you call `toString` on a function object, you get the actual text of the function. For example here is a useful function:

 <script src="https://gist.github.com/ndp/5915878.js?file=fnTextWithoutComments.coffee"></script> 

> (Below are snippets of _my code_, not Angular, although much is based on techniques in Angular code.)

For DI, Angular needs to know the argument names. In order to figure this out, Angular uses regular expressions. I found other DI frameworks that build a parse tree to identify these, but in this case, a regular expression suffices. I extracted Angular logic into its own function:

 <script src="https://gist.github.com/ndp/5915878.js?file=argumentNames.coffee"></script>

The final piece is to put it together: figure out the arguments and then call the function with the correct services:

<script src="https://gist.github.com/ndp/5915878.js?file=angularStyleInjector.coffee"></script> 

For DI, you need some way to discover the objects that are injected. I think this works well as a separate concept, so I define a stub service locator, which given a name, returns the right service:

 <script src="https://gist.github.com/ndp/5915878.js?file=serviceLocator.coffee"></script> 
#### Alternative Technique #1


So I wondered is there a more concise way to do this dependency injection. Creating a whole new function just to set the injected variables seemed like overkill. I started noodling... a thing about Angular you notice right off is the `$scope` object. It's an injected parameter that is used to communicate between the controller and views. By having `$scope`, most code doesn't use the `this` context object much. Could we simply call the service with all the injected parameters in a `this` context object? (Yes, there are newer Angular approaches that use it more than most of the sample code, but let's not worry about that, shall we?)

The definition of the service is simpler. There's no need for nested functions returning functions. Simply reference variables associated with this context or in Coffeescript, `@` variables:

 <script src="https://gist.github.com/ndp/5915878.js?file=contextStyleInjectorService.coffee"></script> 

And the call is identical to the Angular style:

 <script src="https://gist.github.com/ndp/5915878.js?file=contextStyleInjectorCall.coffee"></script> 

The injector itself isn't more complicated than the angular one. Using building blocks in the other parts of the code:

 <script src="https://gist.github.com/ndp/5915878.js?file=contextStyleInjector.coffee"></script>

It depends on this function `members`, which looks through the whole function body for references off of `this`.

<script src="https://gist.github.com/ndp/5915878.js?file=members.coffee"></script> 

(Perhaps it's naive to think that this is going to work in practice. I'm not sure. I do realize it will falsely match nested function references, and "over-inject". And if `this` references are renamed `self` or `that`, it's not going to work without modification.)

In this implementation I'm not telling it what to inject, following the Angular technique of sucking them out of the source code automatically. I see a couple advantages over Angular's:

1. The definition is simpler, without functions returning functions. Although identifying injected services is harder.
2. This technique is less susceptible to the drawbacks, as [Google's Closure Compile](https://developers.google.com/closure/compiler/docs/compilation_levels) will not rename properties in the SIMPLE_OPTIMIZATIONS mode.

#### Experiment #2: Objects

JavaScript has dual nature. It has functions, but it also has objects. So let's look at using an object as the base for injection.

(I'm going to avoid Coffeescript's `class`, so as to avoid any questions as to how it behaves in reference to raw Javascript. It should work well here, though.)

 

We'll see both the object definition and the call:

 <script src="https://gist.github.com/ndp/5915878.js?file=objectFnInjectorSpec.coffee"></script> 

We will do what we just did in Experiment #1, but once for each function of an object. <script src="https://gist.github.com/ndp/5915878.js?file=objectFnInjector.coffee"></script>

We find all the functions and then from there find all the needed services, and inject them into the object.


#### Experiment #3: Explicit Objects

The magic hunting around for function names isn't that comfortable, we can be explicit. In this definition of an object will simply indicate the names of the services that are required, so it's clear they need to be injected:

 <script src="https://gist.github.com/ndp/5915878.js?file=explicitObjectInjectionSpec.coffee"></script> 

If you are still with me, you should be able to appreciate the implementation:

<script src="https://gist.github.com/ndp/5915878.js?file=explicitObjectInjection.coffee"></script> 
#### Conclusions?

Dependency Injection will never be as important in Javascript as it is in Java, but still is a valuable tool.

For Angular, I see how Experiment #1 is an interesting technique. But there are three, or maybe four techniques already in use there, and to be honest, and adding another wouldn't help matters. That ship has sailed. I like the technique nonetheless.

For Coffeescript or pseudo-class system, one of the object-oriented techniques will be natural. Experiment #3 would fit in very nicely with a BackBone app.

 

I'm sure there are other ways to do this... this is my riffing on just one direction. What do you think?

