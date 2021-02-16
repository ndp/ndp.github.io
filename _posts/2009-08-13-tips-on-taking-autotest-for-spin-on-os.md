---
layout: post
title: "Tips on Taking Autotest for a spin on OS X"
date: 2009-08-13
comments: false
url: /2009/08/tips-on-taking-autotest-for-spin-on-os.html
permalink: /2009/08/tips-on-taking-autotest-for-spin-on-os.html
tags:
 - unit testing
 - rails
 - tdd
---

I was excited to get [autotest](http://ph7spot.com/articles/getting_started_with_autotest) working for my last rails project. In case you don't know, autotest is a tool that continuously runs your Ruby tests as you work. It monitors your file system watching for changes, and then has a heuristic to figure out which tests to run. Once a test fails, it keeps re-running it until it passes. 

The jury's still out, but overall I really like it. Lots less navigating around tests and hitting shift-ctrl-F9 (or whatever it is). I got inspired after listening to a [year-old RailsConf talk by Kent Beck](http://blip.tv/file/1163850) about the origin of TDD (after discovering we went to school together at [UO](http://uoregon.edu/)).  

There are other tutorials that walk through the installation, so I won't repeat them here. But the additional information you need is distributed in 3 or 4 posts across the net, so here they are collected:   

### Gems 

The first trick is to get a couple additional gems (besides ZenTest, which is what you need for autotest).  

You will also want:
```
sudo gem install autotest-rails redgreen autotest-fsevent autotest-growl
```

**Autotest-rails** teaches autotest where tests are in Rails projects (as if there are any other kind). Without it, you won't see any tests running. **RedGreen** adds nice coloring. **FSEvent** makes it faster on MacOS X, and **autotest-growl**, well, growls.  

### Configuration

Second, I didn't find a complete listing of what your `~/.autotest` should look like on OS X. Mine looks like:  

```
# File: ~/.autotest
require 'redgreen/autotest'  
require 'autotest/growl'  
require 'autotest/fsevent'
```

That's it! Definitely give it a shot. It's most convenient if you have another screen for the autotest (IDE integration would be nice). And an extra CPU wouldn't hurt, because it keeps my MBP CPU pegged much of the time. 