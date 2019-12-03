---
layout: post
title:  "AWS EBS, EFS, S3对比"
date:   2019-12-03 09:38:18 +0800
categories: aws cert
---

特性 | Amazon S3 | EBS | EFS
--- | --- | --- | ---
存储类型 | 对象存储 | 块存储 | 块存储
存储大小 | 没有限制 | 最大为16TB | 没有限制
单个文件大小限制 | 0字节~5TB | 没有限制 | 最大52TB
IO吞吐量 | 支持multipart上传, 如果使用single object upload，单个文件大小限制为5GB | 可以选择HDD或者SSD的磁盘类型，以提供不同的IO | 默认3GB
访问 | 能通过因特网访问 | 只能被单个EC2实例访问 | 可以被上千个EC2实例同时访问
可用性 | 99.99% | 99.99% | 高度可用（官方没有公布相关数据）
速度比较 | 最慢 | 最快 | 中等
价格 | 最便宜 | 中等 | 最贵

Amazon S3 是一种静态存储服务，可用于静态网站托管，媒体分发，版本管理，大数据分析和归档。
Amazon EBS 是一种持久性存储设备，可用作数据库，应用程序托管和存储以及即插即用设备的文件系统。
Amazon EFS文件系统非常适合作为托管网络文件系统，可以在不同的Amazon EC2实例之间共享。 Amazon EFS与NAS设备类似，可用于大数据分析，媒体处理工作流和内容管理。

价格方面：Amazon S3是最便宜的，Amazon EFS的价格几乎是Amazon EBS定价的10倍，但更便宜的Amazon EBS一次只能由一个Amazon EC2实例访问。这可能是群集或分布式应用程序中的问题。 但是，Amazon EBS可以提供​​比Amazon EFS更好的性能。 Amazon EFS在Amazon EBS上获得了用作共享网络存储的能力。

结论：
决定因素很可能取决于您能够支付多少存储费用。

Amazon S3具有许多功能，但附带了各种定价参数，例如每月使用的存储空间，请求数量（例如：POST，GET等）， Amazon S3 Inventory ， Amazon S3 Analytics ，存储类分析， Amazon S3对象标记 ，Amazon S3和 Amazon S3传输加速的 每GB数据传输 。

与Amazon S3相比， Amazon EBS定价 更简单，包括每月分配的/ GB存储空间，预配置IOPS和 Amazon EBS快照 。 亚马逊EFS定价 更为直接：您只需支付以GB /月为单位的使用存储空间。

通过这种分析，Amazon S3看起来最便宜，但情况可能并非总是如此。 对于性能，Amazon EBS由于高IOPS而成为最快的，但是当涉及共享和可扩展文件系统时，Amazon EFS是最佳选择。 但在所有情况下，使用 Cloud Volumes ONTAP ，您可以减少AWS存储空间，从而节省存储成本。
