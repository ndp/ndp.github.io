---
layout: post
title: "8 Steps to Constructing a Better Software Engineering Homework Interview"
date: 2016-07-20
comments: false
url: /2016/07/coding-challenge-interview.html
permalink: /2016/07/coding-challenge-interview.html
tags:
 - software development
 - pairing
 - resumes
 - agile
 - interviews
---

A recent trend in the SF tech scene (along with "project interviews"), is the *take-home interview*. I’ve been on both sides of this exercise, I’ve noticed it can have unintended consequences: bad assessment coupled with a bad experience. Here are some of the problems, and offer 8 suggestions about how to improve it.

For those of you who haven’t run across it, the homework interview is also known as a “take-home challenge”, or “coding challenge”. They’re all pretty similar: before proceeding with the interview process, the candidate is given a short problem description and must produce working code. That code is sent to the company and will be reviewed for quality. This review serves as an early filter in the candidate recruitement process, and allows the hiring team to efficiently filter out what it sees as bad technical fits.

I’ve seen one homework assignment that was simply processing IMDB data using target company’s tech stack (the company was neither IMDB nor movie related). But most companies make the homework domain specific, calling it something like "our coding challenge". If they sell widgets, they'll have you modify the check-out flow on a widget store. They think this makes the problem more personalized and gives the candidate a sense of what it’s like to work at their company. This is wishful thinking. It's very difficult to make an artificial problem “realistic”, and the situation itself is contrived anyway. The instructions for these exercises often include words like "realistic" and "production-ready". Ultimately I do think this introduces some “local color” into the interview process, but it's hard to believe it gives candidates any insight into what it's like to work at the company.  

The problems behind using this exercise are real: the hiring company is trying to better assess the candidate's programming ability. They’ve failed in the past with a day-long interviews with embedded coding sessions. They find out too late in the interview process that the candidate is not a technical fit; or worse, after the interview, no one knows definitely whether the candidate can code. 

It's also not uncommon for interviewers to offer, "she didn't do well, but maybe it was just nerves". By letting the candidate work at home without someone looking over their shoulder, it would seem like nerves wouldn't be an issue. This exercise strives to reduce stress on the candidate, but submitting a piece of your code for remote evaluation is, well, stressful, so I'm not sure how well it achieves that aim.



The take-home interview is also appealing for the hiring company because it seems to offer a *standard method* of assessing candidates, which in-person sessions can lack. But as we've discovered about the SAT and ACT, just because you're giving everyone the same test, doesn't mean you're getting good assessments of their abilities. Designing a good assessment is quite hard.


<img style="float: right; padding-left: 30px; display: inline-block" src="https://2.bp.blogspot.com/-6ktbPCyNNKk/V5AYTFLD-hI/AAAAAAAANI0/z8N2FnjSySArDqGpFWkJzPZ2NU8SomfLwCLcB/s1600/Screen%2BShot%2B2016-07-20%2Bat%2B5.32.06%2BPM.png">


The motivations for using this technique make sense, but the candidate may not see them. For example, the candidate may wonder:

* *How much time should I spend on this?* Sure, it says “2 hours”, but if I spend 8 hours it’ll look much better. If you want to put your best foot forward, it’s hard not to spend more time. I’ve had candidates report they spend a whole week-- more than 40 hours-- on the homework. It’s hard to not feel a twinge of guilt when you don’t hire them after such an investment. 
* *How will it be evaluated?* Often challenges will say “use whatever language you like”, but are solutions written in PHP really be evaluated in the same light as one written in company’s standard language of Java? Or a problem that asks for “good code quality” without saying what that means to them. The candidate will wonder: “Will I be dinged for not using semicolons or using tabs instead of spaces?” Or, “They can ask for “production” code, but do you really want me to include extensive logging, alerting, redundancy, forward and backward compatibility, unit tests, functional tests, stress tests...” and so on. I suspect real production quality code could make the candidate look like a whack job.
* *Is the company worth the time investment it will take to complete the homework?* Often the homework comes after an initial screening call— often with a non engineer. If the candidate hasn’t been sold on the job yet, they will opt-out, and many do this. Whether you like it or not, you are eliminating from your candidate pool busy, currently working candidates. You may unintentionally be filtering out those with families or with side passions that takes their time, limiting the diversity of your team. And this filter will over-select for non-working engineers. This may be acceptable, but I have not heard any discussions that this is the intent behind this exerecise.

I'd recommend against these take-home assignments. But if you must, some advice for doing this right:


1. *Do it at the right time in the hiring process.* You’re asking the candidate for her time, so make sure it will seem worth it. This needs to come after the initial HR screen, after the first technical screen, and importantly, after someone has sold the job and company to the candidate. Otherwise you are asking a large time commitment and all but the most needy will drop out. 

