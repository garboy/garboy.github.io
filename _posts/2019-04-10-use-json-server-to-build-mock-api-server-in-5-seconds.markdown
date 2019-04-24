---
layout: post
title:  "Build a mock api server in seconds"
date:   2019-04-11 12:58:18 +0800
categories: technical
---
## Build a mock api server in seconds

很多时候，定义好了api接口，但是前端也得等上一阵子，少则几小时，多则1-2天，才会有接口能够访问。尤其是目前公司的一些新项目，后端的重点还没在接口定义上，尽早集成，持续集成这个习惯正在不断推动着去培养。

今天正好赶上一个旧系统的开发环境被IT强制下线，其它下游系统开发者要求我们尽快恢复，于是一边联系IT加强那台机器以满足IT规范，另外自己开始着手搭建一个假的api后端。网上搜了一下，第一个就是json-server的这篇文章，浅显易懂，thank you for your [clear article](<https://ayushgp.github.io/use-json-server-create-mock-apis/>) Ayush Gupta"。

```javascript
npm install -g json-server
//准备一份数据文件比如 db.json
json-server db.json
```

That's it!

更进一步，如果懒得装nodejs，你还可以用一个[在线、免费、现成的json server](<https://my-json-server.typicode.com/>), 需要做的就是在github建一个新仓库，然后组合typicode和新仓库的地址，就直接可以用了，什么都不需要装，太棒了！

