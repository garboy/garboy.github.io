---
layout: post
title:  "你的机器上到底有多少个.NET Core SDK"
date:   2019-09-23 12:58:18 +0800
categories: technical
---

## 你的机器上到底有多少个.NET Core SDK

笔记本的剩余空间天天徘徊在1-2GB内，天天提醒我。我担心某一个更新都没法正常下载，安装。于是清理机器磁盘空间，打开添加/删除程序后，发现机器里面装了好几个版本的.NET Core SDK，OMG，我怎么需要这么多？！

![add/remove program files]()

冷静下来想了想，.NET Core的程序不是开始可以多版本side by side并行运行了么？所以每次下载/升级一次.NET Core SDK，或者有时候Visual Studio 更新一下，也都会下载一个版本的SDK。同时，旧的版本并不会卸载掉。时间久了，机器上就有了一部.NET Core SDK编年史。
每一个版本还都不小，赶紧都卸载了去，就保留一个。一下又能给我刷出来近10GB空间，太好了。

P.S. 发现一外国友人，也有这个[困扰](https://gunnarpeipman.com/dotnet-core-how-many-sdks/)
