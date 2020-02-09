---
layout: post
title:  "C#函数式编程"
date:   2020-02-09 16:01:18 +0800
categories: programming, csharp
---

## Introduction 简介

### What is Functional Programming 什么是函数式编程

> in computer science, functional programming is a programming paradigm—a style of building the structure and elements of computer programs—that treats computation as the evaluation of mathematical functions and avoids changing-state and mutable data. It is a declarative programming paradigm in that programming is done with expressions or declarations instead of statements. In functional code, the output value of a function depends only on its arguments, so calling a function with the same value for an argument always produces the same result. This is in contrast to imperative programming where, in addition to a function's arguments, global program state can affect a function's resulting value. Eliminating side effects, that is, changes in state that do not depend on the function inputs, can make understanding a program easier, which is one of the key motivations for the development of functional programming.

上面是Wikipedia的定义，直译过来就是:

在计算机科学中，函数式编程是一种编程范式-一种构建计算机程序的结构和元素的样式-会将计算视为对数学函数的评估，并避免更改状态和可变数据。它是声明式编程范例，其中编程是使用表达式或声明而不是语句来完成的。在函数代码中，函数的输出值仅取决于其参数，因此，为参数调用具有相同值的函数始终会产生相同的结果。这与命令式编程相反，在命令式编程中，除了函数的参数外，全局程序状态还会影响函数的结果值。消除副作用，即不依赖于功能输入的状态变化，可以使理解程序更容易，这是开发功能编程的主要动机之一。

简单点说，就是-用数学函数的方法来写代码。数学函数不等于类中的方法，即使有时候看起来函数的定义和使用方式和类的方法没有区别，但从函数式编程角度来看，他们的意义不一样。

可以把函数式里面的函数变成想象成一个管道，接收参数，进行处理，然后产出结果。听起来还是和类的方法一样？不，有几个很重要的不同，
1. 幂等。函数式编程的函数，是幂等的。同样的输入，得到同样的输出。
1. 函数的签名传递全面的信息。也就是方法的入参、返回值不仅通过名称，还得通过类型，能够使得调用方清楚明白的知道可接受的类型、范围。

函数式编程的概念挺简单，但是简单的概念却给编程带来了极大的改变，代码写起来更像是写故事。对于习惯了写过程式代码的广大程序员来说，这是一个全新的方式。我们看如下的例子。
```c#
// first method
public double Calculate(double x, double y)
{
    return x*x + y*y;
}

// second method
public long TicksElapsedFrom(int year)
{
    DateTime now = DateTime.Now;
    DateTime then = new DateTime(year, 1, 1);
    return (now - then).Ticks;
}
```

第一个方法如果入参一致，返回值也不会变化，但是第二个即使传入同一个年份，返回值也会发生变化。
再看一个例子。

```c#
public static int Divide(int x, int y)
{
    return x / y;
}
```
方法签名说明它接收两个Integer，并返回Integer，但如果我们传入1和0会怎么样？没有返回Integer，而是返回了一个DividByZeroException异常。
这说明方法签名并没有完整的表达出这个函数接受什么参数。这也就是函数编程的重要的特征之一，**诚实的方法签名**，完整的表达允许的输入和返回值。

因此上面的方法可以改为类似于如下两种，要么自定义一个NonZeroInteger类型，要么把返回值改为可空。
```c#
public static int Divid(int x, NonZeroInteger y)
{
    return x / y.Value;
}
//or
public static int? Divid(int x, int y)
{
    if (y == 0)
        return null;
    return x / y;
}
```

一句话，函数式编程方法最重要的两个特点：Honest-has precisely defined input and output; Referentially Transparent-doesn't affect or refer to the global state.

### 为什么要函数式编程

了解了什么是函数式编程后，我们再来看看为什么要这么做。要了解为什么这么做，我们先得知道当前困扰我们最多的问题是什么。目前在软件行业，复杂性基本成为编程领域的第一问题，它影响了软件行业的其他方方面面，比如开发速度，缺陷数量，以及快速调整，以适应市场的能力。
一个人的大脑能够同时处理的信息很有限，我们的代码集常常远远大于这个限度，这也是有时候为什么我们修复缺陷，新增功能，却很难避免带来副作用。通过函数式编程，能够帮助我们减少点复杂度，进而帮助我们更快，更高质量的编写更多软件。
因为上面小节举的例子，函数式方法的签名能够让我们很容易理解方法，如果每一个方法都是如此，也没有恼人的全局变量以及出其不意的异常，每一个方法能够彼此独立的测试，那么我们可以把每一个方法看做构建软件的积木，通过组合不同的积木，实现软件不同模块和功能。

## Immutable Architecture 不变的架构

## Exceptions 异常处理

## Avoiding Primitive Obssesion 停止对原生类型的痴迷

## Avoiding Nulls with Maybe Type 使用Maybe类型避免Null

## Handling Failures and Input Errors in a Functional Way 用更功能架构的方式处理输入验证
