---
layout: post
title: "Why not use * version numbers?"
date: 2021-12-02
tags:
- software development
- package
- nodejs
---
Am I the only one that prefers to use `*` for my version specifiers in my package.json file? 

Like ya'll, when I run `yarn outdated`, I want to quickly update the outdated packages. My goal is to get the new packages and commit a newer `yarn.lock` file. I think the standard process  is to open up your `package.json` a start iterating. But honestly, this is a diversion from my goal. And from my experience, it's quite tedious and error prone.

Additionally, after a little while, a version number in `package.json` like `^1.0.2` provides little information. It tells me is what the version was _when I first added the package._ It's information that will by definition become stale. It's historical information available in git. It's non-information and I don't want it.

My preference is just to list all my dependencies with a `*` version. When I run `yarn install`, yarn _guarantees_ to get the latest version that is compatible with all my other packages:

> [If yarn.lock is absent, or is not enough to satisfy all the dependencies listed in package.json (for example, if you manually add a dependency to package.json), Yarn looks for the newest versions available that satisfy the constraints in package.json. The results are written to yarn.lock.](https://classic.yarnpkg.com/en/docs/cli/install)

So I just let yarn handle the upgrade. 

I usually upgrade iteratively, committing as I go. Something like:

1. `yarn outdated`
2. Pick a package and `yarn upgrade a-pkg` I will often take a set of packages, such as all the lint-related files at once.
3. Test
4. If everything is OK, commit: `yarn add yarn.lock` and then `git commit -m 'yarn upgrade a-pkg'`(I actually type `⬆️ ⬆️ ^A g co -m' ^e '`)
5. Go to step 1

Yarn takes care of all guaranteeing the versions are compatible (or at least think they are). 

Why not `*`?

(Note: this is written in terms of `yarn`, but it also applies to `npm` and even Ruby `bundler`.)