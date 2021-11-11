---
layout: post
title: "Upgrade All Your Typescript Types at Once"
date: 2021-11-04
comments: false
permalink: /2021/11/upgrade-all-types-in-typescript.html
tags:
- software development
- typescript
- shell
---
Types get updated all the time as folks flesh out their types. In general, they changes don't pose a risk to my code (as long as TypeScript builds them). Here's how I upgrade all of them at once:

```sh
yarn outdated | grep @types | awk '{print $1}' | xargs yarn upgrade
```

