---
layout: post
title: "Intermittent Selenium Failures"
date: 2010-11-19
comments: false
url: /2010/11/intermittent-selenium-failures.html
permalink: /2010/11/intermittent-selenium-failures.html
tags:
 - selenium
 - javascript
 - tdd
---

Selenium testing is always a little flakey, but I've found a good treatment for this on my last two projects. It's pretty simple, really:  
  
_If you are using external Javascript services, turn them off._  
  
This includes Google Analytics, Kiss Metrics, Share This, etc. The number of these services has exploded in the last couple years, and it's hard to build a site that doesn't use at least a couple. These tools do what they can to not interfere, but in the fast-paced world of Selenium, they don't always survive. Just remove them for these tests and you'll see marked improvement.  
  
Actually, that reminds me of a good talk I heard the other night. It was by Marcus Westin and Martin Hunt  of Meebo, and they talked about developing he "Meebo Bar". They figured out some really cool tricks to load asynchronously and not interfere with the host website-- but even better, supporting security contexts client side (which is pretty nifty if you think about it.) I actually think you could build a pretty clever SSO (single sign on) solution using these patterns, but I haven't tackled that one yet. Check the [slides](http://assets.en.oreilly.com/1/event/44/Building%20Fast%20Webapps,%20Fast%20_Lessons%20From%20Creating%20the%20Meebo%20Bar_%20Presentation.ppt) and [presentation](http://www.youtube.com/watch?v=b7SUFLFu3HI).  A must read if you're developing your own widget.  
  
Credit where credit's due: it was Justin and Jonah (different companies, different projects, not brothers) who identified this problem, not me.

