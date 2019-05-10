---
original: "https://akomljen.com/kubernetes-service-mesh/"
author: "ALEN KOMLJEN"
translator: "chengwhynot"
reviewer: ["审阅者A的GitHub账","审阅者B的GitHub账号"]
title: "Kubernetes Service Mesh"
summary: ""
categories: "译文、原创或转载"
tags: ["taga","tagb","tagc"]
originalPublishDate: 2018-01-28
publishDate: 2018-01-28
---
# Kubernetes Service Mesh

Kubernetes 服务网格

[ALEN KOMLJEN ](https://akomljen.com/author/alen/)JANUARY 28, 2018 4 MIN READ

A few months ago my colleague asked me what I think about integrating [Linkerd](https://linkerd.io/) to our new application running on [Kubernetes](https://akomljen.com/tag/kubernetes/). My first thought was, heck, isn't Kubernetes service and [ingress](https://akomljen.com/tag/ingress/) enough? You can do much stuff with it. Having a service mesh seemed like overhead to me. You often have some API which is available only on the internal network. However, this is not the case anymore with modern applications. The API is probably exposed to the Internet as well and gets much traffic. You want more control of the traffic that goes to this API. Maybe you want to support more API versions, do canary deployments, and you want to watch and keep track of each request that comes in. It is where service mesh comes into play. It doesn't matter if you want to use [Linkerd](https://linkerd.io/) or [Istio](https://istio.io/)principals are almost the same.

几个月前我同事问起我对于如何集成[Linkerd]到我们新的运行在[Kubernetes]应用里面有什么想法。我的第一反应是，嘿，难道Kubernetes服务和[ingress]不够么？你能够基于它们做很多事情了。再考虑服务网格的话似乎有点过度设计。通常你有一些API只对内部网络开放，然而对于现在流行的应用来说，这并不够。API通常暴露在互联网上并且也有非常大的流量。你需要在流量上有更多的控制。更甚，也许你还需要做API版本化，做金丝雀部署，观察并记录每一个请求。这就引入了服务网格。无论你用[Linkerd]或是[Istio]，原理上都是一样的。

## Why Service Mesh?

# 为什么要用服务网格？

Service mesh is not something that came up with Kubernetes. However, it is easier to integrate service mesh into your environment thanks to Kubernetes. Two logical components create service mesh. We already have pods which are designed to have many containers. **Sidecar** is the perfect example which extends and enhances the primary container in a pod. With service mesh, the sidecar is **service proxy** or **data plane**.

服务网格并不是和Kubernetes一起出现。然而，因为有Kubernetes，服务网格更容易被引入到你的环境中。有两个逻辑组件组成了服务网格。我们已经有了pods用于承载各个容器。Sidecar是另一个绝好的例子用于扩展和加强pod里面的主要容器。在服务网格语境里，sidecar是服务代理或者数据平面。

> Service mesh is a critical component of cloud-native.

> 服务网格是云原生的核心组件

To better understand the service mesh, you need to understand terms proxy and reverse proxy. **Proxy**, in a nutshell, receives the traffic and forwards it to somewhere else. **Reverse proxy** receives the traffic from many clients and then forwards that traffic to lots of services. In this case, all the clients talk to one proxy instance. Think of data plane as a reverse proxy. Ingress is also reverse proxy used to expose the services in Kubernetes. Ingress can terminate SSL, provides name-based routing and that is pretty much it. The same thing is with Kubernetes services. What if you want to make some more complicated routing?

为了更好的理解服务网格，你需要理解代理和反向代理这两个术语。**代理**，一句话说，接收流量并中转到其它地方。**反向代理**，从各个地方接收流量并转交给各个服务。这种情况下，所有的客户只和一个代理实例交流。把数据平面想象为一个反向代理。Ingress也是Kubernetes里面用于暴露服务的反向代理。Ingress可以中止SSL，提供基于名称的路由，并且它主要就干这个事情。对于Kubernetes服务也是一样。如果你需要更复杂的路由该怎么做呢？

Here are a few other things that service mash is capable of:

- Load balancing
- Fine-grained traffic policies
- Service discovery
- Service monitoring
- Tracing
- Routing
- Secure service to service communication

下面列举一些其它服务网格可以做的事情：

- 负载均衡
- 精细流量策略
- 服务发现
- 服务监控
- 追踪
- 路由
- 服务与服务的安全通信

Other then sidecar proxies all service mesh solutions have some controller which defines how sidecar containers should work. Service mesh **control plane** is the central place to manage the service mesh and service proxies. The service mesh control plane records network information, so it is a network monitoring tool also.

比起sidecar把代理所有的服务网格解决方案

So, why service mesh? The answer is simple. You can do all the above without making changes to your code. It saves time and money. Also, most important, you will not skip some testing because it is too complicated, to begin with. You can even simulate different scenarios on how the service will react to failures with features like [Istio fault injection](https://istio.io/docs/concepts/traffic-management/#fault-injection).

## Linkerd2 and Istio

In the beginning, I mentioned two great solutions to create a service mesh on Kubernetes. In the future, they might be many others. Each product tries to solve problems in its way. They might be overlapping in some areas of course.

[Buoyant](https://buoyant.io/), the company that created Linkerd also created Conduit service mesh. Recently Conduit has been merged into the Linkerd project as **Linkerd2**. The buoyant team created Linkerd service mesh as a more generic solution. It is written in Java, which means it can be heavy. Remember, each pod gets one more container, a sidecar. [Linkerd2](https://linkerd.io/2/overview/) is designed for Kubernetes. It is written in Go - control plane, and Rust - a native service proxy, to be ultra-lightweight, fast and secure. You can define retries and timeouts, have instrumentation, and encryption (TLS), as well as allowing and denying requests according to the relevant policy. Also, it comes with a nice dashboard:

![linkerd2_dashboard](https://linkerd.io/images/getting-started/empty-dashboard.png)

Alternatively, if you prefer terminal `linkerd` CLI is also available.

Linkerd2 [getting started guide](https://linkerd.io/2/getting-started/) is excellent, so please try it yourself. To learn more about it, please check the [official documents](https://linkerd.io/docs/).

**Istio** currently supports Kubernetes and [Nomad](https://www.nomadproject.io/), with more to come in the feature. Istio is a multi-platform solution. It manages traffic flow across microservices, enforce policies and aggregate telemetry data. Istio is also written in Go to be lightweight but unlike Linkerd2 it employes [Envoy](https://www.envoyproxy.io/) to do the service proxy. To see how everything fits together check Istio architecture diagram:

![istio_architecture](https://istio.io/docs/concepts/what-is-istio/arch.svg)

What I like about Istio is the support for [auto sidecar injection](https://istio.io/docs/setup/kubernetes/sidecar-injection.html#automatic-sidecar-injection). The chances are that you already use [Helm to deploy applications](https://akomljen.com/package-kubernetes-applications-with-helm/), so injecting the sidecar manually into Kubernetes config files is not an option.

To install Istio on Kubernetes check [quick start guide](https://istio.io/docs/setup/kubernetes/quick-start.html). For all other information about Istio, please check the [official documents](https://istio.io/docs/).

Both products are open source too. Whichever service mesh better suits your needs, they are both pretty much easy to try. You will not spend more than 5 minutes to get things running. I encourage you to try both and then decide. Istio at this point can do a lot more than Linkerd2, and it has a stable release.

## Summary

I hope I gave you a nice introduction to service mesh. This post wasn't meant to be a comparison between Linkerd2 and Istio. I listed some of its features so you can get the idea of what service mesh brings to the table in the Kubernetes world. Stay tuned for the next one.