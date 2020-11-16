---
title: "单元测试入门-系列2"
date: 2020-10-19 01:07:18 +0800
categories: tech unit-testing
---

## Defination, again

Even after all these years, we still don’t have common terminology for unit tests. Just to make things clear, we’ll define unit tests as the tests that sit at the bottom of the [testing pyramid](https://martinfowler.com/bliki/TestPyramid.html).

These tests:

. examine a single class,  
. require just the source code of the application, instead of a running instance,  
. are fast,  
. are not affected by external systems, e.g. web services or databases, and  
. perform little or no I/O, e.g. no real database connections.  

## Benefits of Unit Testing

Unit Tests reveal a basic understanding of API units or functions to understand the functionality of the code.

It is a way to write test cases for all functions and methods so that whenever a change causes a fault then in that case bug quickly identified and fixed.

A modular approach followed in testing, single-single functionality or part of the code tested without waiting for other of code to be completed.

## Why Unit Testing Matters?

It is a type of testing that increases the speed of testing.

Unit testing helps to maintain and change the code. If good unit test cases are written for code and run every time code changes, any defect revealed after code changes.

Codes should be in the more reusable way, in a modular way more unit testing will be possible.

Writing test cases takes time but, this thing can be compensated by less amount of time it takes to run the tests.

Unit tests are more reliable, and development will be faster in the long run too.

It makes debugging easy. In this when a test fails, then only the latest changes need to be debugged. With testing at a higher level or higher phases, changes made over many days/ weeks/months need to be scanned or detected.

The cost to fix detected bugs during Testing lesser in comparison to the defects at higher levels. Compare the cost to fix a defect when a bug detected in a phase of unit testing with the same bug detected in Acceptance Testing.

The effort required to find and fix defects found during Unit Testing is less in comparison to the effort required to fix defects found during System Testing or Acceptance Testing.

## Best Practises of Unit Testing

There is no need to create test cases for every condition. Instead of that focus on tests that impact the behavior of the entire system. Before fixing a bug, write a test the expose the defects.

. The bug will re-occur if not appropriately cached.
. Test suites should be more comprehensive.
. Write test cases before fixing the defect.
. Write test cases independent of each other. For example, if a class of code depends upon a database, do not write a case that interacts with a database to test a class. Instead of that create an abstract interface around that database connection and after that implement an interface with a mock object.
. The most important thing for Unit Testing is to cover all the paths, it is required to pay attention to loop conditions also.
. Write cases to verify behavior, also write test cases to ensure the performance of the code.
. Execute test cases continuously and frequently.

## Reference
. [Stubbing and Mocking with Mockito and JUnit](https://semaphoreci.com/community/tutorials/stubbing-and-mocking-with-mockito-2-and-junit), Kostis Kapelonis