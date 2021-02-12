---
layout: post
title: "Switching Away from Root Domains"
date: 2013-09-01
comments: false
url: /2013/09/why-not-naked-root-apex-domains.html
permalink: /2013/09/why-not-naked-root-apex-domains.html
tags:
 - naked domains
 - software development
 - dns
 - heroku
 - apex domains
 - cloud
 - root domains
---

This weekend I moved my site [amp-what.com](http://www.amp-what.com) from a PHP hosting service to Heroku. This move will give me more control; the site is an SPA, and I've struggled to get some page rank in Google with only one page. If I put it behind a node app, I'll have flexibility to add URLs freely in a way that isn't possible on LAMP stack.

Setting up the node app was surprisingly easy, and getting it up on Heroku was, of course, painless. But the final process of transferring DNS tripped me up.

My canonical URL was [http://amp-what.com](http://amp-what.com). After much thought, I decided to change my canonical domain to [www.amp-what.com](www.amp-what.com), because it would be easier and clearer. Here's why I did it.

### Facts about Web Domains 

A few facts are clear to me:

1. Each "page" should have one canonical URL. Therefore the site should be at www.example.com, or example.com, but not both. Allowing traffic at both domains just causes confusion downstream. This is a best practice of web engineering for several reasons, clarity and SEO among them. 
2. Short domain names are easier to read, remember and type. This is why I originally chose a naked domain. 
3. Cookies you set on the naked domain are sent to all your subdomains; subdomains "inherit" cookies from the apex domain. Down the road when you start using subdomains in earnest-- single sign-on, sub-applications, APIs, CDNs-- this inheritance is not what you want. In particular: 
  1. Cookies intended for one subdomain interfere with another. I've seen this with tracking cookies bleeding into to subdomains.
  2. Cookies are not shared by default. A particularly nasty class of bugs when not unifying on one domain: a users who logs in on the www domain is not logged in on the naked domain. Insert a Facebook connect step and really confuse people! 
  3. Requests will be bloated: for example, if your site is example.com, and you serve images at cdn.example.com, it may surprise you that every single image request receives all the cookies from the root domain. Remember, this also includes cookies other tools like Google Analytics has set.
 
4. Serving naked domains is problematic on cloud services. The Heroku documentation explains, 

> Zone apex domains (aka “naked”, “bare” or “root” domains), e.g.,example.com, using conventional DNS A-records are [not supported on Heroku](https://devcenter.heroku.com/articles/apex-domains).

 Following this are a couple partners that provide workarounds, but you will be locked-in to a single provider. 
5. Wherever your site is served, redirects can send the user to the canonical site. If your site is served on the www subdomain, the naked domain can offer a redirect to the www subdomain, and vice versa. 

All these facts together have changed my mind. I used to prefer naked domains, and found the "www" anachronistic. But weighing all the facts above, now I'm a believer in www. I decided to change my canonical domain to www.amp-what.com. In the case of amp-what on Heroku, I didn't want to be locked into some new DNS provider just for this feature.

### Setting WWW Up 

The steps to make this work are pretty easy. The [Heroku documentation](https://devcenter.heroku.com/articles/custom-domains) describes just two changes that I'll repeat here since they're so easy:

- DNS needs a CNAME pointing `www.amp-what.com` to `proxy.herokuapp.com`. 
- Heroku needs to know how to route its proxy subdomain: `heroku domains:add www.example.com`

### Redirecting Away from Naked Domains 

At this point, www worked. But what little SEO amp-what has points to the naked domain. This means I have to make sure the naked domain does a permanent redirect to my www subdomain. (Despite some explanations out on the web, DNS cannot redirect users. That's not what it does.) So I needed just two pieces: (1) a DNS that points to a server that (2) redirect users to www.

I discovered a nice service, [WWWizer](http://wwwizer.com/naked-domain-redirect). It's clever. If you point your domain server at them, they have a web endpoint that simply redirects to the www subdomain of that domain. You don't even need to sign up with them. They just redirect regardless. Point foo.com to them, and they'll redirect all traffic to www.foo.com. Nifty, but I was hesitant to add another piece to the puzzle.

I could leave my naked domain pointing where it was pointing before: to my LAMP server, and write a redirect there. Again, though, this is more complicated than I'd prefer.

But it'd be simpler to keep fewer people involved. Since I was using Zerigo for DNS, and they would in fact route my naked domain to Heroku, I could solve it there. With my new Node app, the redirect was easy to add:

> `// Redirect to canonical URL of www.amp-what.comapp.use(function(req, res, next) { if
> (req.host == 'amp-what.com') { res.redirect(301, 'http://www.amp-what.com' + req.originalUrl)
> } else { next() }})`

For Rails apps, you can [redirect with the router,](http://stackoverflow.com/questions/4046960/how-to-redirect-without-www-using-rails-3-rack) but this feels messy. I'd like to reroute before the request gets into Rails. Using one of these middlewares look like good solutions:

- [rack-force_domain](https://github.com/cwninja/rack-force_domain)
- [rack-canonical-host](https://github.com/tylerhunt/rack-canonical-host)

If you have Nginx, it is also easy to insert. If you're using SSL, you'll want to insert the redirect before redirecting the user to SSL, to prevent having to deal with SSL issues for the naked domain. Check out [my coworker's Jon's notes](http://jonathandean.com/2012/10/properly-handling-naked-domains-and-ssl-on-heroku/) if you're fighting SSL certs.

 
### Opposite Approach

Equal time requires I mentioned [there are other opinions.](http://blog.dynamic50.com/2011/02/22/redirect-all-requests-for-www-to-root-domain-with-heroku/)

