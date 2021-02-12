---
layout: post
title: "Implement Most Popular the Easy Way (hint: use Google Analytics, garb and Rails)"
date: 2010-02-06
comments: false
url: /2010/02/implement-most-popular-easy-way-hint.html
permalink: /2010/02/implement-most-popular-easy-way-hint.html
tags:
 - design
 - javascript
 - cloud
 - agile
---

Over the last few years I've implemented "most popular" posts, questions, lists, companies, users, pages, searches, cities, and who knows what else. It's not difficult. I've always implemented this myself-- using a few columns in an SQL database, but found something didn't smell right. We already have this free tool-- [Google Analytics (GA)](http://www.google.com/analytics/)-- which is collecting usage data on my site. Why would I want to store this data redundantly?  
  
In this post, I'll walk you through what we did on my most recent project for the [National Campaign](http://www.thenationalcampaign.org/). There are three steps: collecting the raw data, processing it into statistics, and displaying it to the user.  
  
Using GA you can completely outsource the data collection. For the statistical analysis, you gain flexibility-- more on that later. Finally, I won't talk at all about displaying the results to users-- that's up to you.  
  
**Step 1: Collecting the Data**  
  
If you are already using GA, you're done-- you're collecting data. If not, you simply need to create an account and start using it.   
  
Fortunately, using RESTful conventions, most using actions end up being "page views" of some sort. But there might be other steps you want to take. For example, we had a page that served up content via Ajax, and I hadn't bothered to instrument them with GA yet.  I added one line of Javascript to the Ajax callback:  pageTracker._trackPageview(questionLink);  And it can get more complicated: if your definition of popularity involves something beyond your pages, you'll have to dive into the event tracking or custom variables of GA (which I haven't done).   
  
It's worth pointing out that if you don't use GA on a project, you need figure out what data to collect and how to store it. This involves the business owners expressing their requirements, and the developers debating which database table to use and how general a solution to build. You can imagine this can be a small sink-hole if you're not careful.  
  
  
**Step 2: Processing the Statistics**  
  
The hard problem to solve here is to create a function that calls out to GA, collects the data, and saves it into your database.   
  
_Understanding the API_  
Although you really don't need a deep understanding of [the API](http://code.google.com/apis/analytics/docs/gdata/gdataDeveloperGuide.html), you should at least skim it. The salient points are to understand the differences between accounts, profiles and sites. Run off and read it now.  
  
_Install the Rails Gem_  
You'll need to get "garb"-- not as in trash, but as in Google Analytics for Ruby. Install it:

  gem install garb
or  

  config.gem 'garb' # in environment.rb
  rake gems:install  
  
_Profile Access_  
  

  require 'garb'

  def self.create_profile(acct, username, password)

    Garb::Session.login(username, password)

    Garb::Profile.first(acct)

  end
  
_Retrieving the Data_  
  
To retrieve the data, you generate a report. For this, you'll need:  

- **dimensions** : I just asked for page_path. If you ask for just one dimension, you can think of it as the row headers in the table you get back.
- **metrics:** I just asked for the pageviews-- it's the values that go in the row cells returned. You can also ask for bounces, visits, entrances, exits, etc. You can envision a complex definition of popularity that's the pageviews but you could subtract off bounces and exits ([or any of the fields](http://code.google.com/apis/analytics/docs/gdata/gdataReferenceDimensionsMetrics.html)).
- **sort** : one of the metrics
- **filter** : since I was only looking for the question's show action, I filtered out all other pages. The final code for us looks like:

>   def self.report_results(profile)  
>     report = Garb::Report.new(profile)  
>     report.metrics :pageviews  
>     report.dimensions :page_path  
>     report.sort :pageviews  
>     report.filters do  
>       contains(:page_path, 'questions')  
>       does_not_contain(:page_path, 'edit')  
>       does_not_contain(:page_path, 'new')  
>       does_not_match(:page_path, '/questions')  
>       does_not_match(:page_path, '/questions/')  
>     end  
>     report.results  
>   end

You can also add date ranges on this... by default it follows the GA conventions of returning the last month's worth, which is what we wanted.  
  
This function returns an array of Structs, with two properties in each struct: pageviews and page_path.   
  
If you ask for a long report, you'll need to page the results. Refer to the garb documentation to see how to do this.  
  
_Saving/Updating the data_  
  

  def self.update_page_views(report_results)
    report_results.each do |row|  

      if /\/questions\/(\d+)/.match(row.page_path)

        q = Question.find_by_id(Regexp.last_match(1).to_i)

        q.update_attribute(:pageviews,row.pageviews.to_i) unless q.nil?

      end

    end

  end
  
This logic can be tested using MockRow described above:  

  

class MockRow &lt; Struct.new(:pageviews, :page_path);end

... 

Question.update_page_views [MockRow.new('50',"/questions/333")]
  
Getting this scheduled and run with the correct credentials is the last piece of the puzzle, which I'm not covering here; see cron, DelayedJob and your host.  
  
**Benefits**  
  
As you can see, there's nothing that tricky about this. A pair of us had this up and going in a couple hours (although we did spend time getting the DelayedJob running). There are a few important benefits:  

- It's a cleaner architectural with less server load than doing it yourself. You don't need to pollute fundamentally read-only operations with database writes.
- Better metrics. GA can give you a more sophisticated metric than you could do easily. For example, it's easy to collect raw page views, but collecting unique page views or sessions is a bit more work.  
- You can change what metrics you use in an ad-hoc basis. For example, you can decide to only count posts from the last week in the most popular, and it's a simple code change. More interesting, you 
- Can eliminate or at least reduce developer and testers from metrics discussions. You won't have to be there to answer "can we make the most popular pages the ones that people spend the most time on?" If it's in GA, you can us it.  If the product owner understands GA, she can figure out how to define "most popular" to produce the results she wants. 
- If you have already been running your site for a while, but are adding most popular support, you may already have a rich set of data on hand. This wouldn't be possible if you rolled your own.
I think this will be a core part of any new site I develop. It's so convenient to have access to this rich data set without any of the burden of collecting it. I hope it works out as well for you,  
  
-- Andy  
  
  
**Other Versions**  
There are wordpress (drupal, etc.) plugins that do the same thing, but nothing that would work directly for us. For example, [http://www.myoutsourcedbrain.com/2009/11/blogger-most-popular-posts-widget.html](http://www.myoutsourcedbrain.com/2009/11/blogger-most-popular-posts-widget.html)<h2>Comments</h2>
<div class='comments'>
<div class='comment'>
<div class='author'>Matenia</div>
<div class='content'>
This is the first post i have seen in my last 5 hours scouring the web, that actually explains and shows more code examples ....  
  
Thanks

</div>
</div>
</div>
