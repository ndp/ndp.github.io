---
layout: post
title: "Designing with Javascript Color Functions"
date: 2011-01-21
comments: false
url: /2011/01/designing-with-javascript-color-functions.html
permalink: /2011/01/designing-with-javascript-color-functions.html
---

In my last couple posts, I've introduced my Javascript color and color scheme functions. In this post I'll walk through how I used them when developing [my usability wheel](http://uxspoke.com/).  
  
  
I mentioned some color tools in my last post. My review is that ultimately they are pretty frustrating, as it's difficult to preview the colors in the balance that you might use on a page, and certainly not with the right colors being used for text and non-text. Really the only way to assess a scheme's ultimate appropriateness is to apply it to the design directly. For pure designers, the Adobe products offer great tools for exploring this, but tools for programmer/designers are a little lacking. I build my own tools for this project.  
  
**Let step back:** The original idea was to build an analog of the little cardboard "calculators" from the 70s and 80s. They were neat: there's some sort of frame with holes punched in specific locations, and then a free floating cardboard piece that fits inside it and slides. Sliding the pieces in relation to each exposes different data inside the holes. It's really just a big table of data, but the windows allow the data to be more approachable and the whole experience more fun. When trying to figure out how to implement this, I thought about the roulette wheels my kids love when we're are local fairs. Maybe it wouldn't be the right metaphor, but it would be more fun to implement.  
  
From the beginning on the project, I was excited to take on the design responsibilities. It's been a while. When I first learned web design 10 years back, I built quite a few sites on my own, wearing all hats. (And before that, doing the design for desktop Mac apps.) But on all my more recent projects, I've worked with "professional" designers, and had to step back from the UX and visual design.  
  
**I took a programmer's approach** to the problem. The first component I developed was the "wheel", and since I mainly wanted to get it working, I applied random colors to each of he pieces of the wheel. This was in fact visually interesting, but ultimately wouldn't fly-- I realized that my eye wants to interpret a meaning behind the various colors, and I didn't know how to communicate that-- in this case-- the colors were meaningless. Lesson learned.  
  
Well, I needed something to ground the design. I wrote down a few adjectives of the emotions I wanted to evoke, and looked for inspiration from web images. Roulette wheels didn't offer anything interesting, but I found some wallpapers that were fun and evoked the carnival and circus feeling I wanted. I narrowed the set down to 10 or so, and then got some input from my wife, Tanya, and I had a background color.  
  
From there, I had a basic color scheme. With a good set of color functions, I could define elements on the page in relation to each other: which colors needed to contrast with other colors, and which ones needed to be darker than other elements. There are reasonable rules about   
  
  
  
    
  
  
When I developed  
But I did have some dimensions to map on the wheel-- each question occurred at different stages of development, and these could be linearly caegorized and put onto a linear scale.   
  
  
\* monochrome  
complementary

