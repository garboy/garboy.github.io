---
layout: post
title:  "SonarQuebe-CLI Windows下的一个BUG"
date:   2019-09-23 12:58:18 +0800
categories: technical
---

周一中午需要提交一个项目的SonarQuebe扫描结果，之前已经做过其它一些项目的SQ扫描，所以预估需要一个小时左右。

1. 下载代码
2. mvn clean install
3. mvn sonar:sonar
4. DONE

看着挺简单，好家伙，结果耗了我近两个晚上。
第一天先被mvn compile拦住了。说在指定的maven库里面找不到ojdbc14和sqlserver42。
简单，网上查了一下，这俩包分别被Oracle和Microsoft把持着，没有放到apache的maven库中。公司的库里面也没有放，估计是担心法律风险吧。简单，先下载他们俩的jar包，`sqljdbc4.jar`与`Oracle_10g_10.2.0.4_JDBC_ojdbc14.jar`，然后执行

```cmd
mvn install:install-file "-DgroupId=com.oracle" "-DartifactId=ojdbc14" "-Dversion=10.2.0.4.0" "-Dpackaging=jar" "-Dfile=D:\downloads\Oracle_10g_10.2.0.4_JDBC_ojdbc14.jar"

mvn install:install-file "-DgroupId=com.microsoft.sqlserver" "-DartifactId=sqljdbc" "-Dversion=1.2" "-Dpackaging=jar" "-Dfile=D:\downloads\sqljdbc4.jar"
```

接着又碰到SonarQuebe在Windows下的Bug!
不管我执行`mvn sonar:sonar`还是`sonar-scanner`，总是在漫长的扫描结束，准备提交报告的时候，暴出一个异常，说什么socket关闭，超时。其实再往上翻翻，可以看到前面的异常是删除.scanworks目录的时候失败。
同样，我并不是第一个碰到这个问题的人:[Sonar Community的一个issue](https://community.sonarsource.com/t/sonarqube-ce-failed-to-delete-temp-folder/5690)和[StackOverFlow Question](https://stackoverflow.com/questions/51491191/sonarqube-is-throwing-directorynotemptyexception-during-the-report-analysis)。
我可以看到Sonar社区说这个问题已经Closed，于是我下载了更新版本的windows cli工具，结果执行结果还是同样错误。
本来打算放弃，第二天一早去公司找一个Linux服务器，下一下代码、build，再扫描。但突然一想，我不是装了一个Linux on Windows么，正好用上了。
于是又下载了Linux版本的sonar scanner cli，打开Linux shell窗口，再去执行扫描。果然成功了！
补充一句，刚下载的cli工具，别忘了更新一下conf文件里面的url，指向正确的服务端url。
Happy Scanning!
