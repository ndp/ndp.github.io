---
layout: post
title: "Upgarde All Your Typescript Types at Once"
date: 2021-11-04
comments: false
url: /2021/11/update-all-types-in-typescript.html
permalink: /2021/11/update-all-types-in-typescript.html
tags:
- software development
- typescript
- shell
---
Types get updated all the time and don't really pose any sort of risk (as long as TypeScript builds them), so I want to do them as a batch operation. I use:

`yarn outdated | grep @types | awk '{print $1}' | xargs yarn upgrade`

