---
layout: post
title:  "AWS Certified Solution Architect - RPO 与 RTO"
date:   2019-11-06 09:38:18 +0800
categories: aws cert
---
# AWS Certified Solution Architect - RPO 与 RTO
## RPO: Recovery Point Objective
业务恢复时间点，即系统可以恢复至故障前最近的哪个时间点的状态。比如有一个DB，我们每24小时做一次备份，每次从备份恢复至上线，需要10分钟。那么RPO也就是24小时前。因为最近一次备份是前一日的数据。当然这个RPO需要符合企业的业务连续性计划（Business Continuity Plan）要求，也就是不能超过BCP里面定义的最大允许的业务中断时长。

## RTO: Recovery Time Objective
这个就是从故障发生，到故障恢复的时间了。追求目标是这个越短越好。上面的例子中，RTO就是10分钟。

RTO与RPO当然都是越小越好，但是随着这个的减少，所需的代价和成本会直线上升。比如RPO如果是24小时，那么DB、存储等需要每日备份即可，但如果是0，那就需要做连续不间断的日志同步/备份。  同样，如果RTO是10分钟这样的量级，可能只需要一些环境的启动脚本，满足新环境建立全部自动化基本就可以。但如果RTO是1分钟或者更短，那么可能需要做Fault Tolerance，并且需要在不同的region部署应用。  

再提一个概念，Fault Tolerance和High Avaliability， FT是比HA更高的要求，FT是不允许有服务中断时间，HA是可以接受一个很小的服务中断时间