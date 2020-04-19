---
title:  "测试驱动开发规范"
date:   2020-01-13 09:00:00 +0800
categories: devops
---

# 测试驱动

## 目的

目的有两个，一方面我们通过TDD提高应用程序内部质量，另一方面我们通过ATDD/BDD确保交付客户的软件是符合用户需求的。即在细节上，我们用TDD方法以测试驱动的方式编写代码。在较高的，即软件的特性和功能层面上，我们使用类似的ATDD方法以测试驱动的方式构建系统。

可以用一个表格说明3者在实践过程中的不同方法

比较项|ATDD|TDD|BDD
---|---|---|---
涉及用户与专注点|业务、开发与测试，用于保证需求收集的质量|开发，用于保证代码与设计的质量|前面二者的联合，主要用于充分验证需求得到满足，边界场景考虑完善
输入文档|验收场景与数据，基于given... with... then...这种格式|需求|接近自然语言描述的需求规格说明，基于given... with... then...这种格式
用户故事、代码与测试的对应关系|每一个用户故事都有至少2、3个验收条件|每一个公共方法都有单元测试覆盖|每一个用户故事都有对应的行为测试，整个功能和系统，有更多的用于集成、系统测试的行为测试用例
自动化执行情况|自动化执行，可以用于冒烟测试的阶段|自动化执行，每一个测试用例执行时间是几十毫秒级，每一次集成过程都需要运行全部的UT，并输出报告|自动化，可以用于回归测试
实施阶段|需求细化的阶段，通常也是用户故事细化的阶段|开发阶段|开发阶段编写测试场景，执行阶段通常位于集成之后，或者至少在回归阶段需要全量的运行一遍

## 原则

1. Unit Test, ATDD以及BDD可以自动化执行。
2. BVT（集成验证测试）是BDD的一个子集，自动化运行。
3. 每次commit都会触发UT运行，并反馈结果。
4. 每次MR触发BVT验证，并反馈结果。
5. 每日至少运行一次全量回归的BDD测试，并反馈结果。

## 方法

Sprint N 开发阶段  

 1. QA为用户故事编写BDD用例，完成后须于SDE/TPM确认。
 1. SDE编写单元测试与业务代码。
 1. 每一次code commit，产出2个报告：1-本次提交的UT结果；2-本次提交对测试覆盖率的影响。
 1. 每一个merge request产生时，产生1个报告：1-BVT的测试结果。
 1. 每日夜间进行回归测试，并将测试报告推送给全体团队成员。
 1. TPM 为 N+1 冲刺编写ATDD的用例，只有ATDD用例团队通过，用户故事才可以进入Ready状态。

## 指标

1. 覆盖率指标：包括 方法覆盖率， 分支覆盖率 以及最后的行覆盖率
2. User Story的验收条件必须用ATDD/BDD兼容的格式确定下来
3. 部署到生产系统的代码必须达到100%测试通过率
4. 冲刺周期内，每日构建的BDD测试通过率变化曲线

---

## 更多内容

### 概念

