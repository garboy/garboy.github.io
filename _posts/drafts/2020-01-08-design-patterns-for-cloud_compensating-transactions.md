---
title:  "云设计模式：补偿事务"
date:   2020-01-08 11:00:00 +0800
categories: design-patterns
---

## Context and problem

> Differ with SAGA pattern? Look this [Clemens Vasters’ blog](https://vasters.com/clemensv/2012/09/01/Sagas.aspx).

A compensating transaction is also an eventually consistent operation, and it could also fail. So the commands in compensating transaction should be defined as idempotent commands. For more information, see [Idempotency Patterns](https://blog.jonathanoliver.com/idempotency-patterns/).

It might not be easy to determine when a step in an operation that implements eventual consistency has failed. A step might not fail immediately, but instead could block. It might be necessary to implement some form of time-out mechanism.
