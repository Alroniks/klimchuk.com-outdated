---
title: 'Developing an Extras in MODx: configuring of the environment'
anchor: 'Developing an Extras in MODx: configuring of the environment'
keywords: modx, extra, developing, configuration, environment, настройка окружения, разработка
date: Jun 18, 2013
layout: 'default'
isPaged: true
tags:
    - Closet
---

__Hi, colleagues!__

Some days ago I did have some free minutes and I started develop a new Extra for MODx Revolution. Results you will see later. But now I talk as about I configured my development environment for the comfortable developing and for simple assembly and deploying packages for MODx.

At first, I read article [Mark Hamstra](http://www.markhamstra.com), where he wrote how we can change destination directory for assembling package. It was handy. Thanks, Mark! But I went on. Because... By this way I need every time build new packages and install it. And yet one problem - for successfull installation I need to change version for the packages. It takes a lot of time. But... I found a solution! (Maybe my solution will not interesting for MODx Team, as they create and build packages every day almost, but it will usefull for other developers).

My solution allow skip the stage of build and instalation of packages. We just writing code, debugging and if our code works, then we build our packages and we gives somebody it. Let's start!

## 1. Environment

I use Ubuntu 11.10 and this instruction is applied only for OS based on linux.

My instance of Revolution  was placed in directory on server:

``` bash
/home/www/modx
```

My packages placed in special folder near with Revo instance (we can put it to other place):

``` bash
/home/www/pkgs/
```

Example of pkgs folder:

<pre>
    root@server:/home/www/pkgs# tree -L 1
    .
    ├── modx-articles
    ├── modx-minishop
    └── modx-semanager

    3 directories, 0 files
</pre>

Code of an Extra placed in folder with name as package name and this folder have this structure:

<pre>
    root@server:/home/www/pkgs/modx-semanager# tree -L 1
    .
    ├── assets
    ├── _build
    ├── config.core.php -&gt; /home/www/modx.by/config.core.php
    ├── core
    └── README

    3 directories, 2 files
</pre>

In this example you see this line:

```
|-- config.core.php -&gt; /home/www/modx/config.core.php
```

It is a symlink. What is a Symlink? [Wiki](http://en.wikipedia.org/wiki/Symbolic_link) is describing it very details.

## 2. Symlinks

Symlinks on Ubuntu and on others Linux systems is a file, that contains path to destination. System thinks that it not a file, it is follow path and it is seeing other files, on that symlink is pointing. It is as pointer or just a simple link to other file or directory.

And this fact allow us use it for the good of us.

### core.config.php

You see, that config.core.php is a symlink who follow my instance of modx revolution. It is nessessary for to work of the connectors and processors, because on /assets/components/modx-semanager/connector.php (on working instance of modx) contains this lines:

``` php
require_once dirname(dirname(dirname(dirname(__FILE__)))).'/config.core.php';
```

It means, that our connector.php trying get config.core.php from root path of our site on MODx. But if we have our package's code in other place, server will return error, because file will be not found. For exclude this situation we create symlink to original 
file config.core.php. In our case we need write the command in dir with our package:

``` bash
ln -s /home/www/modx/config.core.php config.core.php
```

__Note! You should write path to your own modx instance.__

### core and assets

Our code placed in package's folder, but modx at the time of work will be try get code from the own packages folders as assets/components/component_name and core/components/component_name. To avoid this we need заставить modx to think, that code of packages placed in it own folders. Symlinks can help us.

Going on to /home/www/modx/core/components/ and make there our symlink:

``` bash
ln -s /home/www/pkgs/modx-semanager/core/components/semanager semanager
```

and going on to /home/www/modx/assets/components/ and make there other symlink:

``` bash
ln -s /home/www/pkgs/modx-semanager/assets/components/semanager semanager
```

After this manipulations modx will be think that code of components placed in it own folders, but in fact code will be placed in our special for package folder.

## 3. What it will give?

We is starting develop a new Extra in our modx folder. I am writing some code into file and I am refreshing page on back-end and it works. And if we wrote some code and it passed all test we can build packages in our directory with sources. And we can initiate git or hg repository in our folder, that will not include other source of code.

My name is Ivan Klimchuk. You can to ask me.

Sorry for my English. I am not a profi on english, but I hope I will better by time.

Your asks you can write to [my twitter](https://twitter.com/iklimchuk) or via comments at bottom. Thanks.
