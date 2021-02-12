---
layout: post
title: "Shh! Algolia for the Win"
date: 2016-01-15
comments: false
url: /2016/01/shh-algolia-for-win-sitting-in-our.html
permalink: /2016/01/shh-algolia-for-win-sitting-in-our.html
tags:
 - search
 - software development
 - heroku
 - rails
 - ruby
 - ux
 - prototyping
---

Sitting in our dining room, discussing our kids’ room full of books, I decided to regale our kids with a story about the old days of the library: rows of “card catalogs," little pieces of paper to jot down call numbers, etc. This got them very excited, and they love building things, so they were gearing up to re-create just such a system in their bedroom. 

  

I waved my hands, “No, no, no, that’s not the point.” I’d show them the modern way: it's all online now. I'd toss together an Online Library Management System to help them share their books. Believe it or not, they weren’t excited-- but they agreed. Yeah, a search box would be neat.


Of course with [Rails](http://rails.org/) and [Heroku](https://www.heroku.com/) and my N years of experience, it was just an hour from idea to live, fully-functional app on the internet. We had CRUD screens for books, subjects, authors and even characters. I stood up and dusted my hands off proudly. Then my eldest daughter put on her PM hat, and reminded me of the requirements: “It’s just a search box.” 

“Yeah, I know,” I said. “Soon.” 

She'll be a hard-driving PM when she grows up. It was time to get search working. I looked at [the current options available as Heroku plugins](https://elements.heroku.com/addons#search). There were the old standards: Lucene, Solr, Elastic Search. I’d used them each on a couple projects and knew what they’d involve. I’d have to spend some time for them to provide nice results– tuning, weighting and very careful indexing. Do-able, but a lot like work.

There was an option that intrigued me. [Algolia](https://elements.heroku.com/addons/algoliasearch) promised to be the “next generation," offering good searches from the first keystroke, with in-browser integration. This is something I explored a bit with [&What](http://amp-what.com/), Algolia offered a small (& free) plan, so I was off and running.

Getting started was easy. They offer simple `ActiveRecord` integration that looks similar to Elastic Search and Solr gems. (You’re not limited to this-- there are several integrations in a host of languages. And of course the whole thing is just a JSON restful API, so you can write your own integration, if you want.)

My Rails integration was unsurprising: 

```ruby
class  Book < ActiveRecord::Base
  include AlgoliaSearch
  
  algoliasearch index_name: "Book_#{Rails.env}" do
  attribute :title, :author_name, :genre_name, :subject_names, :character_names, :isbn13

  def subjects_names  
    subjects.map(&:name)  
  end  
  ...
end
```
This declares which values are indexed. This block instrument's ActiveRecord’s save methods to capture all changes. There's nothing to install on your machine: the development model is to store everything in the cloud (hence the Rails.env to keep the cloud index separate).

You can index whatever you want. Intuitively, each of those attribute symbols is a method that is called on the book object, and the result is stored in the index. You can write synthetic attributes, like `subject_names` is above, by writing your own method. 

There are also facets. Although I didn't use these, they look more naturally integrated than they are in Solr and Elastic Search, where they feel like an add-on. 

  

The documentation is very good. The Heroku page got me started, but when I decided to change direction, I found a recipe on their website that was clear and complete. I didn’t run into any roadblocks or inaccurate documentation.

  

On the query side, it’s also full-featured. They have solutions for browser-based queries in place, so it’s easy to integrate onto a page without touching your server:

```javascript
var  helper = algoliasearchHelper(algolia, INDEX_NAME, PARAMS);
helper.setQuery(query).search();
helper.on( 'result' , function (content, state) { ...
```
I was able to get my daughter’s “search box” working almost immediately, with a minimum of additional tools. The search results have highlighting and facets built in. Nice.

But there was one big surprise. I set up an index and indexed all 91 books (that were available in my seed spreadsheet). I saw the HTTP requests going through to create the index, and their website’s dashboard has a log and complete metrics. They also have a console webpage where you can test out your index. But my indexes didn’t appear. Wha? Not just the indexed items, but the indexes themselves.  I tried the Ruby API and raw HTTP requests, with no success. But other API calls said it had created the index. Any query call reported that there was no index, and the dashboard was empty. It felt really broken. 

There was a clue, though. Each API call returns a job ID. I realized that everything was being queued up to run in the background. No problem, but how long should it take? It had been 10 minutes. I checked their status page but there were no alerts. It might have been a bad moment for their servers— or maybe indexing 91 books on a free account just doesn't get priority. Well, Rome’s Library Management System wasn’t built in a day, so I shut my laptop and went to bed.

When I awoke in the morning, my jobs had run and I had nice search results:

[![](http://3.bp.blogspot.com/-9HuqMfzQ83c/VpmQTC13r0I/AAAAAAAALzA/BpAPWw8tdL4/s320/Screen%2BShot%2B2015-12-29%2Bat%2B5.58.36%2BPM.png)](http://3.bp.blogspot.com/-9HuqMfzQ83c/VpmQTC13r0I/AAAAAAAALzA/BpAPWw8tdL4/s1600/Screen%2BShot%2B2015-12-29%2Bat%2B5.58.36%2BPM.png)

The search results are quite good from the get go. It really does instantaneous search. It also does “near” searches, stemming and all sorts of things I’m conditioned to having to take on as individual projects. For example, here’s a search for “Fate," which pulls up similar words:

[![](http://4.bp.blogspot.com/-07TYipqc8jw/VpmQZ0cx27I/AAAAAAAALzM/4O3dN6DwGLk/s320/Screen%2BShot%2B2015-12-29%2Bat%2B5.55.51%2BPM.png)](http://4.bp.blogspot.com/-07TYipqc8jw/VpmQZ0cx27I/AAAAAAAALzM/4O3dN6DwGLk/s1600/Screen%2BShot%2B2015-12-29%2Bat%2B5.55.51%2BPM.png)
  

Overall, I’m a big thumbs up. Give [Algolia](https://www.algolia.com/) a shot.  
  
My only criticisms, which I've touched on above, are:

(1) The Ruby API— and the API in general— is a leaky abstraction, as it tucks away the asynchronous processing. I'm not sure about this design choice, since it was obviously designed to be asynchronous from the beginning.

(2) I wasn’t able to see what jobs were running or get estimates about when they would be done. In anything but a toy project, these stats are critical.
