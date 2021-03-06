---
title: "Scrum与用户故事"
date: 2021-03-20 11:00:00 +0800
categories: agile scrum
---
## Scrum in 3 min

Scrum是敏捷众多实践分支中的一种，它强调的是管理形式上的敏捷。从它的宣言可以看出，可工作的软件胜过详尽的文档，面对面的交流胜过……。并且Scrum定义著名的3355这四个数字。也就是3个角色，3个产出物，5个活动与5个价值观。

![scrum-in-one-pic](https://user-images.githubusercontent.com/1076902/111857719-693dd580-896e-11eb-9340-8e6ca059fd44.png)

既然是管理活动，那么落实在每日团队例行活动中，如何操作？首先，scrum中有一个sprint，冲刺的概念，也就是是一个时间盒。在这个冲刺中，团队紧密合作，通过每日站会、验收会，来确定本冲刺结束时，哪些交付物通过了验收，可以发布，哪些还需要继续改进。以及通过冲刺计划会议，来确定当前冲刺需要集中火力，给客户、用户，交付哪些功能、价值。

### 故事澄清活动

当然，如果团队只是在冲刺计划会上，第一次见到产品设计，会难以估计工作量，因为会有很多细节问题不断冒出来。为了冲刺计划会更加高效，重要的功能设计，一定不能在这个会上第一次和团队见面。这时候就会有一个个人认为更加重要的活动，也就是故事澄清会，有的也叫做 User Story Grooming, User Story Refinement，都是一个意思。在这个会议上，产品负责人从上到下，一个故事又一个故事的向团队阐述故事的功能设计，交互设计，验收条件。团队需要仔细考虑实现路径，是否有技术瓶颈，以及这个故事的工作量评估，以确定该故事是否可以在一个冲刺内完成。

强烈推荐把这个活动固定到团队日历中，变为每周的例行活动，这样能极大的消灭在计划会议时，大家需要做出承诺时，团队所面临的压力，使得计划会得出的冲刺计划更加准确。这其实是大瀑布变为变为小瀑布的一个重要手段。

### 团队日历

综合5个活动以及刚刚强调的故事澄清会，一个典型的双周团队日历，应当是这样子的。

![双周日历](https://user-images.githubusercontent.com/1076902/111857732-82468680-896e-11eb-85c3-68dbc473d0ac.png)

冲刺计划会：记得分为上下半场。上半场产品向团队介绍故事、验收标准，答疑。团队把制作标准清晰，可以开发的故事，拖动到冲刺计划中，直至团队认为有足够多的故事为止。下半场主要是团队内部，挨个故事讨论实现方式，明确每一个故事的实现路径，并以此拆分子任务。

冲刺评审：团队挨个向产品、业务演示做完的故事，由对方验收，进而确定是否部署。

冲刺回顾：团队、产品坐一起，回顾下本周期内，有哪些值得保留，继续发扬的地方；有哪些做的不够好，可以改进的地方，并列出改进项目和执行人，在下个周期甚至更久的未来执行改进。

## 用户故事

As a < role >, I want to < do something >, so that I can < benifit from ... >.

严格的定义强调三段内容，角色，做什么，为什么，也就是Who, What, Why。但在实践中，故事经常被简写为一个标题，比如“安全合规培训的开屏广告”，

### 3C

Card - 卡片。用户故事开始都是记录在即时贴上，然后再贴到墙上。后来才有了各种电子看板。

Conversation - 对话。卡片上记录的寥寥几笔，只是为了开启一段和用户、客户、以及其它相关方的谈话，是一个引子。

Confirmation - 确认。用户故事需要能够被确认，被验收。因此引入了必须要有验收条件，什么样算通过，做完，什么样算没做完。

### INVEST

好的故事具有INVEST特点

I - Independent，独立性。故事应当是独立的，每一个故事应当独立具有业务价值。

N - Negotiable，可讨论。故事不是一个需求规格说明书，也不是什么标准文档。它只是一个谈话的开始。随着谈话的深入，细节越来越丰富，故事的可讨论行也在不断下降。进入到开发队列中的故事，应当是不变的。

V - Valueable，有价值。每一个故事都应当有业务价值。

E - Estimable，可评估。故事具备足够的细节和验收条件，这样才能够评估故事的难易程度、复杂程度。

S - Small，小。好的故事颗粒度是足够小的。过大的故事会使得评估、开发无从下手。比如需要一个类似于135的文章编辑器。这样的故事交给开发团队毫无意义，最多它算作一个史诗任务，或者说产品目标。

T - Testable，可测试。以终为始，知道这个故事做完后，什么是对的，什么是不对的，也就是具备验收条件，明确验收标准，这样的故事才能够最大程度上避免开发浪费。否则，只有做出来，用起来才知道合适不合适，很容易造成反复，返工。

![UserStory](https://user-images.githubusercontent.com/1076902/111857767-b457e880-896e-11eb-941f-14c9fcf03e35.png)

讲完什么是好的用户故事，下面讲一讲用户故事产生的过程。

### 故事产生 - 故事地图

![Epic-Stories](https://user-images.githubusercontent.com/1076902/111857790-dd787900-896e-11eb-8655-96a6eb2468bd.png)

最初的故事都是一些史诗故事，在后续的沟通过程中，逐渐细化，分解为更多，更细粒度的用户故事。

![User-Story-Map](https://user-images.githubusercontent.com/1076902/111857810-0731a000-896f-11eb-9b1c-c6a23b08ea96.png)

用户故事地图，通常用于新产品或者新版本的早期阶段。先通过若干史诗级别的故事，确定产品的几个重要目标。然后不断细化，细化，得到更具体的功能点。之后把相似模块里面的故事组织到一起，并且通过用户画像，用户故事地图，来得到产品的前几个版本需要完成的故事。

当然，上面的过程是针对开发进行了裁剪。产品设计人员在脑暴故事的过程中，并不会完全脑暴，而是需要收集问题、数据、反馈，进行走访、调查，也有一套方法论和实操指导，来得到故事，并确定优先级。比如

用户画像（Persona）→ 用户体验地图（User Journey Map）→ 用户故事地图（User Story Map）

- 用户画像  
![persona-user](https://user-images.githubusercontent.com/1076902/111857838-4233d380-896f-11eb-815b-439d2aa89b07.png)
![persona-admin](https://user-images.githubusercontent.com/1076902/111857842-45c75a80-896f-11eb-9f20-a7792d890303.png)

- 设计用户旅程  
![user-journey-user](https://user-images.githubusercontent.com/1076902/111857879-86bf6f00-896f-11eb-933d-b0f57f5566a6.png)
![user-journey-admin](https://user-images.githubusercontent.com/1076902/111857880-89ba5f80-896f-11eb-872b-c8bf5e7486cc.png)

- 分组、归类  
![grouping-user](https://user-images.githubusercontent.com/1076902/111857885-9b9c0280-896f-11eb-8b60-a4a5c6b18031.png)
![grouping-admin](https://user-images.githubusercontent.com/1076902/111857886-9e96f300-896f-11eb-88de-09e65ff2bde1.png)

- 用户故事地图
![User-Story-Map](https://user-images.githubusercontent.com/1076902/111857810-0731a000-896f-11eb-9b1c-c6a23b08ea96.png)

### 故事的拆分

故事是一个需求、改动的引子，因此有时候一个故事难免过大，难以下手。或者说难以在团队既定的一个交付周期内实现。所以故事的拆分活动，通常也会占产品的大量工作时间。

故事的拆分可以从两个角度入手，横向拆分和纵向拆分。

#### 横向

例如上面的故事地图中，layout 被拆为 General Header 和 General Footer，就是横向拆分，它把整个页面的布局，按照页面结构拆成了头部和底部两部分。

还有一种横向拆分比如说，文章的搜索。我们可以拆成按照文章作者搜索，按照标题搜索，按照正文内容搜索，按照标签搜索等等。这些故事都可以独立的开发上线，随着一个个交付，产品的功能越来越丰富。当然，也有可能某种条件的搜索，会被认为价值不大，就不开发了。

#### 纵向

纵向拆分，从大故事的完整体验拆分。比如ATM机器的取现金功能，可以拆为转账，打印凭据，使用评价这三个故事，甚至再拆分一下，转账成功后，需要能够显示账户余额。

或者继续拿刚才的搜索举例。可以按照搜索结果支持分页显示；搜索无结果时显示“未找到”；搜索结果需要把关键词高亮显示等。

可以看出来，纵向拆分时，考虑的角度往往和大故事的验收条件有关。没错，因为往往随着故事细节越来越丰富，验收条件逐渐演变为各种子场景，那么当考虑这么多子场景之后，故事难以再一个周期内交付，我们就可以采用这种纵向拆分的方法，逐步交付价值。

#### 误区

需要注意的是，纵向拆分不要按照职能或者技术栈来拆分。比如经常有团队会写出“提供一个按标题搜索的接口”，“提供按作者搜索的接口”，“前端实现搜索页面”，“实现搜索结果页面”。这样之所以不推荐，是因为这些独立的故事，并不能独立交付。除非你开发的产品就是一套API。这样按照实现路径，不同职能分工的拆分方法，更建议用在把故事拆分成任务的时候。因为故事需要有业务价值，任务需要具体到一个人。

## Take Away

- 想清楚如何验收
- 不要吝惜拆分，尺度适合开发和验收即可
- 故事澄清活动非常重要（但它又不在SCRUM的3355里面……）
- 用户故事地图可以帮助确定版本计划、冲刺计划，尤其是在一个新项目启动时。

## reference

[User Story Essentials](https://www.jpattonassociates.com/wp-content/uploads/2015/03/story_essentials_quickref.pdf)  
[Story Mapping](https://www.myagilepartner.com/blog/index.php/2018/08/19/story-mapping/)  
