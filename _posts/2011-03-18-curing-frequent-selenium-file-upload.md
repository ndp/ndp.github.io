---
layout: post
title: "Curing Frequent Selenium File Upload Failures"
date: 2011-03-18
comments: false
url: /2011/03/curing-frequent-selenium-file-upload.html
permalink: /2011/03/curing-frequent-selenium-file-upload.html
tags:
 - selenium
 - rails
 - ruby
 - tdd
---

The symptom was quite simple: do an upload, and on the next request the server reports an "IOError". As our Ruby on Rails app is pretty much thin workflow around lots of file uploads, this was a problem. We tended not to see in on production, but us frequent users were seeing it enough to know we had to do something about it.  
  
But the real complainer was Selenium. About half the time the tests failed and needed to be coaxed into running again.  
  
[JWinky](http://github.com/jwinky) traced the root cause down to a known bug in the temp file class. With a little work (and encouragement by yours truly), he put together a patch that has eliminated the problem. We've been running with it for a couple months and haven't seen the bug once-- or heard a peep from Selenium.  
  
It's found here: [http://github.com/jwinky/ruby_tempfile\_ioerror](http://github.com/jwinky/ruby_tempfile_ioerror)

