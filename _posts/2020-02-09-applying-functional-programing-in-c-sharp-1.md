---
layout: post
title:  "C#函数式编程（一）"
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

一个人的大脑能够同时处理的信息很有限，我们的代码规模常常远远大于这个限度，这也是有时候为什么我们修复缺陷，新增功能，却很难避免带来副作用。通过函数式编程，能够帮助我们减少点复杂度，进而帮助我们更快，更高质量的编写更多软件。

上面小节举的例子可以看出，函数式方法的签名能够让我们很容易理解方法。如果每一个方法都是如此，也没有恼人的全局变量以及出其不意的异常，每一个方法能够彼此独立的测试，那么我们就可以把每一个方法看做构建软件的积木。通过组合不同的积木，实现软件不同模块和功能。

## Immutable Architecture 不变的架构

### 术语
**不可变（Immutablity）**, 常常用于修饰类，表明该类的实例在生命周期内不可以改变。  
**状态（State）**，表明数据的改变。  
**副作用（Side Effect）** 是改变状态的一些动作。通常指一些操作改变了可变类的状态，那就指它带来了副作用，比如写入文件系统，或者写入数据库。

可以想象到，一个不可变类，实际上是没有状态的。只有可变类，才会有状态。下面看一个例子，帮助我们理解这些概念。
```c#
public class UserProfile {
    private User _user;
    private string _address;
    public void UpdateUser(int userId, string name) {
        _user = new User(userId, name);
    }
}

public class User {
    public int Id { get; }
    public string Name { get; }

    public User(int id, string name) {
        Id = id;
        Name = name;
    }
}
```
User类是一个不可变类，因为它的Id, Name都是只读属性，只能通过构造函数来初始化。但是UserProfile是有副作用的，它可以通过UpdateUser方法，改变了User属性的状态，因此留下了副作用。

### 为什么关注不可变性

因为它使得你的代码不那么“诚实”。前面说的，方法签名必须明确指出它的输入和输出，但是伴随着副作用，我们的签名并不能够完整说明这点，方法的签名并不能说明返回值会是什么，或者说方法改变了什么。这使得方法的部分影响很难看到，必须要深入到方法实现里面，才能够完整了解方法实际改变了什么。

尤其是在多线程情况下，多线程竞争情况出现，使得状态更加难以追踪。实现不可变类无疑是防止外部的调用者、使用者有意无意改变实例状态的一种很好的手段，这样才能够使得程序的运行更加安全。

上例中的代码怎么改进呢？
```c#
public class UserProfile {
    private readonly User _user;
    private readonly string _address;

    public UserProfile(User user, string address) {
        _user = user;
        _address = address;
    }

    public UserProfile UpdateUser(int userId, string name) {
        var newUser = new User(userId, name);
        return new UserProfile(newUser, _address);
    }
}
```
首先UserProfile构造函数接收一个User类，然后UpdateUser方法会新建一个User和UserProfile实例，并返回给这个新UserProfile实例。同时User与Address为只读属性，只能通过构造函数，初始化的时候赋值。
这样有几个好处：
1. 我们通过方法签名，就能知道这些方法改变了什么，返回什么，也就是把副作用通过方法签名体现出来了。这样，代码的可读性也增强了，因为我们不再需要进入到方法体，才能知道这个方法改变了什么，会带来什么副作用。
1. 线程安全。没有竞争条件发生，所以多线程情况下，也安全。

### 可变性与耦合

再举一个反例，说明一下可变性是如何破坏代码的可读性以及可维护性的。
```c#
public class CustomerService {

    private Address _address;
    private Customer _customer;

    public void Process(string customerName, string addressString) {
        CreateAddress(addressString);
        CreateCustomer(customerName);
        SaveCustomer();
    }

    private void CreateAddress(string addressString) {
        _address = new Address(addressString);
    }

    private void CreateCustomer(string name) {
        _customer = new Customer(name, _address);
    }

    private void SaveCustomer() {
        var repository = new Repository();
        repository.Save(_customer);
    }
}
```
上面这个例子中，如果调换下Process()方法中调用那三个private方法的顺序，比如CreateCustomer()放到CreateAddress()前面，那就会失败。这其实就是一种时间耦合或者说叫temporal coupling。

不仅如此，这三个private方法的签名，并不能完整的描述方法真正需要的输入以及返回值。它们都严重依赖内部的局部变量。下面我们看看如何修改一下这个方法，以符合函数式编程的要求。
```c#
public class CustomerService {

    public void Process(string customerName, string addressString) {
        Address address = CreateAddress(addressString);
        Customer customer = CreateCustomer(customerName, address);
        SaveCustomer(customer);
    }

    private void CreateAddress(string addressString) {
        return new Address(addressString);
    }

    private void CreateCustomer(string name, Address address) {
        return new Customer(name, address);
    }

    private void SaveCustomer(Customer customer) {
        var repository = new Repository();
        repository.Save(customer);
    }
}
```
其实改动也很简单，就是去掉类的局部变量，给方法添上必要返回值与输入参数，没有什么特别的。但修改之后，代码的可读性会增加许多，而且方法也没有隐藏的副作用了，每一个方法会带来什么改变，通过方法签名能够明确知道。

### 不变类的局限性

虽然保持类的不变性增强了代码的维护性和可读性，但它也有它的局限性。可以从之前的例子看出来，如果想维护比较高的不可变性，不能通过修改已有实例的属性，而是需要创建新的实例，这样会带来很多内存和CPU的消耗。也许在企业软件中，这不是大问题，但是在特定软件里面，性能和资源消耗，可能需要重点考虑。所以有时候我们需要取舍，并不是一定要消灭掉所有的可变类，那样代价也太大。我们的目标是降低可变类的数量，但是它永远不可能降低到零。

在C#中除了手写之外，还有几个工具可以帮助我们实现不可变类。
第一个是一个NuGet包，可以帮助我们写一些通用的不可变集合，比如
```c#
// 方法1
ImmutableList<string> list = ImmutableList.Create<string>();
ImmutableList<string> list2 = list.Add("New Item");

//方法2
ImmutableList<string>.Builder builder = ImmutableList.CreateBuilder<string>();
builder.Add("Line 1");
builder.Add("Line 2");
builder.Add("Line 3");
ImmutableList<string> immutableList = builder.ToImmutable();
```
可以想象到，list2其实是重新创建了一个List集合，这样会带来一些性能损失。更推荐另一种做法，通过builder先准备数据，然后一次性的生成这个不可变集合。

### 处理副作用

很明显，就算使用不可变类来编程，我们依然不能摆脱副作用。上一章节的例子中，我们创建了customer实例，并最终把它存储到数据库中，并且存储数据库这个动作，我们从方法签名上并看不出来，另外，如果对象存储到外部文件或者数据库中，这也是一个副作用。显然我们是不可能消灭掉副作用的，那我们怎么处理呢？

这时候可以提到一个经常听过的名字, CQRS, Command-Query Seperate Principle，把命令与查询分开处理原则。也就是如果改变状态的那些动作，定义为Command，那些不会改变状态的动作，定义为Query。通常command返回为void，query返回非void的类型。

当然，没有绝对的，一个非常著名的改变了状态，并具有返回值的著名方法，就是 stack.pop()，移除并返回堆栈第一个元素。

//TODO: AuditManager.cs

## Exceptions 异常处理

> Always prefer using return values over exceptions.

## Avoiding Primitive Obssesion 停止对原生类型的痴迷

## Avoiding Nulls with Maybe Type 使用Maybe类型避免Null

## Handling Failures and Input Errors in a Functional Way 用更功能架构的方式处理输入验证
