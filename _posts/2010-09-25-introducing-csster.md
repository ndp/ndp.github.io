---
layout: post
title: "Introducing Csster"
date: 2010-09-25
comments: false
url: /2010/09/introducing-csster.html
permalink: /2010/09/introducing-csster.html
tags:
 - css
 - unit testing
 - javascript
 - sass
 - tdd
---

So I'm a bit of a CSS nerd. For years, I've been complaining that there's not enough "engineer" cycles given to CSS. I've written endless blog posts about how to organize your CSS. Blank stares when I ask interview candidates "how do you structure your CSS?"  Well, now we can [write CSS in Javascript](http://github.com/ndp/csster) with Csster, and maybe-- just maybe-- the world has been set right.  
  
  
In 2000, I ventured into teaching at[City College](http://ccsf.edu/). To be honest, I'd missed the dot com boom and didn't know anything about the web. I was really nervous, so checked out every book the school library had about web development, and studied (and learned) thoroughly. Since then, I built quite a few web sites for people, non-profits and businesses, and developed a certain amount of dexterity with CSS. CSS has evolved a bit in the last ten years, but this firm foundation of understanding of the cascade and such has served me well.  
  
Not to go off into a rant, but lots of CSS ends up a mess. I always felt like it, like C++, needed more restrictions and guidelines to turn out maintainable. I tried to enforce various guidelines with my teams.   
  
In the last year, there's been a renewed interested  in CSS and the tooling around it. With the advent of tools like SASS, it's starting to receive the engineering attention it's always deserved.  
  
I was a little hesitant to endorse Sass (or even try it). CSS already has too many "degrees of freedom"-- more flexibility seemed like a bad idea. It would make the problem worse. I poo-pooed it.  
  
Okay, stop laughing.  
  
Finally a couple weeks ago with some changes to my team, I was convinced to give it another shot. At the same time I started a new small project, so I just tried it out. This project was design and Javascript heavy, but small enough to back out if it wasn't working. Sass was OK, I decided, but I was still maintaining too much junk, and now there was this additional build step.  
  
On a Friday afternoon, I mentioned to my coworker Jeremy that what I'd really like is to just stay in Javascript. Javascript has this object literal format (JSON), and the whole hierarchy of CSS might just fit in.  
  
It was a bit of an idea that I just throw out, but over the weekend I pursued a spike implementation of what it would look like. Using test driven design, it came together much faster than I had anticipated. It was a usable tool. Alex at C5 coached me through fixing some of the color functions, and as near as I can tell it equals or exceeds Sass's feature set.  
  
In the last couple weeks I've used it extensively in my current project and it's great. Being in a real programming language really does make CSS nice.

Check out the [main project page](http://github.com/ndp/csster) on github.
