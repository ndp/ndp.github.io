# The Problem with Javascript (Part 7 of 39)

## Package.json

Today's punching bag is package.json. 

People talk about how cohesion should work in methods, and classes, but files are less talked about. Languages like Java obviate the need for thinking about this-- a class is in a file, end of story. Ruby has strong conventions in the same vein, but they needn't be followed completely. These constraints simplify projects, as you, and the compiler/interpreter, knows where to find things. But it's not necessarily perfect. It's not uncommon in these projects to have to modify 3 or more files to make a single functional change. The "separation of concerns" bites us here, and we need multi-step recipes to make changes. 

Javascript projects don't necessarily take this approach. It's more of the wild west, where folder structures, file names, and functions vs. objects vary extensively. Projects like React try to fold what are disperate files in Ruby/Java together, and rendering is combined with data fetching and CSS. This adds some cohesion, and generally there's a clear way to organize React files. But there are all sorts of files that don't fit into this scheme, and these are "all over the place".

We can look at these different approaches and see if we can find some guidelines that apply across all languages and projects.

So, let's start out with a bad example, and perhaps we can come up with a few learnings. Unfortunately, it's the poster-child of node.js, `package.json`, the core file to every node.js project. This file started out innocently enough, identifying a folder as a node.js project, and giving the project a name, version and description. It also listed dependencies that a package needed. It adds a slew of other responsibilities, some following the main purpose, and some only tangentially related: 

- describing which files to publish
- hold settings for optional tools like a linter or testing library
- control how javascript files are interpretted within it (esm, cjs, etc.)
- define lifecycle hooks for building the project
- include other scripts that a developer might want run, eg. `npm run test`
- deployment settings
- addition "package.json" files can be introduced to override settings within a folder of a project

So, the original purpose of this file has strayed pretty far. But so what?

Let's look just at the dependencies, you can start to see some of the complexity. There are two lists of dependencies for two different audiences: the developers of the tool and the consumer of the library. These sets are both dependencies, but relevant to different people. A consumer of the package wants to be able to review the depencies, but likely doesn't care about the developer-only depences. That brings us to our first guideline: _Files should be focused on a single audience._
Also confusing, though, is whether you're supposed to edit these. It's possible to just go in and add a file to the list of dependencies. This makes sense. But `npm` and `yarn` (and probably others) will do this for you, and advise you to do it that way. This is fine, but as you're later required to edit the machine-added code, a new dev will hesitate for a moment. There should probably be just one way to do this. 
One of the big weirdnesses of package.json, is that it's used to describe both packages that are published and shared, but also non-packages, like servers or compiled web apps.
A single file should:

- All the contents should be relevant to the same audience. Readers shouldn't have to wade through irrelevant information.
- Have a clear ownership, of who would edit the file.
- The name should represent the purpose of the file. "package.json" has diverged too far from its original purpose.


## References

https://nodesource.com/blog/the-basics-of-package-json

