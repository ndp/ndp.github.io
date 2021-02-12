---
layout: post
title: "In Pursuit of More Modular CSS"
date: 2008-02-15
comments: false
url: /2008/02/in-pursuit-of-more-modular-css.html
permalink: /2008/02/in-pursuit-of-more-modular-css.html
tags:
 - css
 - software development
 - style
---

## First Love
  
My experience with CSS is typical. I started out like many developers, ignoring CSS, focusing on the "meatier" programming tasks of building web sites. Eventually I realized: Hey, cool, you can control the display the font of the whole page in one place-- nifty. I quickly gave my site a face-life and was sold.  
  
This simple usage evolved into sharing a style sheet for the whole site, so that it could all be modified when needed. This is the idea behind CSS, expressing global rules, it makes a lot of sense.  
  
But as anyone who has build a significant site knows, there will be little exceptions to global rules, so slap a class on something, or just use some embedded CSS, and continue (to focus on the meatier stuff). No problem.  
  
But when I went back to my masterpiece six months later, it looked like a tangled mess: A huge CSS file, and what did one class mean, and how was I supposed to use it? What does class="side" mean, or when should I use span="yellow" to be consistent with the rest of the site?  
  

## Getting Organized
  
So then got more organized. The basics are easy: follow naming conventions and keep it simple. XHTML arrived with a movement towards web standards. Instead of using HTML tags willy nilly, I now use "semantic markup". The basics of this are to use mark-up that describes its intent, instead of its display. For example, a tag like &lt;h1&gt; describes the purpose of its content (a heading), whereas a &lt;i&gt; tag only says how to draw it (and not that it's a book title). These basic guidelines got me quite a bit further.  
  
Anyone who's stuck with a project for over a year can attest that even with these rules, the CSS becomes a difficult area, often costly to maintain or change. It's not uncommon for changes to one page to inadvertently affect other pages. Or CSS developers just "get slower" as project matures... (whereas actually you'd expect a development team to get faster as they build more of the framework).  
  
Although CSS is powerful, it doesn't offer the same tools that object-oriented or programming languages offer.  
  

## The Solution
  
  
Software development has taught us that a few principals trump all other concerns in a large project: simplicity, consistency and modularity. With consistent naming conventions and semantic mark-up, we have tools to help us keep it simple and consistent, but there's really not good rules for modularity.   
  
Through the last few years, though, I have come up with a scheme that keeps CSS modular. I have developed several large web projects with literally hundreds of user interface elements and pages, and kept the CSS modular. The team was able to safely modify display rules without unintentionally breaking other pages.  
  
The guideline is simple: modularize geographically.  
  
Geographic Modularization  
  
What this means is that as you break your page into rectangles, don't only modularize the markup this way, but modularize the CSS this way as well.  
  
This may sound obvious, but what happens naturally is the opposite. Usually we modularize based on the element, class or style. For example, we'll define what the H1 looks like for our site, and then as we build out more pages, define exceptions for the line-height, padding or what-not. Or we define what an <label> looks like, and then add exceptions depending on the context. It gets messy quickly.<br><br><span style="font-weight: bold;">An Example</span><br><br>Let's start
      with an example of the right way. Here's the user interface element:<br><br>Search ____________ [
      GO ]<br><br>Let's call this the "siteSearch".<br><br><span style="font-style:
      italic;">Modularize the Markup </span><br>First, let's modularize the markup. This markup should
      be as simple as can be, except we make add a class or id to the outermost element so we can style it. (Add a class
      if there can be more than one per page, or an id if there's just one on the page.) I'll repeat it, because it's so
      important: <span style="font-style: italic;">Always add a class or id to the outermost element of your
      module.</span> Name it just like the module, so others know where it belongs. Put it in it's own file
      (depending on your view framework):<br><br><span style="font-weight: bold;">siteSearch.html</span><br><form action="/siteSearch.html" style="font-weight: bold;">id="siteSearch"&gt;<br><label>Search</label><br><input type="text"><br><input type="submit" value="Go"><br>
</form>
<br><br>Modularize the CSS<br>Put all the CSS that pertains to this in its own file.<br><span style="font-weight: bold;">siteSearch.css</span><br>#siteSearch label { display: inline; padding:
      0 10px; color: #555; }<br>#siteSearch input { ...<br><br><span style="font-style:
      italic;">Use the selector mechanism to scope all the style rules for the module</span>. Don't define or
      rely upon any style rules outside of this module. Don't define a rule with a generic "label" selector, otherwise
      it can interfere with other labels on the page. "Scope" it to the module that it is in.<br><br>Displaying
      the Module in Different Contexts<br><br><br>Defining "container" Modules<br><br><br><br>Let's start up with some simple markup to display a promotion for our a newsletter:<br><div>
<br><br><br><br><br>
</div>
<div style="border: 2px
      solid orange; padding: 5px; background-color: beige;">
<br><ul>4.<br> Modularize
      geographically<br><br> Organize and break up the CSS using the same principles you use to organize
      the other code and markup. For example, if you are using JSPs and you create a tag file for the footer called
      footer.tag, place corresponding CSS rules in footer.css, and place that file in a path identical to the tag file.<br><br> This leads you to modularize CSS based on geographical areas of the page. This is a simple and
      understandable organizing principal. It also facilitates debugging-- there's one very clear place to look for
      selectors.<br><br> Unless trivial, it's best to create a css file for each page with custom
      selectors. For a page with its own styles, an embedded <style></style> element may be fine. Just
      remember that if the CSS is in a separate file, the browser can cache, which may be important.<br><br>
      The only variation on this "geographical" organization is forms. If you have a consistent form styling, it seems
      reasonable create a form.css to encapsulate it.<br><br><br><br>Recommended
      Approach</ul>
</div>
    </label>
