---
layout: post
title:  "Setting PATH for all users on MAC"
date:   2019-04-07 10:58:18 +0800
categories: jekyll update
---
## Setting PATH for all users on MAC

When I setting up my old mac laptop for Ruby and Jekyll, I hit an issue:

 after running

`gem install bundle jekyll`

I tried

`jekyll new my-owesome-site`, but jekyll is not command. Obviousely missing folders in PATH.

'export' only works for current session, we need to find a way to change PATH permanently. Google [this article](https://blog.just2us.com/2011/05/setting-path-variable-in-mac-permanently/), I choose change PATH for all users. The commands are list below.

`sudo pico /etc/paths`

add `~/.gem/ruby/2.6.0/bin/` to first line in that file, maybe you need to change '~' with your account's home folder.

That's it! Now jekyll -v will find right path to run!