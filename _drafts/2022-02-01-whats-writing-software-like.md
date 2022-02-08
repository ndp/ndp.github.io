---
layout: post
title: "What is Working as a Software Engineer Like?"
date: 2021-11-09
comments: false
tags:
- software development
- interviews
- react
- sheetshow
---

# What is Working as a Software Engineer Like?
In college I wrote an essay comparing programming to architecture, from a process, thought-process and business. It was a college stunt, compare-and-contrast, to fill a few pages and pass the class, and I'm not willing to stand behind much of it. But I think it is interesting to ask-- especially in the context of many new people entering or considering entering the field-- what is a programming job like? In this essay I'll write about my perspective on this. I come from a specific background and experience, and am not attempting to write a definitive breakdown on the subject. But I think I can, perhaps, ellucidate a few things that might end up helping others.

I'll stand by one of the reasons I joined the field: the work varies,  you're constantly learning and no to days are identical. This is very much a bias of my personality, that's true. There are some people who approach the job in a much more structured and organized way than I do. I am in awe of these people for their discipline that I haven't been able to muster. But in all the organizations I've been in, the projects are about creating new things, whether it's a whole new product, or a feature or infrastructure. Either way, I've never had the experience where I grumbled, "Ugh, the same work as last week." Certainly there are things to grumble about: politics, personalities, etc. But the work evolves and changes. If you're someone who wants to learn some skills and clock in hours for pay-- I've certainly heard this voiced--, writing software will not work for you. I  know this field is evolving, but it's hard for me to imagine the field will ever be like this. As soon as our work is routine, it is automated away and we move on to new challenges. 

## Science
When I see "science", I think of **the scientific method** we learned about in 8th grade, as outlined by Galileo Galilee (and by my 8th grade chemistry teacher, Mr. Michelson):

1. Make an observation.
2. Ask a question.
3. Form a hypothesis, or testable explanation.
4. Make a prediction based on the hypothesis.
5. Test the prediction.
6. Iterate: use the results to make new hypotheses or predictions.

I see this process in use in just one area of software engineering: debugging, which can take anywhere from 10-90% of your time. This process is followed to the letter for debugging-- at least by those who are proficient at it. 

It's also followed-- or at least alluded to-- by some product organizations, which make an observation about the users' needs or behavior, and then iterate to software solution. Of these organization, only a few will actually frame new development as "experiments". This science, though, it's not directly part of software engineering or programming.

So, as far as science, yes, we use scientific methods mainly in debugging.

## Math
People will say, "I don't use any math in programming." Perhaps these people don't notice they are using math, or in fact, don't actually use it. I personally see math everywhere. 

General programming has time and space complexity calculations, set theory and most of logic and  discrete mathemetics. On a daily basis, it's useful to be able to do back-of-the-envelope calculations about how much space something will take, how long a transfer will take, how much a certain server scaling configuration will cost. When a bug pops up, there's all sorts of statical and cost/benefit analysis to be done as part of triaging the bug.

And of course when I've worked on specific tasks, I run in to specific math I need to pull out: geometry facts for any sort of graphics programming, statistics for any sort of experiementation, linear algebra for data analysis, and even calculas every once in a while. 

(And a great thing about programming is that it crosses so many domains, so when I worked on an audio editor, I learned about Fourier analysis; when I worked with naval architects, I had to learn about statics and dynamics; when I worked on a word processor, I learned all about typography, etc.)

Perhaps it's possible to get by without a strong math background, but I suspect you will struggle a bit to understand what's going on around you.

## Engineering

The definition of engineering is the application of science and maths to solve problems and design or make things. So software engineering is definitely engineering, despite what some people say.

Day-to-day, though, lots of what we do is not "engineering" in a pure sense.

There's a more limited view of an "engineer", which is more what I've run across: they are not designing and making things, but a part of later in the creative process. They take the plans of an architect has already created and make sure they will work, or they help figure out the algorithm to make sure the plane or ship is stable. A software engineer's day-to-day job doesn't look too much like this. Perhaps we're just working in a less constrained environment, so provisioning a new machine (or 10) is an easier decision than requiring different bolts on a skyscraper or bridge. There is a part of software engineering that this resembles-- DevOps-- which is more concerned with the stability and robustness of the system, and less about what it actually does.

## Legislating
In one aspect, software engineering parallels political legislating. A politician sees a problem, and then must figure out a solution. Often this is not a direct solution, but a set of laws that when enacted and enforced, will solve the problem, without having too many deleterious side effects. This is very much what writing a program is: writing some rules for a computer to execute, and being able to visualize the unknown of what happens once the program is off running in the wild, interacting with other code and users. This "systems thinking" is one of rarer skills of software engineering, but very impressive when someone can consider the effects of a very small change on millions of lines of code.

## Design

A [designer](https://languages.oup.com/google-dictionary-en/) is "a person who plans the form, look, or workings of something before its being made or built". As a programming, this is a huge part of what I do. There's the outwardly visible part of software that everyone sees, and this has largely been turned into a specialty and take out of programmers' hands. But there's the internal design of the code and systems, which programmers still own (except when it's delegated to "software architects").

I would point out that software is a different medium than clay, paint, charcoal, music, etc. It is *soft*ware, and perhaps the most forgiving medium. It took the industry a long time to get here, but it's now recognized that software is very easy to change and requires a different  process. If you're carving a statue, sometimes there's no going back after to take a chunk off the rock. With software, you can almost always go back. And it's only getting more forgiving. The design phase often extends past and merges with the production phase. Things can be changed even after the software is being used. We have developed "unit tests", so we can more freely refactor software later on. It's the equivalent of deciding you should have used 1/2" longer nails in your house, and with a few clicks of the mouse, have a stronger house.

## Architecture

Architecture is a specific design practice having to do with creating structures. It has parallels to software in that it is more practical than some arts, and requires a diverse team to complete any but the smallest projects. There are many parallels in terms of gathering requirements, figuring out an approach, and putting together design concepts. But software engineers tend to own more of the process, all the way to the final "punch list" of onboarding users.

## Other Arts: music art cooking painting

I have a soft spot for other art forms, and tend to see the parallels with software. There are parallels with writing music, but I tend to not see much connection with musical performing. Music requires practice and the ability to think consistently and quickly to perform. Software allows slower, more inconsistent practices, and tools are constantly changing so facility with one tool, although valuable, is less valuable than it is for a performing artist.

I often think about "sketching out" my first draft of software, when building a prototype. XP and other agile methodogies can allow you to apply more layers of paint, and refine a piece of software the way painters will.

Software:

- does not require the **consistency of performance** required by many artforms, especially the performing arts. You generally have a chance to fail many times in private, and rework something many times to get it right. People aren't usually programming live (except during job interviews!)
- does not require the **creation speed** than something like music improvisation or journalistic writing needs. Projects will have deadlines, but you aren't expected to do write specific code at a specific time. You generally have a space away from the clock to get to the required quality. (Again, except at job interviews).
- does not require programmers to be "meta", and **explain or interpret** their work. Many artists are required to contextualize and explain their art, and only those that are exceedingly good at exceed. But software tends to exist in more of a raw business environment, where success is defined externally (usually by dollars). 