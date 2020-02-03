---
layout: post
title:  "Pragmatic Unit Test Suite"
date:   2020-01-18 10:11:18 +0800
categories: testing
---

## Goals of unit test

> unit test != good design

1. confidence, changes don't break existing functionality.
1. move fast
1. maintain low amount of technical debt.

## Coverage Metrics

1. good indicator of a trend
1. cannot measure effectiveness

such as,  

### Code Coverage

> code coverage, = (lines of code covered) / (overall number of lines)

```csharp
//code
public static bool IsStringLong(string input)
{
    if (input.Length > 5)
        return true;
    return false;
}

//test

[Fact]
public void Test()
{
    bool result = utils.IsStringLong("abc");
    Assert.Equal(false, result);
}
```

above sample the code coverage is 4/5 = 80%, but what if we change code to following,

```csharp
public static bool IsStringLong(string input)
{
    return input.Length > 5;
}
```

now the code coverage will be 100%, but nothing changed, no more senarios covered.

There's another more helpful metric, branch coverage.

### Branch Coverage

> branch coverage = (branches traversed) / (number of branches)

same code in above example, the branch coverage is 50%, because there are 2 branches, and the test only covered the 'else' branch.

While it looks like a joke, but it quite common in some company that calculate the metrics for unit test, they will see unit test that only have sut called, but no assertions, that is called 'assertion-free testing'.  

These assertion-free test only keep metrics up, but is harmful to code base, since it will give you a fake result, and it doesn't verify anything.

What if we use branch coverage and verify all the component, side variables, in the sut, is that give us enough confident that our code has quite good quality? Not quite, let's look following example code.

```csharp
// code
public static int Parse(string input)
{
    return int.Parse(input);
}

// test
[Fact]
public void Test()
{
    int result = Util.Parse("5");
    Assert.Equals(5, result);
}
```
Above code is 100% branch coverage and all the outcome is fully tested. But it still missing lot's of edge senarios, such as null, negative, "", "not an int" and etc, so the high number of branching coverage is not equal to high quality of code, we need to find other metrics.

There are two kind of indicators, 'good negative indicator' and 'bad positive indicator'.  

Good negative indicator means if coverage numbers are low, you aren't testing your code base significantly enough.  

Bad positive indicator means if coverage numbers are high, it doesn't mean anything.

In one sentense, don't push too much on high coverage indicator, spend more time on testing business logic.

> High coverage numbers != High quality test suite

---

## Pragmatic Approach to Unit Testing

1. carefully choose code to test
1. Use the most valuable tests only

Write code is an expensive way to solve problems, so does the unit tests. The more test you write, the more maintaince works you need to carry on.

**What makes a test valuable?**
1. Has a high chance of catching a regression error.
1. Has a low chance of producing a false positive.
1. Provides fast feedback.
1. Has low maintenance cost.

---

## 3 Styles of Unit Testing

### Output Verification

Focus on the return value, and the class has no internal or global variables that impact on the business logic.

```C#
public class PriceEngine
{
    public decimal CalculateDiscount(params Product[] product)
    {
        decimal discount = product.Length * 0.01m;
        return Math.min(discount, 0.2m);
    }
}

...

[Fact]
public void Test()
{
    Product product1 = new Product("Hand wash");
    Product product2 = new Product("Shampoo");
    var engine = new PriceEngine();

    decimal discount = engine.CalculateDiscount(product1, product2);

    Assert.Equal(0.02m, discount);
}
```
The logic is all in the method itself, tests are just check the input and output params.

### State Verfication

```C#
public class Order
{
    private readonly List<Product> _products;
    public IReadOnlyList<Product> Products => _products.ToList();

    public void AddProduct(Product product)
    {
        _products.Add(product);
    }
}

...

[Fact]
public void Test()
{
    Product product = new Product("Hand wash");
    Order order = new Order();

    order.AddProduct(product);

    Assert.Equal(1, order.Products.Count);
    Assert.Equal(product, order.Product[0]);
}
```

### Collaboration Verfication

Focus on SUT and its neighbors, check all the neighbors are invoked in correct order and with correct parameters. This needs mocks.

```C#
public class OrderService
{
    public void Submit(Order order, IDatabase database)
    {
        database.Save(order);
    }
}

...

[Fact]
public void Test()
{
    var order = new Order();
    var service = new OrderService();
    var mock = new Mock<IDatabase>();

    service.Submit(order, mock.Object);

    mock.Verify(x => x.Save(order));
}
```

---

## Hexagonal Architecture

. Domain model is the most important part of application
. It doesn't communicate with the outside world
. Shouldn't know how it is persisted to the DB

All the communication, persistation works should be done in application service, not in domain model itself.  
Unit test against domain logic should use output verification, and the integration tests should test those code involves different part of application services, external dependencies, and databases.

