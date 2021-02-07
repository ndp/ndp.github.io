---
layout: post
title: "Unit testing time"
date: 2007-11-01
comments: false
url: /2007/11/unit-testing-time.html
permalink: /2007/11/unit-testing-time.html
tags:
 - unit testing
 - Date class
 - mock objects
 - java
---

We've all run across the problem of trying to unit test some code that is dependent on the current date. Such as:  
  
` public String elapsedTime(Date d) {
      final Date now = new Date(); final long ms = now.getTime() - d.getTime(); return "" + ms /
      1000 + " seconds ago"; }`  
  
How do you test something like this? (or something more sophisticated and useful)  
  
I found the solution in a posting about mock objects. The trouble is that this code is depending on the Date class, and its behavior of getting the current time. Imagine a Clock interface:  
  
` interface Clock {
      Date getNow(); }`  
  
and then a rewritten elapsed time:  
  
` public String elapsedTime(Date d, Clock clock) { final Date
      now = clock.getNow(); final long ms = now.getTime() - d.getTime(); return "" + ms / 1000 +
      " seconds ago"; }`  
  
Obviously the Clock can be injected in other ways, but now we have a testable and extensible method.

