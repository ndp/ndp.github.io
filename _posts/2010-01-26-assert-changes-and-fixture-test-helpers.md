---
layout: post
title: "Assert Changes and Fixture Test Helpers"
date: 2010-01-26
comments: false
url: /2010/01/assert-changes-and-fixture-test-helpers.html
permalink: /2010/01/assert-changes-and-fixture-test-helpers.html
tags:
 - unit testing
 - rails
 - ruby
 - agile
---

About a year ago I posted some [test helpers for checking pre- and post-conditions during a test](http://blog.carbonfive.com/2009/04/testing/assert_changes-and-assert_no_changes-in-ruby). I called them " **assert_changes**" and " **assert_no_changes**".  They took a ruby expression to evaluate, a block, and did what you expected:

```
o.answer = 'yes' assert_changes 'o.answer' => ['yes','no'] do o.answer = 'no' end
```
  
Since then, I have discovered similar functionality in shoulda and rspec. But if you're using test unit, and you don't want to take the leap to shoulda (which is painless), I packaged up my test helpers into [a gem that's easy to install](http://github.com/ndp/ayudante). Plus, mine are a little easier to read, if you don't mind evaling strings within your tests.  
  
It's called "ayudante". To install,   

```
gem install ndp-ayudante
      --source=http://gems.github.com
```
  
Also included in the gem are " **fixture helpers**". These make it easy to test for sets and lists of your fixture model objects, without the hassle of building up your own lists and sets.   
  
On [goBalto](http://www.gobalto.com), Ingar had created something like it for testing Sphinx search results. We had sets of fixtures, and we wanted to make sure a search returned certain results-- sometimes contains, sometimes exact. Sometimes we didn't care exactly what the order was so we wanted set comparisons. Or we didn't care about extra items.  
  
Here's how it works. If you have a model object and fixtures for CandyBars, it adds test helper methods for **assert_list_of_candy_bars** (using #method_missing). Like all xUnit asserts, you pass the expected values (a list of symbols identifying the fixture objects), and the value you are testing.  
  

```
result =
      CandyBar.find(:all, ... ) assert_list_of_candy_bars [:mars, :eminem], result
```
  
It also supports **assert_set_of_candy_bars** , so you can ignore the order of comparisons; and **assert_contains_candy_bars** so you can make sure it results contain a subset. Enjoy! 
