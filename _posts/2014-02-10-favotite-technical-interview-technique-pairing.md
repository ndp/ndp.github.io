---
layout: post
title: "My Favorite Tech Interview Technique"
date: 2014-02-10
comments: false
url: /2014/02/favotite-technical-interview-technique-pairing.html
permalink: /2014/02/favotite-technical-interview-technique-pairing.html
tags:
 - software development
 - career
 - pairing
 - interviews
---

Inspired by the fun at hack nights around town, I've stumbled upon my new favorite interview exercise. I've been meaning to write this up for a couple months, and just stumbled onto [a very similar idea](http://germanforblack.com/post/52224250893/the-perfect-code-interview) by a fella named Ben Schwarz.  
  
tl;dr -- have the candidate bring in an open source project and hack on it together.  
  
  
The tech interview is challenging, especially if you're administering it. At [Stitch Fix](http://technology.stitchfix.com/), we've been talking about how to spend our 30-60 minutes to get the best read on a software engineering candidate. Here are a few popular techniques we've used, and you probably have too:

- **Just chat**. Ask her what she does, and about her last project. If the job is to assess "culture fit," that's fine, but if it's technical screening, this is awful. This can easily miss huge technical gaps in someone's experience. 
- Come loaded with a **list of specific tech questions** (easily downloaded from the internet). From my experience, this does not give a good read on what a candidate will actually be like. I've interviewed several people that were great at answering specific questions, but then-- once hired-- couldn't put them together to solve a problem. Don't be surprised if this gives mixed results.
- In response to downsides of the tech questions, the solution is to come with **a technical challenge** : this can be a "white board" question about loading a barge, or just sketching out some code to reverse a string in place. The idea is to get a sense of her problem solving ability, not just canned knowledge. This will show problem solving skills, and I endorse it as part of an interview. But it can give a wildly different results depending on how comfortable the candidate is with an interview situation and whether she has seen the question before. If the candidate happens to know the question, the exercise provides little information.
- Rob Mee at Pivotal spends a half hour **pair coding** on a simple data structure implementation, and this technique has been picked up by many people around town. This provides some insight into what it's like to pair with the person, along with a good dose of understanding of a basic data structure skills and her problem solving ability. It's a good exercise, because even though it's writing actual code, to candidates used to pairing, it can feel like less pressure than a lone technical challenge. This will favor people experienced with pairing, and perhaps provide false negatives for those who haven't.
As a variation on the last technique, I have used  **pair coding on our codebase**. The idea is to combine the advantages the pairing technique while giving the candidate more exposure to what our day-to-day coding is like. On the positive, this does tend to help sell the job to a candidate. But I'd often get bogged down in the details of our system, and it tends to make me do more talking than I like. Also, the nature of our problems vary quite a bit, so it's difficult to compare different candidates. It's also hard to tell from lots of nodding whether she really "gets it", because we don't have enough time for her to really dig in on complex problems. I ended up not really like this technique for its disadvantages, except in a few rare cases.  
  
I finally stumbled upon a technique that I like, or dare say "love". It doesn't suffer from the typical downsides of being artificial, uses pairing, puts the candidate in her comfort zone, and gives me a good impression of what it would be like to work with the candidate.  
  
It's pretty simple:  
  

1. Before the candidate comes in, ask her to pick one of her own projects to work on. If she doesn't have a project, pick an open source project to contribute to
2. Identify a bug to fix or feature to implement in that project
3. Get it all set up on her own machine before she comes in
4. When she arrives, chat for a few minutes about her career goals, and then
5. Spend an hour or two pairing with her to implement the project together, letting her drive
Here's a template that can be used:  

> _During our interview, I'd like to pair with you on a task you're comfortable with. Please pick one of your own projects that you know well and are comfortable with. It doesn't have to be a Ruby project. If you don't have an appropriate project, please pick an open source project that you'd like to contribute to and can become familiar with.  
> Identify a task that will take about 1 hour. It can be a bug fix or new feature. Please think about an appropriate scope of work and how to describe it to me.  
> Please have the project set up on your machine before you come. If you are not bringing a laptop, make sure we can get it set up quickly on my machine._

  
From this simple task, I get many data points to analyze:  

- What project did she pick? Did she struggle to select something? 
- How serious does she take the work? 
- How difficult is the challenge?
- Was is something realistic to do in the timeframe?
- How facile is she with the tools in her environment?
- What is she like to work with?
- etc.
I've also gotten to work on a couple interesting hobby projects. In the end, instead of having to divine her technical level from a series of questions or her presentation, she will tell me where she is at by the problem she selects. It's conceivable to cheat at this-- to solve the problem before you arrive and then walk your way through it-- but I like to think this is pretty easy to detect. 
