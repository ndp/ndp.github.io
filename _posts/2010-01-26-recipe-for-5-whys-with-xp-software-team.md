---
layout: post
title: "Recipe for 5 Whys with an XP Software Team"
date: 2010-01-26
comments: false
url: /2010/01/recipe-for-5-whys-with-xp-software-team.html
permalink: /2010/01/recipe-for-5-whys-with-xp-software-team.html
tags:
 - software development
 - xp
 - consulting
 - agile
---

5 Whys is a great way to get at the root of quality problems. On my last three projects, when I felt like code quality was dropping, I ran a "5 Whys" session. I have found it adds variety, solves a very specific problem, and plugs right in as an alternative to an [agile reflection](http://blog.carbonfive.com/2009/12/agile/recipe-for-simple-agile-retrospectives).  
  
It's not in every agile software team's bag of tricks. Asking around our fairy savvy office, I discovered it's far from universal. In the ["State of Agile" report from Version One](http://www.versionone.com/whitepapers.asp), which includes survey results from 2500 software developers, it wasn't mentioned. Since I haven't seen it show up that much in other agile writings, I thought I'd share my experiences here.  
  
**What is "5 Whys"?** I picked up "5 Whys" from the lean software movement, which sprang from Toyota manufacturing. You can read about its history on [wikipedia](http://en.wikipedia.org/wiki/5_Whys), but it's pretty simple: at the end of the assembly line, when a widget comes out with a problem, you stop the line and ask "Why?" Whatever the reason, you ask the "Why?" again. Repeat at least 5 times. The goal is to discover the "root cause" of the defect, and fix the root cause, not just some symptom. Wikipedia has a good example around car repair. Here's a software example:

> 1. Why did Sheryl say the sign-up flow was broken?  
> _A: Because she was trying to sign up a second time. Duh._  
> 2. Yeah, but why did the flow break if the user is already signed up?  
> _A: It's a bug. We didn't have a test case for that._  
> 3. Why didn't we have a test case for it?  
> _A: I just didn't think of it._  
> 4. Why didn't you think about it?  
> _A: The story seemed easy-- I guess I didn't think it through._  
> 5. Why do you think you didn't think it through?"  
> _A: I guess I was working alone and was in a hurry._  
> ...

Obviously you don't have ask "Why?" exactly five times, but that does seem to be a pretty good number. The point is you start articulating the behaviors and procedures that cause the problems.  
  
**Taking It for a Spin.** I've come up with exercise for agile software teams. Like I mentioned, when quality drops below your comfort level, give it a try:  

1. (2 minutes) Make a list of the most recent bugs you've uncovered. I've found that the last 10 is usually enough-- if not too much. You can put these on a white board, index cards or a wiki page-- all will work.
2. (2 minutes) Prioritize them based on the ones you want to talk about. Which caused the most embarrassment or cost? You usually only have energy to talk about 5 or 6 of them.
3. (15 minutes) For each bug, ask "Why did this happen?" Then, probe deeper until you can't get much further. Write the answers down where everyone can see.
4. (5 minutes) When you're done with all the bugs (or out of time), circle common root causes.
5. (10 minutes) Brainstorm ways to mitigate or eliminate the root causes. Come of with one or two SMART goals for the team.
Some of the root causes we've gotten to recently:  

- we didn't pair on hard features
- we didn't ask for clarifications on the requirements
- one engineer didn't understand the intent behind the code
- nobody looked at the app on Internet Explorer 6
Just like in agile reflections, the changes made coming out of these meetings stick with the team. During one session, the developers decided that there were just too many mistakes that someone else would have easily caught-- so they always needed two sets of eyes on every checkin. I'd advocated this before, but it was never applied consistently. To my surprise though, after the reflection, everyone was disciplined about this policy-- and our quality was much better. 