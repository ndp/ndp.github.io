---
layout: post
title: "10 Ways to Cheat at Wordle"
date: 2022-01-29
comments: false
tags:
- games
- hacking
- fun
---
When I first came across [Wordle](https://www.powerlanguage.co.uk/wordle/), I accidentally glanced one of my kid's screen while walking down the stairs. After I was explained the game by them, I then proceeded to show my prowess by getting my first Wordle right in 1 guess. My family was surprised, but obviously onto me. But this got me started down a bad path of cheating on Wordle. 

I decided to have one rule I never broke: never cheat the same way twice.

Herein are some techniques, not definitive. If it's not obvious from the title, spoiler alert.

1. Observe someone else's result "over their shoulder" (timeless hacking technique).
2. Use a second device to solve, and then use the answer to solve in 1.
3. Play first in "Incognito" mode.
4. I was driving with my child and they did the wordle on their phone. I asked them to give it to me verbally. I did great, and when I played on my computer later, I did even better.
5. Solve the day's puzzle in whatever time it takes. After you click "Share", just edit the block of text it gives you. It looks like an image, but it's really just text ([of unicode characters](https://www.amp-what.com/unicode/search/large%20square)).
6. I'm sure there are excellent social media feeds of the current day's word.
6. Google will point you to some ad-rich sites with the answer (and today's crossword answers).
6. Now we get to more serious hacks. Open the Javascript console and type `new wordle.bundle.GameApp().solution` and the solution will appear.
7. If you don't want to type, in turns out Wordle uses a database on your machine called "Local Storage" to keep track of things:
   1. In Chrome with the wordle site up, choose "Developer Tools" from the View menu. 
   2. Navigate to the Application tab if it's not already up, and then choose "Local Storage". 
   3. Click in and look at the key "gameState". It has a sub-key of "solution" with, well, your solution.
8. Or, see all the answers (past, present and future) in the source code. 
   1. In your browser, go to the "Source" tab. 
   2. From there, go to the "main-XXXX.js" file (the XXXX is a hex signature and will change if a new version is deployed). If your browser suggests to "Pretty Print", you can do it, but it's not strictly necessary. 
   3. Now, search for yesterday's word. The search will take you to an array of all the solutions, ordered by date, so you can see today's, tomorrow's and onward. You can simply copy this list, or print it out (or memorize it) for perfect scores.

I'm sure there are many more, but I haven't figured them out yet. I spent a few minutes of research about letter frequences. Most sources show you letter frequencies in written English text, but what you want is the frequency in words (or 5-letter words, [or, well, better, Wordle's list of 5-letter words]).  The ten most common letters in words (in order) are `eariotnslc`.

If you start with the words `clean` and `riots`. This will give you a few letters, and I've found I can usually get it from there-- but not always. 

The fifteen most common letters are found in `lurid month space`, which seems to pretty much guarantee a score of 4.

That's all for now.