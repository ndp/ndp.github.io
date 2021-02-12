---
layout: post
title: "Should we use multiple input fields to prevent mistakes by users?"
date: 2014-07-23
comments: false
url: /2014/07/password-confirmation-input-fields.html
permalink: /2014/07/password-confirmation-input-fields.html
tags:
 - experience
 - software development
 - ux
 - a/b testing
---

At Stitch Fix, we’re working on our sign-up flow. During this process, we debated whether we should have a single password field, or, as many sites do, two— the second one being a “password confirmation”.  
  
Some sites use the same technique with email and email confirmation.

I found quite a few articles that advocated certain practices around this, but I thought it would be useful to synthesize them in one place. At the end, I offer some recommendations. 

First off, there’s no clear best practice out there in the wild. Some popular sites (like Twitter) have a single password field, and others  (Google, Amazon), have two. A few big sites (Facebook, Amazon) also have a double “email” field. 

Here’s why there's variation – let’s a/b test the email field. We give half the people one field, and half of them two, and we'll look at two metrics: (1) conversion rate of the form, and (2) email address mistakes. If everything goes as predicted, both numbers go down, meaning the conversion rate goes down but accuracy goes up. Because every company would make this tradeoff differently, there can be no single answer for all. Conversion rates may be most important for one, while accurate emails most important to another.  

  

Let's see if we can reason our way to an answer. Does using two fields ever make sense? For email fields, does a second field really reduce errors? For those of you out there that are careful with what you type, the duplication is unnecessary, and busywork. For those of us who copy and paste, this won’t catch an error, nor will it catch errors for the people who mistype their email in the same way habitually (you know who you are). It will just catch the small percentage that are left, who type their email address correct only about 50% of the time or more. 

  

Taken to the logical extreme, if this were a great way to get correct input, wouldn’t every credit card form feature two credit card number fields? Or wouldn’t it be best practice to double every important field? Or triple really important ones? Of course not! So this technique does not make much sense for an email address. There are better techniques for email addresses, such as validating domains or sending confirmation emails.

  

I also think there’s also a subtle psychological effect here. When I see a double email field, I am annoyed— you don’t trust me to type my email correctly? I’m annoyed, but generally continue on with the form. In general, I’d like to be treated with respect, and asked only for the essential information, and be trusted to provide it accurately. So, this UX may be communicated certain values unintentionally.

  

**Passwords** , however, are masked, so should we be treating them differently? In the olden days, I’d type in my password, and was not sure if I got it right, since none of the characters were echoed back to me. So the second password field allowed me to type it a little more carefully again, and then see that I got it right (twice!). 

  

Password fields are nicer now. Most browsers will show you the character as you type it, and only fade it out after the next character, or some amount of time. Newer versions of IE even have a “peek” mode, where the password can be shown in its full glory. By  the time we're at the end of the first password field these days, we're pretty confident in what I typed.

  

Passwords are also more sophisticated, and typing them is either tedious or avoided. Many use longer passwords that really are annoying to type repeatedly. Although I' sure there are a percentage of users that rely on the warm fuzzy feeling of seeing that they typed the password the same way twice. For me, I’d rather just go through it the typing once, very carefully. Or use a password manager, which does the duplicate entry for me.

  

So overall, duplicate entry for passwords is less valuable than it once was.

### Conclusion

So is there an answer here? A few learnings and recommendations:

- Start out with a single input field. This is nicer for your users, and there’s no overwhelming evidence that duplicate fields are better.
- If you have problems with lots of people not knowing their passwords, make your “Forgot your password?” flow nice and self-service. If you still aren’t satisfied, A/B test a confirmation field, but don’t be surprised if the answer isn’t obvious.
- If you have problems with bad email addresses, make sure you are doing what validation you can do. At Stitch Fix we eliminated a significant number of email bounces by improving our email validation. Beyond that, for more robust sites, consider an “email confirmation” flow. 
  
