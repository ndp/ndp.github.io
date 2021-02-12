---
layout: post
title: "Interesting Character Entities"
date: 2011-05-03
comments: false
url: /2011/05/interesting-character-entities.html
permalink: /2011/05/interesting-character-entities.html
tags:
 - experience
 - entities
 - design
 - javascript
 - exploration
 - mini-project
 - html
 - cheatsheet
---

I spent a couple hours on [my character entity finder](http://amp-what.com/), and wanted to share some interesting things I've discovered. I made two main improvements:  
(1) lookup happens asynchronously, in small batches, so that it suffers less from "locking up". This allows much more flexible exploration.  
(2) allow you to bookmark queries, so you can share interesting discoveries.  
  
To recap, I built this tool to find all the weird quotes:  
  
[http://amp-what.com/#q='](http://amp-what.com/#q=')  
[http://amp-what.com/#q=quot](http://amp-what.com/#q=quot)  
  
Wow, I discovered there's a nice set of chess pieces:  
  
[http://amp-what.com/#q=chess](http://amp-what.com/#q=chess)  
  
Just a minute ago, I added the ability to bypass the query builder-- if you enter a full regular expression. The regular expression is matched against entity names (and numbers, and nicknames). For example, there are all sorts of icons available:  
  
[http://amp-what.com/#q=/97[2-6]\d/](http://amp-what.com/#q=/97[2-6]\d/)  
The currency symbols aren't easily found with a single query, but you can build a page with a selection of them:  
  
[http://amp-what.com/#q=/currency|euro|dollar|pound/](http://amp-what.com/#q=/currency|euro|dollar|pound/)  
  
It's surprisingly fun to play around with. Give it a spin.

