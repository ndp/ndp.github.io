---
layout: post
title: "Page-by-page Rewrite Refactor"
date: 2010-05-27
comments: false
url: /2010/05/page-by-page-rewrite-refactor.html
permalink: /2010/05/page-by-page-rewrite-refactor.html
---

At work today, the question came up (again) about how to approach upgrading a legacy app. There were many great comments, falling in the range from writing UI testings and using incremental rewrites, all the way to talking the client out of it. (Talk them into a v2!) What's similar between them all is that they feel "big", and therefore risky. 
  

Here's one of my successful experiences doing a rewrite in an agile, incremental way.  A few years ago I was hired on at [GreatSchools](http://greatschools.org/) to rewrite a large, aging, popular Perl web site. The overall goal was to rewrite, but the correct strategy wasn't set. We ended up doing a page-by-page rewrite-- one URL at a time-- into Java.
  

This a little different than what you would do in a non-web app. Usually you have to divide an application into modules and rewrite one at a time, finding the "seams", or create them if they don't exist. On these types of projects, finding those seams in a large, spaghetti codebase can feel impossible. Creating seams may mean layering on unit or integration tests to make sure you don't break things along the way. See [Working Effectively with Legacy Code](http://www.amazon.com/Working-Effectively-Legacy-Michael-Feathers/dp/0131177052), 

  

The web, though, is a unique beast. It doesn't care if the form is presented with Ruby and processed with Java. The idea is you keep the legacy app going, and replace pieces-- one URL at a time. We went down this path because we had lots traffic driven by organic search, so we didn't want to change URLs anyway. It turned out to be pretty low-risk and was successful. 

  

**Practicalities**

  

  

_The workflow was simple:_

1. pick a page.
2. implement that in the new technology
3. deploy and tweak proxies to serve the new page instead of the old version
4. deal with any fallout
5. repeat

Of course sometimes we did more than one page at a time, but you get the idea.  Eventually we could just turn off the old app.  

  

**Concerns**

  

My initial concern was that we were making it much more complicated system than necessary, but it wasn't as complicated as I suspected-- HTTP provides a clean interfaces on each page. Although it can be difficult to read Perl code that processes a page, we could see all the parameters that were expected (with help of our web analytics), and make sure we supported them.

  

This approach is different than other rewriting approaches in that we didn't write any tests against the legacy app-- no need.  But we did write new code up to an acceptable quality standard, with solid test coverage.

  

We did have a small amount of  extra code we need to write to support running in parallel, sharing cookies, dbs, and eventually HTML partials. In the end, though, I'm not sure that much of this work was extraneous, as we needed to deal with users migrating between the systems anyway-- whether it was to make it transparent like we did, or needed communication about "version 2".

  

I'll admit the business logic wasn't that complicated-- but it was a large, high-traffic site. 

  

The biggest risk is that you get 1/3 of the way in and abandon it-- then you have a bigger mess. But I'm not sure this is much worse than other approaches. It's nice if you like incremental delivery, as it will get your changes up the fastest of all the suggestions. 

  

**Is It Right for Me?**

  

When people at a company start talking about a "rewrite", the team-- not only the developers-- want to reconsider everything-- basically doing a whole new site. This case was no different, and when I arrived it was framed as a "site redesign". So a page-by-page approach-- without a holistic view-- might seem like an odd approach. In the end, though, we didn't have the resources necessary such a project requires (think two teams). Like migrating code, it was easier to do incremental redesigns. Approaching the project page-by-page turned out to be ideal. As we re-implemented pages, we reconsidered them, and often significantly improved them. Although we re-implemented existing pages, we also introduced new pages when it made sense.

  

The benefits of being able to proceed incrementally far outweighed that cost. 

  