Keep in mind that those external dependencies can be seperated into 2 types:
- You can control, test against them directly. Such as database, file systems and etc.
- You cannot control, use mocks, test doubles. Such as third party services, email services, sms services. 

## Test Data Cleanup
There several ways to cleanup data left in tests.
1. Restore database backup before each test.
1. Wipe out data after test execution.
1. Wrap each test with a transaction, and not commit during each test.

Each of above has its own side-effects, too slow, some data can remain in db, if the test doesn't finish properly, and can interfere with the SUT's flow.

The solution is quite simple, wipe out all data before test execution, because:

- Each test creates its own set of test data
- Only master data should be deleted(reference data could be kept)
- Setup proper database delivery

## Avoiding Unit Test Anti-patterns

### Exposing Implementation Details

Test the Observable behavior only.

This means only test those public API, no private methods. If you need to make some method or property from private to public, that is an anti-pattern, it means you are exposing implemention details to outside world.

### Leaking Domain Knowledge to Tests

Some tests are just a copy-paste of domain logic, such as,

```c#
public static class Calculator
{
    public static int Add(int value1, int value2)
    {
        return value1 + value2;
    }
}

public class CalculatorTests
{
    [Theory]
    [InlineData(1,3)]
    [InlineData(11,33)]
    [InlineData(100,500)]
    public void Add_two_numbers(int value1, int value2)
    {
        int expected = value1 + value2;
        int actual = Calculator.Add(value1, value2);
        Assert.Equal(expected, actual);
    }
}
```

Above tests are just a copy-paste of core logic, so it means nothing, even it uses parameters to test those senarios.

If you change the logic, you may just copy the changed code to the tests, so these tests don't contribute to confidence, it should be avoid.

How to deal with these algorithm tests?  
We could use two types of tests:

- Properties of the algorithm, [Introduction to Property-based Testing](), by Mark Seemann
- The end result. Pre-calculate the results and hard-coded them into tests.

We modify the tests using second way.

```c#
public static CalculatorTests
{
    [Theory]
    [InlineData(1,3,4)]
    [InlineData(11,33,44)]
    [InlineData(100,500,600)]
    public void Add_two_numbers(int value1, int value2, int expected)
    {
        int actual = Calculator.Add(value1, value2);
        Assert.Equal(expected, actual);
    }
}
```

### Code Pollution

This means you write code in the class, but it just for the tests. You need to move the code snippet from code to test code. That is don't introduce code to your main code base solely for testing purposes.

### Non-determinism in Tests

Such as following tests for asynchronous jobs.
```c#
[Fact]
public void Test()
{
    var sut = new CustomerService();
    sut.FirePeriodJob();

    Thread.Sleep(10000);

    /* Verify the effects of the job */
}
```

This is a bad practise, because you are not sure how long the job will take. It makes your tests pass or fail without confidence. So these kind of tests are not given feedbacks, we should seperate the async-job from complex code, and only test the complex code, leave asynchronous code untouched. Like,
```c#
[Fact]
public void Test()
{
    var sut = new CustomerService();
    Task task = sut.FirePeriodJobAsync();

    task.Wait();

    /* Verify the effects of the job */
}
```
If it's impossible to make function async, you could check the result periodly. Here's a good video-[Unit testing patterns for concurrent code](https://vimeo.com/171317257).

Another situation is the DateTime.Now(). You can not make sure the value of DateTime.Now() doens't change if you create something in DB, then checks its creation date in tests, such as,

```c#
public class CustomerTests
{
    public void create_tests()
    {
        var sut  = new CustomerService();
        var customer = sut.Create("Name");
        Assert.Equal(DateTime.Now, customer.DateCreated);
    }
}
```
This test may pass or not, depended on the test executed fast or not.

 We coud introduce a new class 'SystemDateTime' to replace the DateTime.Now.

 ```c#
 public static class SystemDateTime
 {
     private static Func<DateTime> _func;
     public static DateTime Now
     {
         get { return _func(); }
     }

     public static void Init(Func<DateTime> func)
     {
         _func = func;
     }
 }
 ```

The benefit of this code is you can pass in a function that return a datetime. That means you can pass in 'DateTime.Now' in production, and pass a fixed date in tests.

`// initialization code for production`  
`SystemDateTime.Init(() => DateTime.Now);`

`// initialization code for unit tests`  
`SystemDateTime.Init(() => new DateTime(2019,12,31));`

## Resources List
1. [Source code](https://github.com/vkhorikov/autobuyer)
1. [Eradicating non-determinism in tests](http://martinfowler.com/articles/nonDeterminism.html)
1. [Interfaces are not abstractions](http://blog.ploeh.dk/2010/12/02/Interfacesarenotabstractions/)
1. [Cyclic dependencies are evil](https://fsharpforfunandprofit.com/posts/cyclic-dependencies/)
1. [Humble object](http://xunitpatterns.com/Humble%20Object.html)
1. [Unit testing patterns for concurrent code](https://vimeo.com/171317257)
