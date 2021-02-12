---
layout: post
title: "Friendlier Session Timeouts 2.0"
date: 2011-03-28
comments: false
url: /2011/03/friendlier-session-timeouts-20.html
permalink: /2011/03/friendlier-session-timeouts-20.html
tags:
 - sessions
 - software development
 - rails
 - design
 - javascript
---

As we discovered today, coding up friendly session time-outs involves more than meets the eye. As you know, a session time-out logs the user out after a period of inactivity. But interactions with web sites, and "inactivity," have changed over the last 10-15 years.  
  
We have a fairly plain Rails app, and we're implementing a series of security fixes in anticipation of an audit. In what seemed like a simple "1-pointer", we were asked to remove the "Remember Me" checkbox from our application, and force the user to be logged out after 20 minutes.   
  
For the first pass, we simply set the session timeout to 20 minutes and removed the checkbox (and the underlying implementation). Easy eh?  
  
Sadly, this solution leaves much to be desired. When the user (or Q.A. engineer) returns after 1/2 hour, the page is unchanged and ready for action. But any click redirects, confuses, and potentially loses in-progress work.  
  
Although this might have be acceptable in 1998, it's 2011 and we got Ajax. Clicking a link on a Web 1.0 site takes you to another page; if you happen to be logged out, oh well, sign back in and continue-- you probably weren't doing something that important anyhow.   
  
But these days, on an Ajax page, if your session expires while you're viewing the page, clicking on any element of the page can reveal a session timeout. This may appear to the user as a server error, or if it's handled correctly (like we did), a page redirect. Clicking on a disclosure triangle redirects to a new page? Now we have a surprised user.

[![](http://4.bp.blogspot.com/-dAHRdyyCfuM/TZFhGYWnjVI/AAAAAAAAAy0/NWMu5i06-M0/s320/Picture%2B7.png)](http://4.bp.blogspot.com/-dAHRdyyCfuM/TZFhGYWnjVI/AAAAAAAAAy0/NWMu5i06-M0/s1600/Picture%2B7.png)
  
I Googled a bit and found lots of bug reports around this behavior. As this Jira snapshot shows, resolving this might be trickier than anticipated.  
  
I checked out my bank's solution. It looked like they implemented a whole timeout scheme in Javascript. Were they wacko? (No... but we'll get there.)  
  
Of the hand full of ideas out there on the web, here's one solution ([of a hand full](http://www.sidesofmarch.com/index.php/archive/2005/01/30/friendly-session-timeouts-the-javascript-way/)) with the idea of timing the session in Javascript:  
`<script
      language="javascript">function confirmLogoff() {  if
      (confirm("Your session will end in one minute.\n\nPress OK to continue for another ten minutes.")){ 
      location.reload();  }}setTimeout("confirmLogoff()", );</script>`  
  
At first blush this looks like they might be on to something. Alas no. The confirmation will only work the brief period between the client and the server timeout. I'd argue it's even worse than no solution, since the messages promises something it can't deliver on, and loses the user's work-in-progress.  
  
Did I mention we have **quite a few pages with AJAX requests** on them? These conveniently extend the session timeout on the server when the user interacts with them. But they break any sort of client-side timer that is set up at page load. Any sort of "meta refresh" schemes doing something similar to the above were quickly dismissed.  
  
And why should just AJAX backed behaviors restart this timer? Opening a hidden panel may or may not go to the server (depending on an developer's whim), but should this whim this really affect the user's timeout? So we started considering implementations that ping the server as the user interacts. This was also dismissed as being complicated to implement efficiently (and potentially introducing some sort of security issue).  
  
Finally where we "settled" (as in prom date), is implementing a timeout within Javascript, like my bank. It's a little more sophisticated: it's reset not only by the initial page load, but all sorts of user interactions. The code finally reduced down to:  
`var
      clientSessionTimeout = function(timeoutMS, logoutFn) {  var lastTimeout; 
      var startSessionTimeout = function() {    if (lastTimeout)
      clearTimeout(lastTimeout);    lastTimeout = setTimeout(function() {         
      logoutFn();      }, timeoutMS);  };  // Watch for activity 
      $('body').click(startSessionTimeout).keydown(startSessionTimeout);  startSessionTimeout();};`  
  
This is called with the 20-minute timeout, and implements it beautifully:  
`    clientSessionTimeout(20 * 60 *
      1000, function() {      document.location =
      '/timeout?return_to=' + document.location.href;    });`  
  
The server side timeout is for redundancy. Our pages are all pretty focused, so I doubt any user will spend more than a couple minutes on any one of them. We picked a server-side session timeout of 40 minutes. The only way the Javascript timeout won't kick in first is if the user interacts with the page for more than this time with no server side interaction... possible, but not likely.  
  
After completing this compromise solution, I'm ready to spell out some ideal requirements:  
* session timeout with no interaction after 20 minutes  
* any interaction on the page should reset the timeout  
* warn the user (if possible) when the deadline approaches  
* this shouldn't open additional security vulnerabilities or server traffic  
  
With some additional work, I'm sure an "ideal" solution can be developed. This compromise should get us most of the way there. Thanks to the rest of my team, and an interview candidate who provided some clear thinking on the matter. 
