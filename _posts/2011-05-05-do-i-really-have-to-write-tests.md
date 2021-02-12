---
layout: post
title: "Do I really have to write tests?"
date: 2011-05-05
comments: false
url: /2011/05/do-i-really-have-to-write-tests.html
permalink: /2011/05/do-i-really-have-to-write-tests.html
tags:
 - software development
 - consulting
 - lean
 - prototyping
 - tdd
 - coding
---

Over at the Lean Startup Circle mailing list, they're discussing  [what kind of tests to expect from developers](http://groups.google.com/group/lean-startup-circle/browse_thread/thread/def1deba5f97caf9).  I enjoy this conversation. People are often looking for a clear guideline ("[startups don't need tests](http://www.quora.com/Test-Driven-Development/Is-Test-Driven-Development-practical-for-a-startup)") or "code coverage" figure-- or have one in mind. Idealistic agilists insist you _always write tests_. They equate not writing tests with abandoning quality-- the beginning of the end. "Such carelessness will lead to bugs upon bugs and eventually, [unmaintainable code](http://mindprod.com/jgloss/unmain.html)." Reality requires a more nuanced and pragmatic approach suggested below.  
  
**Getting Real**

I learned in Q.A. school (or was it the Q.A. streets?), you can't test everything. Be pragmatic because software is just too complex to allow coverage of all cases. Good test design requires thoughtful prioritization-- minimal money yielding maximum test coverage. Q.A. engineers learn the requirements and the relative importance of each. They let this understanding guide how you design a test suite. They learn to carefully consider the quality requirements, where the critical parts of the software is, and where potential problems might appear, and what the costs of failure are. In this cost-benefit and risk analysis, there isn't just one, simple answer.

  

The main factors to consider to judge how much testing is needed, keeping an eye towards developer-written tests:   
  
**Cost of bugs**. Different software has different quality requirements. One of my projects would cost $1000s of dollars per hour if it crashed-- and cause freeway backups, and bring the L.A. news helicopters, etc. Another one let you comment on your latest book purchase. Some applications really are heart-lung machines.  
  
**Anticipated life of the code.** Some code is for prototypes or other "throwaway" purpose. But veterans bristle at the thought, and will recount how quick hacks became the core of mission critical systems, and that code just doesn't go away. Seconding their motion, TDD disciples insist on writing tests for everything. There certainly is risk in creating code too casually, but prototyping is a powerful tool. Prototyping is powerful. If you can figure out how to build out your ideas quickly and explore them with your users,  you'll be able to able to out-pace competitors.   
  
**Area of the application**. Not all code of an app is the same. At a concert, there are soloists and choir members. The audience will be much more critical of the soloists. Singing coaches don't spend as much time with each choir member as they do with soloists. Therefore, identify the most important part of your app.  
  
I'm a big advocate of building from the inside out: identify these critical parts of the system. Validate the model with everyone, and test the heck out of them. Make it unbreakable. Then, using these as building blocks, put together the pieces in various ways. Allow yourself to test different combinations with the knowledge that the blocks won't break from underneath you. Many a team has treated speculative admin interfaces with the same vigilance as the core data model. It's quick to build prototypes with solid building blocks.  
  
**Likelihood of bugs.** Some areas of an app are like compost piles, and attract bugs.  Good developers should be able to give you an honest appraisal. They should be able to identify difficult problems, as well as error-prone approaches to problems. Some code just evolves to become gnarly to work with. Adjust testing needs appropriately.    
  
**Test-driven design requirements**. TDD is an excellent tool for figuring how the code should be written and structured. I find that using TDD, when informing the design, save significant development effort. Don't sacrifice testing when it will benefit the code. If it's faster to write a prototype with TDD, I'll use it.  
  
**Team size.** A lone developer focusing on one project will have less of a need for tests than a larger team all sharing a codebase. Yes, with luck, the project will grow into something larger, but there's also an important "just-in-time" theme to agile. This is not an excuse for skipping testing, but is a factor to consider.  
  
**Other quality checks. ** A team auto-deploying to the cloud needs more checks-- and tests-- than a team with a dedicated Q.A. team watching out for them.  
  
There are other factors, but those are the important ones. Let's resist talking in absolutes, and do what is best for our project, customers and users. 