[测试驱动开发](https://zh.wikipedia.org/wiki/%E6%B5%8B%E8%AF%95%E9%A9%B1%E5%8A%A8%E5%BC%80%E5%8F%91)（Test-Driven Development，TDD），用一句话讲，就是“写代码只为修复失败了的测试”。我们先写一个测试，然后再写代码让测试通过。当我们在当前结构中找出最佳设计时，由于有足够的测试做保障，我们可以放心地改动现有设计而不必担心破坏已完成的功能。使用这种开发方法，我们可以让设计更加优良，能编写出可测试的代码，同时还能避免在不切实际的假设基础上过度地设计系统。要得到这些好处，只需不断添加可执行测试，一步步地驱动设计，从而最终实现整个系统。

这种短开发周期的开发方式与旧方式有很大不同。我们习惯于先设计，然后编码实现，最后做一些并不完备的测试。（我们都是优秀的程序员，很少犯错，所以稍加测试即可，不是吗？）TDD完全颠倒了整个过程。我们会先写测试描述出目标，然后写代码达到这个清晰的目标，最后再设计——在已有代码的基础上找出最简单的设计。

随着TDD不断深入到开发领域，这种测试先行的思想也不断向上深入到需求阶段，衍生出来ATDD、BDD等相关方法。

#### ATDD

[Acceptance test–driven development](https://en.wikipedia.org/wiki/Acceptance_test%E2%80%93driven_development) (ATDD) is a development methodology based on communication between the business customers, the developers, and the testers.[1] ATDD encompasses many of the same practices as specification by example (SBE),[2][3] behavior-driven development (BDD),[4] example-driven development (EDD),[5] and support-driven development also called story test–driven development (SDD).[6] All these processes aid developers and testers in understanding the customer's needs prior to implementation and allow customers to be able to converse in their own domain language.

ATDD is closely related to test-driven development (TDD).[7] It differs by the emphasis on developer-tester-business customer collaboration. ATDD encompasses acceptance testing, but highlights writing acceptance tests before developers begin coding.

#### BDD

[行为驱动开发](https://zh.wikipedia.org/wiki/%E8%A1%8C%E4%B8%BA%E9%A9%B1%E5%8A%A8%E5%BC%80%E5%8F%91)（英语：Behavior-driven development，缩写BDD）是一种敏捷软件开发的技术，它鼓励软件项目中的开发者、QA和非技术人员或商业参与者之间的协作。BDD最初是由Dan North在2003年命名[1]，它包括验收测试和客户测试驱动等的极限编程的实践，作为对测试驱动开发的回应。在过去数年里，它得到了很大的发展[2]。

2009年，在伦敦发表的“敏捷规格，BDD和极限测试交流”[3]中，Dan North对BDD给出了如下定义：

BDD是第二代的、由外及内的、基于拉(pull)的、多方利益相关者的(stakeholder)、多种可扩展的、高自动化的敏捷方法。它描述了一个交互循环，可以具有带有良好定义的输出（即工作中交付的结果）：已测试过的软件。

BDD的重点是通过与利益相关者的讨论取得对预期的软件行为的清醒认识。它通过用自然语言书写非程序员可读的测试用例扩展了测试驱动开发方法。行为驱动开发人员使用混合了领域中统一的语言的母语语言来描述他们的代码的目的。这让开发者得以把精力集中在代码应该怎么写，而不是技术细节上，而且也最大程度的减少了将代码编写者的技术语言与商业客户、用户、利益相关者、项目管理者等的领域语言之间来回翻译的代价。

### 参考列表

1. TDD, ATDD与BDD的比较: [Test Approach and Comparisons between ATDD TDD and BDD](https://www.toolsqa.com/blogs/test-approach-and-comparisons-between-atdd-tdd-and-bdd/)
1. 前端单元测试覆盖率介绍的一篇博客[Introduction to Front-End unit testing](https://dev.to/christopherkade/introduction-to-front-end-unit-testing-510n)
1. 一个前端测试利器，避免前端测试陷入各种ui element，xml path等各种可读性灾难里面，[UI-licious](https://dev.to/ben/does-your-team-write-code-tests-for-front-end-code-3494)
1. [Istanbul](https://github.com/istanbuljs), Javascript test coverage made simple.
1. [Cypress](https://www.cypress.io/),A complete end-to-end testing experience.
1. [Front-end JavaScript test coverage with Istanbul + Selenium](https://medium.com/@the1mills/front-end-javascript-test-coverage-with-istanbul-selenium-4b2be44e3e98)，一篇非常不错的如何做前端的测试覆盖率，以及把这件事做对。
1. [Measure your code coverage using Istanbul](https://medium.com/walkme-engineering/measure-your-nodejs-code-coverage-using-istanbul-82b129c81ae9)，另一篇讲如何把前端测试覆盖率统计到CI中的文章。
1. [Jest](https://jestjs.io/)，或者简单一些，就用Jest，也能搞定全部。
