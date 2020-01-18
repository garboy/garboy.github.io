---
layout: post
title:  "务实的Unit Test(TBD)"
date:   2020-01-18 10:11:18 +0800
categories: testing
---

## Pragmatic Unit Test Suite

### Unit Test

#### Goals of unit test

> unit test != good design

1. confidence, changes don't break existing functionality.
1. move fast
1. maintain low amount of technical debt.

#### Coverage Metrics

1. good indicator of a trend
1. cannot measure effectiveness

such as,  

##### Code Coverage

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

##### Branch Coverage

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

**High coverage numbers != High quality test suite**

#### Pragmatic Approach to Unit Testing

1. carefully choose code to test
1. Use the most valuable tests only

Write code is an expensive way to solve problems, so does the unit tests. The more test you write, the more maintaince works you need to carry on.

**What makes a test valuable?**

1. Has a high chance of catching a regression error.
1. Has a low chance of producing a false positive.
1. Provides fast feedback.
1. Has low maintenance cost.

