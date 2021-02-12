---
layout: post
title: "Getting paid by LOCs?"
date: 2012-01-16
comments: false
url: /2012/01/getting-paid-by-locs.html
permalink: /2012/01/getting-paid-by-locs.html
tags:
 - software development
 - ruby
 - agile
 - git
 - coding
---

I don't get paid by the lines of code I write. But I've certainly joked about it: there's a rumor that Trevor, who writes way too many comments, gets paid by the line (including comments). Über-programmer Dave things his manhood is measured by the size of his commits. On a recent project the codebase was so large that I joked that every commit should be rejected if it didn't reduce the line count of the project. Haha.

  

This brings me to the boy scout rule: always leave the code nicer than when you started. This can be a little hard to quantify with a number: [test coverage](http://blog.james-carr.org/2009/10/01/beware-code-coverage-metrics/), [cyclomatic complexity](http://www.ibm.com/developerworks/java/library/j-cq03316/) and [coupling](http://clarkware.com/software/JDepend.html) metrics are all often used. But with a bloated codebase, a simple line count reduction may suffice to improve the codebase, although is not the [main](http://www.thoughtclusters.com/2011/04/refactoring-is-not-about-reducing-code/)[goal](http://www.refactoringredmine.com/refactoring-to-reduce-code/). In my casual joking about this with my teammates, they all liked it. But how?

  

**How to Count**

  

If you use git log --stat, you can see the number of lines associated with each commit (after all the details), such as:

  

331 files changed, 0 insertions(+), 25866 deletions(-)

  

It's pretty easy to write a script that parses this information out, and [that's what I've done in gitlc tool](https://github.com/ndp/gitlc). Beyond the obvious grep, I added support for some necessities:

- "pairs" set up using the git-pair tool. Commits checked in by multiple people will be credited to all committers. This is necessary with any project where pairing is used.
- "aliases", so that if the same person commits with different email addresses (or it changes throughout the lifecycle of the project), the commit counts can be aggregated. This optional feature can be used by providing an optional yaml file.
- commits can be aggregated by person, month, or simply by commit
  

Usage is pretty simple. Just download it and point it at a local directory with a .git folder. Here's gitlc source itself and ask for a summary by person:

  

$ ./gitlc.rb -r . -p

[["ndp", {:net=>657, :adds=\>26579, :deletes=\>25922}]]

  

As you can see, I had a 25K of code, which I abandoned quickly (thanks node). For projects with more people, it's more interesting:

  

./gitlc.rb -p -r ../ruby-build/

[["sam", {:net=>499, :adds=>639, :deletes=>140}],

 ["jeremy", {:net=>33, :adds=>50, :deletes=>17}],

 ["josh", {:net=>21, :adds=>41, :deletes=>20}],

 ["jesse", {:net=>16, :adds=>21, :deletes=>5}],

 ["guilleig", {:net=>11, :adds=>53, :deletes=>42}],

 ["bensie", {:net=>6, :adds=>6, :deletes=>0}],

 ["chris", {:net=>6, :adds=>29, :deletes=>23}],

 ["sstephenson", {:net=>5, :adds=>5, :deletes=>0}],

 ...

  

The tool sorts people by their "net" contribution to the project. For ruby-build, there's a long-tail of people with 1 line changes omitted.  Please [check out gitlc](https://github.com/ndp/gitlc) and see what you learn about your project.

  

I'd love to have contributes to this tool. Feel free to fork and contribute back. It's easy to imagine better visualizations and a tool that could be incorporated in a workflow.

  

**Practicalities**

  

When you've got these statistics, and people start to care about their line count number. People ask me what to do if you need to write new functionality? 

  

I recommend:
  
  

- Look first to share code. In a relatively large codebase, most features should already be there, but perhaps in a slightly different form. Most codebases bloat because we aren't able to figure out the common patterns. We can blame this on a hazy product definition, but at some point it's our responsibility to organize and structure the code ourselves.
- Look for dead code. What features and code are no longer used?  Get code coverage tools running, which help you identify branches of code that you can remove. Use web analytics to discover pages that are seldom visited and advocate to cut them out. 
  

Riffing on the last point, a corollary to this blog post is the one that says each story needs to be accompanied by an "unstory". If we add a link to this page, what link do you want to take away? If the user can now spend 20 minutes cropping their profile picture, what aren't they going to be doing? But that's left for another day...
