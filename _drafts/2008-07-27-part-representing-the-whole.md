---
layout: post
title: "Part representing the whole"
date: 2008-07-27
comments: false
url: /2008/07/part-representing-the-whole.html
permalink: /2008/07/part-representing-the-whole.html
tags:
 - rails
 - ruby
 - java
---

In 1986, not knowing what to write about for my Canterbury Tales paper, I took on the concept of metonymy. How a small section of the text represented, or encapsulated, the whole story, at least an important notion of it.  
  
When discussing Ruby with my fellow developers at Carbon Five, what used to be a heavy Java shop, I deja vu. Permit me to explain.  
  
Java, an its core, is all about interfaces. At the most basic level, when defining a function, you must describe what parameters it accepts, what type they are, what object it returns (if any), and what exceptions are expected to occur.   
  
This basic language construct, along with the aesthetic that inspired it, influences how the code is built and documented. You group these together into "interfaces", and those in turn can be packaged together. Sun provided very rich and detailed documentation for the core libraries (and all various ones that followed on). Probably the greatest success of Java is the ability to put together different libraries (packages) freely, reason about how they will behave. This, coupled with the open source movement (and its availability on the internet), as made Java an attractive and powerful environment.  
  
Ruby is not Java. Coming from Java (or C++, or other "high-level languages") can be a bit of a shock. There is no interface to a function; it's just a scope (module), name and the "arity" property (which tells you how many parameters it accepts).   
  
I was in shock when I first started using Ruby. This core concept of Java is just isn't there in Ruby. In fact, it's denied. A function has a name, but that's about it. You can ask how many parameters it accepts, but nothing about their names or types. But it gets worse: many of the libraries seem flexible and intentionally vague about how you call them and what they'll do. Like code written in the ?, they accept this, or that, depending. For example, the active record base methods "find" can accept a veritable smorgosboard of parameters. Have the ID? send it. Have a set of IDs? "Pass 'em in". As an array or separate parameters? "I don't care". How about a WHERE clause? Sure. Sorting? Yep. Even add joins to your heart's content.  
  
It's impossible to envision what this would look like it Java-- it wouldn't exist.   
  
Documentation is simple.  
  
Somewhat more modular, in that only address single attribute.

