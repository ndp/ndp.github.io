---
layout: post
title: "Technology Cleanse: GoToMyHead.site Case Study"
date: 2023-03-21
comments: false
tags:
- HTML
- CSS
- software development
- visualization
- javascript
- prototyping
- mini-project
---

I recently spent a few hours building  [gotomyhead.site](https://gotomyhead.site), which is an MVP app to find lead sheets in the popular fake (aka real) books. (You can read more about it [here](https://blog.ndpsoftware.com/go-to-my-head).) It's a "mini-project", and even if the project domain itself doesn't interest you, my development approach gave me what I think are interesting insights to share.

The modern way to create  software app is to clone a template app or run a "meta" script that installs all the "stuff you're going to need" for a modern web app. This setup step is exemplified in the ambitious and popular CreateReactApp. Rails, a complete framework itself, even spawned [tools to give you you even more.](http://railsapps.github.io/rails-application-templates.html). A recent trend is for hosting providers (PAASes) to leverage (or even provide) these setup tools to bring you to their hosting platform. Sadly, many new web engineers see this as the first step to any project. 

To be honest, I've never liked this approach. Yes, you're up and going fast, but the cost is high, but paid later. The abstraction of these great "uber" tool provide fails, as you _are_ going to need to know how to deal with the underlying technologies. Because of the fast-evolving tech ecosystem, you'll run into the problems almost immediately. You quickly discover that the uber-tool you used to build your app doesn't have all the documentation for the underlying technologies. You'll realize that unless you understand how all the pieces fit together, it will be hard to fix problems (unless a StackOverflow answer comes to your rescue). You have to break open config files to figure out where to look, and which versions are involved. This challenge becomes even more acute as the software evolves, as you need to upgrade these underlying tools to fix security vulnerabilities or bugs. Although it's not impossible to solve, it's a rare uber-framework that has a good maintenance and upgrade story.

Instead, I like to approach new projects by _reluctantly adopting technology_.  As a result of this practice, my projects tend to have fewer dependencies than my peers' projects. It's the agile approach of only adding a tool when you feel real pain in not having it. For example, for one web app we built from the start, we didn't even select a database nor create the  schema for weeks into the project. (In fact, we did user testing on our production app before we had a database!) Instead, we simply modeled what we needed to in data structures built-in to the language. When we adopted a database eventually, we had an strong idea about what the schema and data looked like. 

I don't like these starting with a large set of dependencies, but I have found myself installing Typescript, a code bundler like ESBuild, a web server and a testing framework. I tend to think of Typescript as a low-bar for new projects, but this time I decided to even question that. And as soon as I decided to forego Typescript, I wondered how few dependencies I could get away with. It became a _cleanse_, or sorts, and I ended up without _any_ libraries or dependencies. Although this little app could be a standard database-driven web app, it didn't need to be. Here's a blow-by-blow description of how I developed a no-tech web app:

### Data

The first step was to grab some data. I discovered quite a few projects out there focused on creating the data I needed, so I went with the "what's the fastest and cheapest" approach, and found a unified file that had just the data I needed. (I'd make different trade-offs on other projects.) 

#### Ingestion

I found a space-separated text file and put it in a `data` folder inside my empty project direction. It has a tune title (with spaces), a book "code" and a page number:
```
...
Triple Play JazzLTD 363
Triste Colorado 251
Triste NewReal1 370
...
```
To make this usable in a modern app, it would be easier if it were JSON, so I created my second file, an  ingestion script in Javascript that converted it to JSON. Even if I did need a database later, this would be a good intermediate step. This is straightforward nodeJS script that gave me a long list of chart entries:
```javascript
  ...
  .split('\n').filter(line => !!line)
  .map(line => {
    const m = /^(.*) (\w+) (A?\d+)$/.exec(line)
    return {
      name: m[1],
      book: m[2],
      page: m[3],
    }
  })
```
#### Data Modeling

One of my complaints I have about the other tools is that they list the same song multple times in the search results, making the user sort it out. This is like a google that doesn't aggregate the pages from the same site! I wanted to do better, and make it easy for the user to select the chart in the book they wanted. So I need to distinguish between a **song** and a **chart**: it's a 1 to N relationship, multiple fake books will have the same song, and the performer wants to be able to pick one chart. This is a traditional parent-child relationship, with foreign keys and multiple database table. But I am not feeling the need for a database, yet, so instead I'll transform it to a more usable JSON format:
```typescript
[
   {
      songName: string,
      books: {
           [book_title]:  number
         }
   },
   ...
]
```
This is a basic `groupBy` function, handled by a reduce call.

I wrote it, but quickly ran across a complication.  I discovered that the chart titles for the same song often don't match. The simplest title can show up a variety of ways:

- _Shadow Of Your Smile_
- _The Shadow Of Your Smile_
- _Shadow Of Your Smile (The)_

These match to a human, but not a computer. In addition, a song might also (sometimes) include the first line, as in _These Foolish Things (Remind Me Of You)_. There are also reasonable spelling variations, like  _until_ or _'til_ or _till_. And numbers are sometimes spelled out and sometimes not. 

This is a common software engineering problem, and I have found the easiest solution is to create a single "spelling" for a song title that will map all spellings of the same song into the same "song key". It's similar to a hash key that maps them to the same bucket. I call this the **canonical key** for a song. (_Not_ the "key", like Bb or F#.) It's a simple function:
```javascript
function songKey (s) {
  return s
    .replace(/^(the|a) /i, '')
    .replace(/ \(.*\)$/, '')   // throw away first line hints
    .replace(/ three /, ' 3 ')
    .replace(/in'/, 'ing')
    .replace(/'?Till? /, 'Til ')
    .replace(/'Bout/, 'About')
    .replace(/ O' /, ' Of ')
    .replace(/Walkin('|g)?/, 'Walking')
    .replaceAll(/\W/g, '')     // squish
    .toLocaleLowerCase()
}
```
So, I pipe the array of songs and assign them each a key. Then, I combine the entries using `reduce`, as anticipated. But now that I have a key distinct from the song name, I switch the data structure to an object (map):
```javascript
  .reduce((m, chart) => {
    const key = songKey(chart.name)
    if (!m[key]) {
      m[key] = {
        names: [name], // save multiple names to aid in search
        books: {
          [chart.book]: chart.page,
        },
      }
    } else {
      // save multiple names for the same song
      if (!m[key].names.includes(name))
        m[key].names.push(name)
      m[key].books[chart.book] = chart.page
    }
    return m
  },
  {}
)
```
That was it. I had a nice JSON file with the data I needed. 

### HTML

The next step was to build some markup so I created an `index.html` file circa 1998, and added what was needed: an `input` field and an `ol` tag to hold the search results. 
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>TBD</title>
</head>
<body>
<label for="q">
  <input id="q" autofocus placeholder='Type "Go to my Head"'>
</label>
<ol>
</ol>
...
```

### Javascript

Next, I needed to do the search. I really like interactive searches, like [AmpWhat](https://amp-what.com), despite them being non-standard. (Typically this interaction looks more like an autocomplete, and it might make sense to switch to it.) But for starters, I'd just do a query on `keyup` events. (On my phone, this performed well, but it may need some throttling for slower machines.). I created a Javascript file for my web site and included it at the end of my `index.html`.
```javascript
const q = document.getElementById('q')
q.addEventListener('keyup', e => {
  const matches = findMatches(q.value)
  showMatches(matches)
})
```

 `findMatches` and `showMatches` don't exist yet, so I need to write them. Each of these could involve pulling in helper libraries (databases, rendering engines), but I started with just the built-in technology.

#### `findMatches` Function: a Humble Search Engine

I won't show it here, but the first version of `findMatches` I wrote by traversing through the JSON generated from the ingestion. For each song, I match the typed query against any of the names used for it, and then I sort the matching songs based on how "well" it matches. Each song match gets a "score", with extra points for whole word matches and the beginning of the song's name. A fairly simple heuristic like this, from my experience, produces nice results on a limited dataset like this. I've spent years tweaking another version of it I use on [AmpWhat](https://www.amp-what.com/)

I didn't need to reach for another library to do this, and certainly not a database. People reach for databases because they are concerned about speed and memory, but in the modern world, browsers can execute 1000s of regular expressions per second, so it will be plenty fast. And the data file wasn't big by today's standards.

#### Rendering in `showMatches`

To build the `showMatches`, I relied on the browser's built-in DOM API. Devs are immediately jump to rendering or templating engines like JSX and can forget that the built-in DOM API has evolved through the years. Here's a rough version of the first pass:
```javascript
function showMatches (matches) {
  const listItems = matches
    .map(m => {
      const e = document.createElement('li')
      e.appendChild(span('name', m.names[0]))
      const books = document.createElement('ul')
      Object.entries(m.books)
            .forEach(b => {
              const book = document.createElement('li')
              book.appendChild(span('title', b[0]))
              book.appendChild(span('p', b[1]))
              books.appendChild(book)
            })
      e.appendChild(books)
      return e
    })

  function span (cls, value) {
    const sp = document.createElement('span')
    sp.setAttribute('class', cls)
    sp.innerText = value
    return sp
  }

  // insert it in the DOM
  const ol = document.getElementsByTagName('ol')[0]
  ol.replaceChildren(...listItems)
}
```
This works, and it's simple. And right off, the search was working relatively well.

#### Data Cleansing

Once I saw results, I saw errors in my source data. I could have looked for a new dataset, but it seemed like a small problem at first, so I made the small fix. There were typos and OCR errors, as someone had scanned index pages with what is now obsolete technology.

On previous projects in this situation, I have found it helpful to have a function specific to cleaning up the data, and using it as early in the flow as possible. Otherwise the same problem is solved in the wrong place, like in the `songKey` function or in the front-end UI, or perhaps both. So I added a `fixName` function that is used before anything is done with a song's title:

```javascript
function fixName (name) {
  return name.replace(/ 15 /, ' Is ')
             .replace(/Reincarna11on /, 'Reincarnation ')
             .replace(/Sey40r /, 'Señor ')
...
```

This may seem odd to express in code, and not just fix the source file, but from my experience, it'll be easier in the long term. If I ever need to upgrade the source data, if I'd edited the file I would need to redo all the corrections I'd made the first time. There are several alternatives that I might move to: 

- This code can be made to be data-driven, by building out some sort of "corrections" file. 
- A third solution would be to "push the fixes upstream" into the souce of the data file. This _is_ a good solution, but requires more time than I will spend on this project. As I'm not that commited to this data set, I haven't done it yet.

Again, these are data _errors_, and not stylistic preferences like the spelling of "until". As such, they are fixed in the data when it first appears. It's always better to fix the errors in the right place, as early as possible. Otherwise you end up coding around them "downstream".

### CSS / Design

Although I could see (and fix) the search results, the design is just default browser muck, so I needed to invest a couple hours in design. For colors, I started by looking for inspiration in photos of nightclubs. Unfortunately my ability to put  together a wide variety of rich colors harmoniously is too ambitious for this project. However, I saw that the idea of deep accent colors on a black background was something I could pull off. 

But a plain black background was just too boring, so I hunted for an open source photo, something very dark and "nightcluby", but to no avail. I eventually hunted through my own Google photos, narrowed the selection down. and ended up with a trumpet that I'd photographed for insurance purposes! I was able to darken and crop it into a background image, and this grounded the app. 

<img style="width: 300px; float: right; margin: 5px 0 5px 20px; border-radius: 10px;" src='https://www.gotomyhead.site/images/photo/trumpet.jpg' width=300 />

I spent a bit of time on fonts, but didn't get to perfection. I was hoping to use one of the recognizable real book fonts from volume 1 or 2, but wasn't able to find them. I used a Courier-like typewriter font, until I realized the distressed look was what I needed. That led me quickly to the main font, _Special Elite_.  Finally, I added the _Impact Label_ font-- the  brand font for [NDP Software](https://ndpsoftware.com). I love how it looks in this design, and I hope and pray I'm not alone.

### Getting To MVP
Although this is the basic process, I did go back and add things like the "clear" button, branding and a footer, feedback links, and analytics. I spent a bit of time testing out queries and improving my ingestion script as I discovered more errors in the raw data. I also spent a little time making it "responsive", as I wanted it to work well on a phone or tablet.

### Name and Hosting
The final piece of the puzzle was to pick a name and stick it up on the web. I tried to use some online tools to help me generate names with puns, rhymes etc., but struck out. In the end, I bootstrapped this part of the process:  I just searched within the tool itself and found an interesting match to the term `head`. I bought the name, put the DNS in AWS Route 53, and figured out how to host it on S3 without any servers. Amazon has good tutorials for this, and it turned out to be easy, even though I hadn't done it before.

### Progressive Web App
Now that I had the app basically working, I wanted to make to work offline. (To be honest, I've struggled with this, and it still is not working the way I would like.) I want the browser to prompt you to save it when you bring it up with an icon in the URL bar. I did learned how to use service workers, which is a technology I have resisted using since my nightmare experience with its predecesor, appCache. 

As I got my service worker going, however, I discovered that to use them, you need to serve your app via `https`. AWS had a solution for this, but it a hassle, as you need to set up multiple CloudFront distributions. It felt like this part of the app is the more complicated and delicate engineering.

> More tools = More troubles. 

And at that point, hosted behind CloudFront with service workers, iterating becomes more difficult. I have to update your service worker's manifest files with each change, and to test in production, CloudFront can take up to 24 hours to distribute a new push of code. So it is quite tedious to debug making progressive web apps this way. Chrome dev tools provide enough to make this possible, but it's not as rosy as I'd like.

### Refection
At no point did I find myself reaching for one of the dozens of tools I've become expert on in the last few years: no need for React or Typescript, CSS frameworks, Postgres. All of the web technologies have grown to help make things easier, even as more and more libraries have added layers on top. Even though Javascript is still mostly the Javascript of old, the type hints of Typescript and other developer conveniences are now available. And CSS has always been powerful and expressive on its own, and the enhancements like animations and untapped possibilities. And the industry has gone back and forth on what should live in backend servers, but no matter where we are in that cycle, static web hosting has lots going for it. And with Javascript running better in the browser, I could add a database backend and make it work reliably and securely without having to run a web server. 

I also found it's much faster to develop on core technologies rather than libraries. The documentation is much easier to find and deal with, as there's less messing with tooling and versions (besides MDN and [caniuse.com](http://caniuse.com/)). To understand this, compare looking up a simple DOM functiond on MDN, versus peeling the skin off CreateReactApp app with the various versions of React and the dozens of dependencies. Plus, the minimalist approach has advantage in moving forward, as  there will be no expiring tools, when I'll be forced to upgrade Webpack, or keep `eslint` rules up-to-date, or upgrade dependencies with security vulnerabilities.

I've made the conscious choice to take the simplest option at every turn. You'd think this would be a recipe for technical debt, but it is just the opposite. It's kept the code small and there's no tool that will go out of fashion that I'll need to migrate away from. There's just very little to go wrong!

Even if it's not useful for your development project, I recommend trying someting like this as a "cleansing" exercise next time you have a chance. It will help you next time you're thinking through library adoptions.
