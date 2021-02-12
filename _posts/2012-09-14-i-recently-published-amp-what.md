---
layout: post
title: "&what?"
date: 2012-09-14
comments: false
url: /2012/09/i-recently-published-amp-what.html
permalink: /2012/09/i-recently-published-amp-what.html
tags:
 - css
 - experience
 - software development
 - mobile
 - ux
 - javascript
 - prototyping
 - mini-project
 - html
 - unicode
---

  
I recently published [amp-what.com](http://amp-what.com/). I created it to solve a problem I have:  trying to remember (or google) character entity numbers or names. For example, our last project used the entity » (»). Try googling this if you don't remember the name! Now, with this tool, I can just type ">>" and the character, symbol and number appear.  
  
It turned out to be surprisingly fun to play with. I discovered [chess pieces](http://amp-what.com/#q=chess), [planet symbols](http://amp-what.com/#q=planet), all sorts of boxes. There are a surprising number of icons to play with. What have you found that surprise you?  
  
I initially sourced the tool with the standard 100 or so entities from W3C. Then I supplemented this with 10,000 interesting Unicode characters, and a nice set of entity synonyms from Remy Sharp (whose site is solving the same problem). Seeing that people were sometimes getting no results, I pulled in an internet jargon file for non-conventional names, and supplemented myself, by manually coding them. I am interested in adding more, but want to keep it "offline friendly", which means not too large.  
  
**I was intrigued by a couple questions around "mobile": ** I tried to make it "mobile friendly", and the initial version was "small"; small enough to fit on an iPhone screen. This ended up looking sad on larger screens, so that clearly is not the answer. I recently refreshed it with a _responsive design_ approach. Now it uses the screen space nicely on both small and large screens.  
  
I also wanted to build an HTML5 _offline app_. For those of you with an iDevice, you can save to the home screen and have the reference available whether you are online or not.  
  
But beyond being mobile "friendly," I believe that HTML5 offers a good alternative to building a native app. I wanted to push the UX and see if I could get it to feel _as responsive as a native app_-- I think it does a pretty good job at executing quick searches, but I'll leave it up to you to judge.  
  
**Since the initial prototype, I've layered in a few features:**  It wanted to be able to link to certain queries, so I used the hashtag to do that, so you can share your favorite queries.  
  
I allow changing the font (using the small (f) in the bottom right corner).  
  
I found myself wanting to use the Unicode characters in different contexts: not only web pages, but Javascript source and CSS files. I've added some ability to customize the display-- hex, decimal, Javascript, or URL encoded. Those controls are also at the bottom of the screen.  
  
[Check it out](http://amp-what.com/), bookmark it, and please send me feedback.  
  
<h2>Comments</h2>
<div class='comments'>
<div class='comment'>
<div class='author'>ndp</div>
<div class='content'>
Thanks for using amp what!   
  
The intent of the code is that if you click on the symbol itself you copy the symbol, or if on the number, it copies that in the current "mode". I believe this is what you are doing.  
  
The mode is the �� 16 and CSS in the right of the search bar. If you can click on the CSS, the copy function should give you a css content attribute appropriate value (although I do see a glitch with how it's working now-- which I'll fix tonight.) Lmk

</div>
</div>
<div class='comment'>
<div class='author'>hasanyasin</div>
<div class='content'>
This is awesome. Thank you very much for the tool. I often add entities ass css `content` values. I added below code block to your page in my browser so when I click an empty area in the zoom element (div that opens when you click a character), it copies the hex representation instead; i.e, for `▼` character it copies `\025bc`. Maybe you would consider adding this representation to the app?  
  
```JavaScript  
window.addEventListener('click', function(evt) {  
 var elm = document.getElementById('zoom')  
 if (elm !== evt.target) {  
 return  
 }  
  
 var txt = elm.querySelector('.num').innerText.replace(/[&#;]/g, '')  
 var inpbox = document.createElement('input')  
  
 inpbox.value = '\\0'+parseInt(txt).toString(16)  
 document.body.appendChild(inpbox)  
 inpbox.select()  
 document.execCommand("Copy")  
 inpbox.remove()  
})  
```

</div>
</div>
<div class='comment'>
<div class='author'>ndp</div>
<div class='content'>
I pushed up a quick fix for the copy/paste issue. Now within the small dialog you can copy and paste both the character or the code.

</div>
</div>
<div class='comment'>
<div class='author'>ndp</div>
<div class='content'>
@Stefan and RazorX... thanks for the positive comments. I'll make a rev so it's easier to copy codes and characters... a recent change made this more difficult than it original was. Coming soon!

</div>
</div>
<div class='comment'>
<div class='author'>Razor X</div>
<div class='content'>
This site is a great idea, like a Detexify for UTF8.  
  
I've found it useful so far, but I need to leave this feedback: trying to copy the character codes are incredibly frustrating. I try to highlight the code by clicking and dragging or just double clicking until the code highlights, but doing this is actually impossible since clicking anywhere on the code either opens a modal box for the character or closes the modal box for the character.

</div>
</div>
<div class='comment'>
<div class='author'>Stefan Seidner</div>
<div class='content'>
Hi Andrew,  
I like amp-what very much.  
However, I don't manage to copy codes from the site. If I click a character there's a pop-up window, if I click again the window closes. So how can I copy codes?  
Thanks,  
Stefan

</div>
</div>
<div class='comment'>
<div class='author'>ndp</div>
<div class='content'>
Thanks @Tor-Ivar Krogsæter for the feedback. Appreciate it and glad you find &what useful.  
  
I need to do a little more research on the alt codes. When I know for sure how to map them, I'll add an output choice at the bottom. I believe "Alt codes" are simply 0 + the decimal equivalent of the unicode code (but I don't use windows so I need to confirm). If you pick ⑩ at the bottom of the &what page, this will show you the decimal encoding-- just prepend this with 0 and it should work...  
  
As far as fonts, I'm using web fonts at this point. My strategy is to list a series of backup fonts and hope/trust the browser to figure out how to render individual glyphs. This may not work perfectly, but it is low-bandwidth and low-risk. I've picked fairly complete fonts for OSX and iOS, and made stabs at fonts for Linux and Windows.  
  
Again, thanks for your feedback.

</div>
</div>
<div class='comment'>
<div class='author'>Canned Man</div>
<div class='content'>
I was so surprised to find your site; it did to me what you tell it was designed as for you: solved having to google every time one needed a new symbol. Thanks a lot for making it! Do you have any plans to implement Alt codes as well? If you did, you would have the ultimate character map tool. Quite a lot of the special symbols seem to require special fonts installed, such as Maestro (I would presume) for the different notes symbols) or who-knows-what for symbols like thumbs up and thumbs down. Is there any way of overcoming this with CSS3, without making the site too heavy on the bandwidth for phones?

</div>
</div>
</div>
