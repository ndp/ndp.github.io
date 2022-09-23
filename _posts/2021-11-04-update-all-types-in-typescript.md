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

### Update 7/2022

I've found that with Yarn 3 / Berry / PNP that these tools changed. There no "outdated"
command, an "upgrade" is now just "up". To make it work, 
there's [a plugin that is required](https://github.com/mskelton/yarn-plugin-outdated).

The command looks like:

```sh
FORCE_COLOR=0 yarn outdated  '@types/*' | grep '@types' | awk '{print $3}' | xargs yarn up
```

