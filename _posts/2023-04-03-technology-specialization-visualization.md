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

I recently revamped [my resume](https://github.com/ndp/resume), stripping away the clutter to tell a more coherent story about my career.  <img src='/assets/posts/2023/viz-techs.png'  style='float: right; width: 33%; margin: 10px 0 10px 10px;' />  In the process, I compiled all the technologies I’ve used into a spreadsheet, and seeing it, I couldn’t resist the urge to experiment with visualizing this data.   One chart in particular, despite pushing the limits of charting tools and guidelines, vividly illustrates the explosive growth in the number of technologies we use day-to-day.


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

