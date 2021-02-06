---
layout: post
title: "8 Steps to Constructing a Better Software Engineering Homework Interview"
date: 2016-07-20
comments: false
url: /2016/07/coding-challenge-interview.html
tags:
 - software development
 - pairing
 - resumes
 - agile
 - interviews
---

A recent trend in the SF tech scene, and perhaps elsewhere, is the take-home interview. I’ve been on both sides of this exercise, I’ve noticed it can have unintended consequences: a bad experience for the candidate and a filtering out of qualified candidates. I’d like to talk about some of the problems, and offer 8 suggestions about how to improve it.

For those of you who haven’t run across it, the homework interview is also known as a “take-home challenge”, or “coding challenge”. They’re all pretty similar: before proceeding with the interview process, the candidate is given a short problem description and must produce working code that will be reviewed within hiring company. The problem is usually related to the work of the host company. This makes it a bit more realistic than an easily google-able CS problem.   
  
The idea behind this is logical: hiring company is trying to better assess the candidates programming ability. Perhaps they’ve failed in the past— perhaps they brought a candidate in for half a day, had them talk to the whole engineering team, and then realize afterwards it was a waste. Either the first session of the day revealed the candidate couldn’t code, or worse -- no one knows definitely whether the candidate can code. It think this can be solved by actually coding during the interview (see[this post](http://blog.ndpsoftware.com/2014/02/favotite-technical-interview-technique-pairing.html) for one possible activity), but a homework assignment conceivably gives the company a “standard” process that interactive sessions can lack. It can also seem easier to prepare for and less intimidating for the candidate than an in-person pairing session.  
  

I’ve seen one homework assignment that was simply processing IMDB data using target company’s tech stack, where the company was not IMDB or movie related. This seems like an outlier, as most companies make the homework domain specific. I believe they think this makes the problem more personalized and gives the candidate a sense of what it’s like to work at their company. This is wishful thinking; there’s no way to make a single problem “realistic”, and the situation itself is artificial anyway. Ultimately I think this just introduces some “local color” into the interview process.  

[![](https://2.bp.blogspot.com/-6ktbPCyNNKk/V5AYTFLD-hI/AAAAAAAANI0/z8N2FnjSySArDqGpFWkJzPZ2NU8SomfLwCLcB/s1600/Screen%2BShot%2B2016-07-20%2Bat%2B5.32.06%2BPM.png)](https://2.bp.blogspot.com/-6ktbPCyNNKk/V5AYTFLD-hI/AAAAAAAANI0/z8N2FnjSySArDqGpFWkJzPZ2NU8SomfLwCLcB/s1600/Screen%2BShot%2B2016-07-20%2Bat%2B5.32.06%2BPM.png)
  
  

That all makes sense, but from the candidate’s perspective it may not. For example, the candidate may wonder:
  
  

\* How much time should I spend on this? Sure, it says “2 hours”, but if I spend 8 hours it’ll look much better. If you want to put your best foot forward, it’s hard not to spend more time. I’ve had candidates report they spend a whole week on the homework. It’s hard to not feel a twinge of guilt when you don’t hire them after such an investment.
  
  

\* How will it be evaluated? Often challenges will say “use whatever language you like”, but will solutions written in PHP really be evaluated in the same light as one written in company’s main language? Or a problem that asks for “good code quality” without saying what that means to them. The candidate will wonder: “Will I be dinged for not using semicolons or using tabs instead of spaces?” Or, “They can ask for “production” code, but do you really want me to include extensive logging, alerting, redundancy, forward and backward compatibility, unit tests, functional tests, stress tests...” and so on. I suspect production quality code would make the candidate look like a whack job.

 

\* Is the company worth the time investment it will take to complete the homework? Often the homework comes after an initial screening call— often with a non engineer. If the candidate hasn’t been sold on the job yet, some of them will opt-out and you are limiting your candidate pool. You’ll lose senior engineers here. And candidate working full time (or with a family or non-work hobby) will have less time to devote than an non-working candidate. This will be an unintended filter, which may be okay, but it should be acknowledged.
  
  

So, some advice for doing this right:
  
  

1. Put it in the right place in the hiring process. You’re asking the candidate for her time, so make sure it will seem worth it. This needs to come after the initial HR screen, after the first technical screen determining their is a good fit (unless the candidate is lying), and after someone has sold the job and company to the candidate. Otherwise you are asking a large time commitment and all but the most needy will drop out. 
  
  

2. Skip it when it makes sense. It’s important to remember what you are trying to assess with this homework. If you won’t learn anything, don’t ask the candidate to do it. It aggravates me to be asked to build a somewhat standard Rails application and implement a couple basic CRUD screens. My immediate reaction is that they are looking for a junior candidate without a proven track record, and I should move on. My resume shows that I’m an accomplished programmer, and my Github page has thousands of lines of code (of varying languages and quality). I certainly have my weaknesses, but building a standard Rails app won’t reveal them. At least take a pass at the candidates Github and resume to see whether the homework is appropriate.
  
  

3. Provide clear time limits. If the candidate isn’t given a time limit, you are going to get a wide range of qualities distributed based on how much time people have, more than how they’ll perform on the job. You’ll be filtering for unemployed people and people that are already sold on the job. I saw a technical solution for this: the candidate is issued an API key that was valid for only two hours. This keeps the time commitment constrained, but puts the interviewee in what can feel like a stressful situation (as engineers are almost never asked to code like they play speed chess). Personally this threw me off and the homework wasn’t representative my work, so I don’t recommend it. I’d prefer a much smaller task that has a limit of not more than 30 minutes. Therefore…
  
  

4. Provide small scope. Several times I’ve seen homework that requires a full Rails app with several pages, a data import or API call. What you think is 2 hours can easily be 6. It is easy to write, but this can easily require a dozen different small projects. I completed one of these homework assignments, and looking back I created 20 distinct Git commits. Here’s a summary:

` .rspec                                                |  2 ``++`

` Gemfile                                               |  1 ``+`

` README.rdoc                                           | 59`

` app/controllers/api_controller.rb                     | 43 ``++++++++++++++++++++++++++++++++++`

` app/controllers/application_controller.rb             |  2 ``+-`

` app/models/b *****.rb                                  |  3 ``+++`

` app/models/calculator.rb                              | 26 ``+++++++++++++++++++++`

` app/models/ ****.rb                                    |  3 ``+++`

` app/models/ **** _summary.rb                            | 34 ``+++++++++++++++++++++++++++`

` config/application.rb                                 |  2 ``++`

` config/environments/development.rb                    |  2 ``++`

` config/routes.rb                                      |  4 ``++++`

` db/migrate/20160629143516_create_***.rb               | 10 ``++++++++`

` db/migrate/20160629144459_create_***.rb               | 11 ``+++++++++`

` db/migrate/20160629151847_create_***.rb               | 12 ``++++++++++`

` db/schema.rb                                          | 45 ``+++++++++++++++++++++++++++++++++++`

` db/seeds.rb                                           | 30 ``++++++++++++++++++------`

` lib/tasks/summarize.rake                              | 11 ``+++++++++`

` spec/calculator_spec.rb                      | 61 ``+++++++++++++++++++++++++++++++++++++++++`

` spec/controllers/api_controller_spec.rb               | 44 ``++++++++++++++++++++++++++++++++++`

` spec/ ******* _summary_spec.rb                          | 51 ``+++++++++++++++++++++++++++++++++++++++`

` 28 files changed, 668 insertions(+), 23 deletions(-)`
  
  

Older studies showed that engineers averaged 10 bug-free lines of code per day. Even if it’s 100 these days, this is at least a couple hundred lines of code. Big assignments are too much. Aim for something that can be solved in a JSBin in 20 minutes. 

[![](https://2.bp.blogspot.com/-mv3g1jptcnM/V5AYgIURXnI/AAAAAAAANI4/rP7SzYF33M8FVVJnZ3XzNLCDhxBtC4oqgCLcB/s1600/Screen%2BShot%2B2016-07-20%2Bat%2B5.32.17%2BPM.png)](https://2.bp.blogspot.com/-mv3g1jptcnM/V5AYgIURXnI/AAAAAAAANI4/rP7SzYF33M8FVVJnZ3XzNLCDhxBtC4oqgCLcB/s1600/Screen%2BShot%2B2016-07-20%2Bat%2B5.32.17%2BPM.png)
  
  

5. Provide clear evaluation criteria. Know exactly how you are going to evaluate the homework, and include this as part of instructions. Include clear statements about how much refactoring is expected, test coverage, etc. Not only is this troubling for the candidate, if the grading isn’t consistent, you are introduces a huge amount of randomness into your hiring process.
  
  

6. With this clear criteria, provide the candidate with feedback and close the loop. Take 5 minutes and loop back with the candidate— whether she did well or not. From my experience, when the interview processes ends, it end abruptly. This leaves little room for learning. Everyone talks about having great interview processes, but I’ve yet to see this be anything but what amounts to a boolean false. Consistently making this call will be hard, but it will keep you honest and help you improve your evaluations. 
  
  

7. Test out your homework. You want to make sure that it’s evaluating candidates the way you think it is and not creating a bad experience. Take it from a retired teacher (and TDDer), it’s harder than it appears to write good tests. Make sure you get feedback from the first few— if not all— the candidates; you want to make sure this isn’t causing a bad experience for your interviewees. Have your current employees do the assignment and grade it anonymously. &nbsp;Test test test.
  
  

8. Even if you give them the homework, [do some coding in-person](http://blog.ndpsoftware.com/2014/02/favotite-technical-interview-technique-pairing.html). This will give you all sorts of insight into how the candidate thinks. Do what you can to eliminate nervousness, but unless all your programmers work in isolation, a homework assignment is not realistic.
  
  

I’ve probably interviewed over a hundred candidates and pair programmed with over fifty. Although it’s been overwhelmingly positive, I know there are people out there working as programmers without the expected skills. And I agree &nbsp;there’s a need to filter them out before spending a whole team’s time with in-person interviews. At the same time, we need to remember all we’ve learned about building great software: we want a great user experience. The great UX feels simple, clear and includes a process for constant improvement. So can an interview process.
  
Special thanks to Jim “the engineer” Fung for tolerating my tirades on this subject and giving me feedback on early versions of this essay.

