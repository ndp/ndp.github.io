---
layout: post
title: "Visualizing Technology Stacks"
date: 2023-04-03
comments: false
tags:
- HTML
- CSS
- software development
- visualization
- javascript
- prototyping
- mini-project
- resume
- job search
---

I recently removed most of the detail from [my resume](https://github.com/ndp/resume), in order to tell a more coherent story about my career.  <img src='/assets/posts/2023/viz-techs.png'  style='float: right; width: 33%; margin: 10px 0 10px 10px;' />In the shuffle, I threw all the "technologies" I'd used into a spreadsheet. Seeing it, I decided to play around a little bit "visualizing" these, to see if anything interesting came up.  Although I haven't found anything usable in lieu of a resume, this one chart, shown above breaking a few charting tools and guidelines, demonstrates how clearly the number of technologies we use has greatly increased through the years.

<div id="observablehq-areaChart-bc88c6cc"></div>
<p style='font-size: small; line-height: 1.2'>Hover over a color to see a different tool or technology (with some color repeats). Years are along the X axis. Usage is not to any scale. Credit: <a href="https://observablehq.com/d/833e598c806e2930@377">Technologies I Have Used by NDP</a> </p>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@observablehq/inspector@5/dist/inspector.css">
<script type="module">
import {Runtime, Inspector} from "https://cdn.jsdelivr.net/npm/@observablehq/runtime@5/dist/runtime.js";
import define from "https://api.observablehq.com/d/833e598c806e2930@377.js?v=3";
new Runtime().module(define, name => {
  if (name === "areaChart") return new Inspector(document.querySelector("#observablehq-areaChart-bc88c6cc"));
  return ["key"].includes(name);
});
</script>

I'll add some more ideas, and you can poke around [in the workbook on observablehq](https://observablehq.com/d/833e598c806e2930).

