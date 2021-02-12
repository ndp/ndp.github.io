---
layout: post
title: "Scrum, XP, Agile, and Visualizing the Difference"
date: 2009-09-24
comments: false
url: /2009/09/scrum-xp-agile-and-visualizing.html
permalink: /2009/09/scrum-xp-agile-and-visualizing.html
tags:
 - xp
 - scrum
 - lean
 - javascript
 - agile
 - visualization
---

Visualization of agile practices running here:  
  
[http://ndpsoftware.com/agile_methods/agile_methods.html](http://ndpsoftware.com/agile_methods/agile_methods.html) (If it seems to draw garbage all over the screen, refresh the page. More on that later.)  
  
What it shows is the main concepts of 5 different agile viewpoints: XP, Scrum, the Agile Manifesto, Lean and Getting Real. Important words for a practice are "attracted" to (gravitationally) to the practices that mention them in their canonical definition.

### Motivation
  
There are different flavors of agile. I discuss the differences coherently, but I wondered if there were some way to distill the differences down to something that could be represented in one page. A cheat sheet. All these practices share some history and concepts, but can be they be presented and compared in a fairly simplistic way? Each emphasizes different things, but how do they compare?  
  

### Building the Visualization
  
The first challenge was to identify the top few values and concepts that define each practice. My idea was to summarize each practice by finding the canonical description of each practice and capture the top concepts as succinctly as possible.   
  
So I identified a primary source for each practice. This is arbitrary but not capricious. I believe I was picking reasonable documents:  
  

  
1. XP: [http://www.extremeprogramming.org/](http://www.extremeprogramming.org/)  
2. Agile Manifesto: [http://agilemanifesto.org/](http://agilemanifesto.org/), [http://agilemanifesto.org/principles.html](http://agilemanifesto.org/principles.html)  
3. Scrum: Agile Software Development with Scrum, Chapter 9; and [http://en.wikipedia.org/wiki/Scrum_(development)](http://en.wikipedia.org/wiki/Scrum_(development))  
4. Lean Software: [http://en.wikipedia.org/wiki/Lean_software_development](http://en.wikipedia.org/wiki/Lean_software_development)  
5. Getting Real: from page 2 of the book  
  
  
Next, I needed to extract the concepts. I created a spreadsheet and listed concepts down the left side, and practices across the top. I put a number in any box where the practice mentioned the concept as one of its first. The first concept mentioned on the page got a "1", and the 10th one got a "10". I didn't collect concepts much beyond that. I ended up with a big grid with practices as columns and concepts as rows. As the terminologies of each practice differ, I had a sparse spreadsheet with only a few data points. It wasn't helpful in comparing the practices.  
  
So went through a normalization process. Is a "sprint" the same thing as an "iteration"? Well yes (and no). What's a "project heartbeat?" and is it the same thing? I combined rather aggressively the first time I did it, but what you see is a second, more conservative approach. There are still problems, but I took a pretty good shot.  
  
Even with the "normalized spreadsheet", though, it wasn't easy to compare the practices. I tried different sorting and coloring to no avail. I then tried different graphing options, starting first with "mind maps". I tried 3-d bar charts, but they were little help. And plotting the words in grids, but couldn't make it work.  
  
I finally stumbled upon the visual thesaurus metaphor. As a regular thesaurus, I always thought the display a bit gratuitous: a word in the center with its synonyms "floating around", connected by some gravity. The more I thought about it, though, the better fit it seemed.  
   
Next I needed a tool in which to implement my visualization. You can license the technology, but I had a $0 budget and just a few hours to devote to it. I looked at using Processing (a Java variant that lots of people are using to build visualizations); there were some implementations, but I wanted something even lighter weight if possible. After another Google or two, and I found Javascript-based experiments with "force directed graphs". I grabbed the code, and threw my data in it.  
  
Actually, there was a little engineering involved. I knew I would update the spreadsheet (and I wanted to add other practices potentially), so instead of converting the spreadsheet directly to the Javascript, I wrote a Ruby script that takes the spreadsheet and generates JSON data structures. The structures are then fed into a small engine I wrote, and the graphic is created.  
  
Code available [http://github.com/ndp/agile_methods](http://github.com/ndp/agile_methods)  
  
  
  
[![Creative Commons License](http://i.creativecommons.org/l/by-sa/3.0/us/88x31.png)](http://creativecommons.org/licenses/by-sa/3.0/us/)  
  
  
Agile Software Methodologies Visualization by [Andrew J. Peterson](http://ndpsoftware.com/agile_methods/agile_methods.html) is licensed under a [Creative Commons Attribution-Share Alike 3.0 United States License](http://creativecommons.org/licenses/by-sa/3.0/us/).  
Based on a work at [www.kylescholz.com](http://www.kylescholz.com/blog/2006/06/force_directed_graphs_in_javas.html). 
