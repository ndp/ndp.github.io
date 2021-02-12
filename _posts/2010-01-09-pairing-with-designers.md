---
layout: post
title: "Pairing with Designers"
date: 2010-01-09
comments: false
url: /2010/01/pairing-with-designers.html
permalink: /2010/01/pairing-with-designers.html
tags:
 - software development
 - design
 - agile
---

I've worked on software with designers for 15 years, ever since software had a visual design. Usually this involves being "handed off" designs, or providing "feedback", via email. Only occasionally have I worked side-by-side to solve visual design and interaction problems.  
  
Reflecting back, this seems sad, since working together has all the advantages of pair programming-- it's fun and educational,  often much faster, and you can produce a superior result. 
  
There are many blog posts about the merits of pair programming, but none about pairing between programmers with a designer.  Since Carbon Five values pairing and collaboration so heavily, I've been trying to do it on all my projects. On my most recent project for the [National Campaign](http://thenc.org/), I've had the pleasure of "pairing" with several designers.  
  
The first day of the project was refreshing-- I sat side by side with Jef and we broke apart his Illustrator designs, reassembled them in HTML, and fluidly passed ideas and png files back and forth. He was standing next to me, we were sharing a dropbox, and it was very exciting.  
  
Five months in, a recent experience left Suzanna (our current designer) and me in awe of the merits of working closely together.  

  

The task was a quick page redesign-- we have 17 detail pages utilizing the same basic template, each about a [different](http://bedsider.org/methods/the_pill) [contraception](http://bedsider.org/methods/the_ring) [method](http://bedsider.org/methods/male_condom) (it's a site about birth control). From early user testing, we'd learned what wasn't working, and had reached consensus on the set of problems we should try to fix. Suzanna synthesized the feedback and produced a mock-up-- a single PNG screen mock-up representing all 17 pages. Pretty traditional so far. Among other things, the new design called for altering the main photo from its prominent placement in a rectangle taking up half the page, to a smaller photo that is elegantly wrapped by the initial paragraphs of text.  
  
Traditionally, this doesn't go well: Some of the methods are quite small (the size of a match stick), whereas others, like the female condom, take up 6 inches or so (depending on how you measure). They have different shapes and visual weights, so it's going to be hard to get one design that works for all of them.  
  
Suzanna specified a reasonable size for the image, taking this into account as much as possible. She develops a compromise based on lots of factors, including a  guess about how a browser might wrap text. The developer would follow the spec as close as possible, and either wouldn't notice or say anything if there were visual problems.  
  
Often the process stops there. You have a few pages that look good, and the rest various degrees of bad. Everybody argues that they did their job, and they did.  
  
So the team tries to fix it. The designer might spec different dimensions to see if something else will work-- but this is simply another big compromise. Or the designer will embark on the tedious task of creating a mockup for each page-- making them beautiful with Photoshop's font rendering and text wrapping (which the developer can't really duplicate). In the best case, a compromise will be reached that looks just okay for all the pages.  
  
Things went differently, because the programmer and designer were sitting next to each other:  
  
We are working with a [960 grid](http://960.gs/), and Suzanna made everything fit in our grid. As I started the implementation, she measured and confirmed. But fitting in a grid for a designer can be different than fitting in a grid for a developer.  
  
I probed, "What about that image-- it's so tall and narrow. You want that to stick up above?"  
  
"Naw... Well, maybe. Why don't we just build the images with 20px "cushion" that the image can bleed into, in case they need to extend?"  
  
"Sure," I said.  I'll use negative margins to break out of the grid (a little):  

> #photo {  
>   float: left;  
>   height: 180px; width: 180px;  
>   margin: 0 0 -5px -20px;  
> }

Even if we'd stopped there, our implementation would be an improvement over a traditional outcome without the negative margin bleed. Suzanna could now have shadows extend into the margins, which will be a nice visual effect.  
  
But that's not the end of the story. I walked back to my desk and implemented the page while Suzanna cranked out the images.  
  
She interrupted me five minutes later, "This one's taller, is that okay?"  
I was in the midst of placing the image and realized I could add one CSS rule that would handle this. "Sure!"  

> #photo.the_pill { height: 241px; margin-bottom: -20px; }

Ten minutes later Suzanna came over to my desk, "I finished the images and they're in [your drop box](https://www.dropbox.com/). I had to make a couple other ones different sizes."  
  
She'd named them consistently with the old names, so I just copied the files over. We compared my implementation with Suzanna's PNG mockup. Close, but not close enough. Suzanna sat down next to me and we pushed a few pixels around, getting the margins right with the browser's font metrics-- the line heights were slightly different she needed an adjustment. A quick check on Windows as well, and it was perfect.  
  
Then we looked at the odd size images she'd discovered, and we tweaked those sizes and margins as well. Some of them needed a little margin adjustment as well. No problem-- we just flipped back and forth between browsers and CSS files making everything perfect. (She didn't actually need to make any measurements as we just used our eyes.)  
  
While we were at it, we ran through the all 17 pages, just as a quick check. The set of non-exceptional pages should be fine, but Suzanna wanted more adjustments. Each photo is unique. Since it was so easy, why not? In a matter of minutes, half the pages had some custom pixel adjustments, and we were quite happy with all of them.  

> #photo.diaphragm { height: 195px; margin-bottom: -20px; }  
> #photo.withdrawal { height: 201px; margin-bottom: -40px;}  
> #photo.depo_provera { height: 189px; margin-bottom: -20px; }  
> #photo.iud { margin-top: 5px; height: 226px; margin-bottom: -60px; }  
> #photo.the_ring { margin-bottom: -20px; }   
> #photo.cervical_cap { width: 195px; height: 192px; margin-right: -15px; margin-bottom: -20px; }

This probably took less than an hour. This isn't very complicated, but it's hard to imagine how tedious this would have been if we hadn't paired to reach the final result. Plus, each page really looked great-- the image tucked in "just right."  
  
I've certainly collaborated with designers before, poking around in Firebug until things looked good. But this was the first time I saw how clearly working closely produced a superior result. And we did it with no tedious measuring of text or dozens of time-consuming mockups.  
  
What could have taken hours or days took minutes. We just sat down together, and, well, paired. 