2. *Skip it sometimes.* It’s important to *remember what you are trying to assess* with this homework. If you won’t learn anything, don’t ask the candidate to do it. It aggravates me to be asked to build a somewhat standard Rails application and implement a couple basic CRUD screens. My immediate reaction is that they are looking for a junior candidate without a proven track record, and I should move on. A couple ideas:

   * Have part of the hiring process that reviews the candidates Github repository, and assess if the take-home test is necessary. My resume shows that I’m an accomplished programmer, and my Github page has thousands of lines of code (of varying languages and quality). I certainly have my weaknesses, but building a standard Rails app won’t reveal them. 
   * Considers using this assessment for junior engineers, and tailor it to work well for this. I've always seen that companies have one exercise-- one exercise to rule them all. They don't have different exercises for different programming positions. It's seems incredibly hard to design an assessment that will work for a wide variety of positions, and I'm skeptical that any of these do this effectively. 

   We just need to be honest about what the exercise is trying to do.


3. *Provide clear time limits.* If the candidate isn’t given a time limit, you are going to get a wide range of responses, with the quality distribution based largely on how much time people have. You’ll be filtering for unemployed people and people that are already sold on the job. 

   I have seen a technical solution for this, but I don't like it: the candidate is issued an API key that was valid for only two hours. This keeps the time commitment, but puts the interviewee in stressful, race-like environment, which (ironically) is something the exercise tries to avoid. If you want to use this approach, make sure you want to filter for engineers that can code to the clock. I'm not slow, but I've never been timed in this was, so when I first did this, the time-pressure limit threw me off, and the homework was not representative of my work. I’d prefer a much smaller task that can't get out of hand. Therefore...

4. *Provide a small scope.* Several times I’ve seen homework that requires a full Rails app with several pages, a data import or API call. What you think is 2 hours can easily be 6. It is easy to write, but this can easily require a dozen different small projects. I completed one of these homework assignments, and looking back I created 20 distinct Git commits: `28 files changed, 668 insertions(+), 23 deletions(-)`  That's a lot of code to churn out and evaluate. Aim for something that can be solved in a JSBin in 20 to 30 minutes. <img src="https://2.bp.blogspot.com/-mv3g1jptcnM/V5AYgIURXnI/AAAAAAAANI4/rP7SzYF33M8FVVJnZ3XzNLCDhxBtC4oqgCLcB/s1600/Screen%2BShot%2B2016-07-20%2Bat%2B5.32.17%2BPM.png" align="right" />

5. *Provide clear evaluation criteria.* State exactly how you are going to evaluate the homework as part of instructions. Include clear statements about how much refactoring, test coverage, etc is expected. There are two problems here. The first is that without a fixed rubric, the grades will vary randomly depending on which evaluator. Second, by evaluating "good" and "bad" based on your own company's culture, you'll be judging candidates (at least partially) on *how much their background and values match yours*. This is yet another factor that can inhibit diversity. 
   Don't use the words "production quality" without more definition of what that means. At a fast-growing start-up, "production quality" evolves monthly. "Prototype" code is fine in the beginning, but two years later it must be highly fault-tolerant. Both are "production". Don't punish a candidate for not knowing your culture.


6. With this clear criteria, *provide the candidate with feedback and close the loop*. Take 5 minutes and loop back with the candidate— whether she did well or not. From my experience, when the interview processes ends, it ends abruptly. This leaves little room for learning. Everyone talks about having great interview processes, but I’ve yet to see this be anything but what amounts to a `boolean false`. Consistently creating this communication will be hard, but it will keep you honest and help you improve your evaluations. 

  

7. *Test out your homework.* You want to make sure that it’s evaluating candidates the way you think it is, and not creating a bad experience. Take it from a retired teacher (and TDDer), it’s harder than it appears to write good tests. Make sure you get feedback from the first few— if not all of the candidates; you want to make sure this isn’t causing a bad experience for your interviewees. Have your current employees do the assignment and grade it anonymously.  Test test test.

  

8. Even if you give them the homework, *[do some coding in-person](http://blog.ndpsoftware.com/2014/02/favotite-technical-interview-technique-pairing.html)*. This will give you all sorts of insight into how the candidate thinks. Do what you can to eliminate nervousness, but unless all your programmers work in isolation, a homework assignment is not realistic.

  

I’ve interviewed over a hundred candidates and pair programmed with over a hundred as well. Although it’s been overwhelmingly positive, I know there are people out there working as programmers without the requisite skills. And I acknowledge there’s a need to filter them out before spending a whole team’s time with in-person interviews. At the same time, we need to remember all we’ve learned about building great software: we want a great user experience. The great UX feels simple, clear and includes a process for constant improvement. So can an interview process.

--

Special thanks to Jim “the engineer” Fung for tolerating my tirades on this subject and giving me feedback on early versions of this essay.






