---
title: "修复本地Jekyll主题minimal-mistakes build 报错"
date: 2020-04-19 01:07:18 +0800
categories: tech
---

更改`_config.yml`中`theme: minimal-mistakes-jekyll`，并把`gem "minimal-mistakes-jekyll"`加到genfile后，执行`jekyll b`报错：`Error:  Invalid GBK character "\xE2" on line 54`。

这是一个在windows下尤其常见的一个错误，是由于编码问题引起的。

解决方法：
在命令行cmd中运行：`chcp 65001`

可以看到cmd窗口显示`Active code page: 65001`，然后再执行`jekyll build`就可以了。
