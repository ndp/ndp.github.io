---
layout: post
title: "Rails Fixtures with Integrity & Validity"
date: 2010-03-06
comments: false
url: /2010/03/rails-fixtures-with-integrity-validity.html
permalink: /2010/03/rails-fixtures-with-integrity-validity.html
tags:
 - unit testing
 - rails
 - agile
 - tdd
---

A new developer on the project changed the symbolic name of one fixture record  and broke a whole bunch of tests in unexpected ways. Pairing, we discovered a some interesting stuff.  
  
First, if you've never dug into them, it's critical to understand how symbollically named fixtures work. We rely on them heavily, but only yesterday read the code. If you have a fixture like:  

```
bill:

  full_name: ...
```

And another fixture:

```
socks:

  owner: bill

```  

Rails magically inserts bill's ID into socks' record. (Before this feature, developers had to manually manage their IDs and keeping fixtures working well was less fun.)  
   
   
Nifty. I assumed (incorrectly), that there was some sort of lookup of records involved. So if I change the name of the "bill" fixture to something else-- let's say "william", I expect Rails to complain. It doesn't. There's no data integrity to the fixture system-- at all.  
  
 We traced though the code and now understand why: When Rails comes across the symbol "bill", it creates an integer hash of it and sticks it into the id column. It'll be a big number like 39384022 or something. Well, if you change the name to "william", it generates a different hash. That's it. At no time does it go back to verify that such a hash exists. It's really just a nice name for a number! Unless your database has constraints that enforce this (which will make loading fixtures more difficult and generally isn't done), you won't see a problem until a test fails.  
   
  
Once we discovered that, we asked, "wouldn't be nice if there was a test that checked the integrity of the fixtures?" With a little work, we had just such a test, which relies on the validation system:  
 ```
 describe "fixture integrity" do

  ActiveRecord::Base.send(:subclasses).each do |cls|

    it "each fixture for class #{cls} should be valid" do

      cls.find_each do |record|

        record.valid?.should(equal(true),"Invalid fixture for #{cls}:\n  #{record.errors.full_messages.join("\n")}\n#{record.inspect}")  
      end

    end

  end

end
```

Unfortunately that passed until we added a the appropriate validator  

```
class Child < ActiveRecord::Base

  validates_presence_of :parent
  ...
```

(Make sure you validate "parent", not "parent_id". "parent_id" will be set-- it just won't point to anything.)  

That's it. A simple test and you won't risk your fixtures floating too far from the data structure you expect. Thanks to Lowell Kirsh and Jonah for pairing on this.
