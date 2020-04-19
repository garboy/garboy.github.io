---
title:  "安装Redis Cli"
date:   2019-06-04 09:58:18 +0800
categories: technical
---
## Windows/MacOS等环境下安装Redis Cli，不需要安装Redis Server

很多时候我们需要在本机测试一下redis服务器，图形化工具一个是不多，另一个是有点重。今天发现nodejs下有一个简单易用的工具  
`npm install -g redis-cli`
然后就可以通过 `rdcli -h {host} -a {password} -p {port}` 连接redis server，去做测试或者维护工作。比如

```reids command
incr foo
get foo
set foo 2
get foo
quit
```

参考[原文](https://redislabs.com/blog/get-redis-cli-without-installing-redis-server/)，感谢Lu Jiajing的[代码](https://github.com/lujiajing1126/redis-cli)。
