---
layout: post
title: "First grade first"
date: 2006-01-06
comments: false
url: /2006/01/first-grade-first.html
permalink: /2006/01/first-grade-first.html
tags:
 - style
 - coding
 - java
---

Is using temporary variables was messy? I now advocate writing 1st grade code. By that I mean "See Dick run. See Jane smile." etc. Hey, we're all adults here, you say, why can't I write real code.  
  
Well, writing really simple code makes debugging easier. What do I mean? I've had a couple occasions in the last week where debugging would have been easier if I'd writing really simple code. For example, I just got an null pointer exception here:

```
_dataSetsNeedingCleanup.add(new DataSetRef(state, dataSet.getId()));
```
  
  
I can't easily tell where the problem is coming from. It could be one or two places: my member variable _dataSetsNeedingCleanup could be null, or dataSet itself code be null. If I had written it like this,  
  

```
final DataSetRef dataSetRef = new DataSetRef(state, dataSet.getId());
 _dataSetsNeedingCleanup.add(dataSetRef);
```
  
a stack trace provided by the user tells me exactly what's wrong. This saves me a whole step in the debugging cycle! 
