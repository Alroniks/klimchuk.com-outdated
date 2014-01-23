---
title: 'Environment of MODX developer'
anchor: 'Environment of MODX developer'
date: 1 Jan, 2014
layout: 'default'
isPaged: true
tags:
    - MODX
---

Hi, colleagues!

Some days ago I did have some free minutes and I started develop a new Extra for MODx Revolution. Results you will see later. But now I talk as about I configured my development environment for the comfortable developing and for simple assembly and deploying packages for MODx.

<!-- cut -->

At first, I read article Mark Hamstra, where he wrote how we can change destination directory for assembling package. It was handy. Thanks, Mark! But I went on. Because… By this way I need every time build new packages and install it. And yet one problem — for successfull installation I need to change version for the packages. It takes a lot of time. But… I found a solution! (Maybe my solution will not interesting for MODx Team, as they create and build packages every day almost, but it will usefull for other developers).

My solution allow skip the stage of build and instalation of packages. We just writing code, debugging and if our code works, then we build our packages and we gives somebody it. Let's start!