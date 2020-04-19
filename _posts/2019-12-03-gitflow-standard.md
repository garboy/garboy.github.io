---
title:  "Git Flow 分支规范"
date:   2019-12-06 09:38:18 +0800
categories: git flows
---
![Git Flow](https://user-images.githubusercontent.com/1076902/70313637-f67c1a00-1850-11ea-9697-184d102e17aa.png)

## 分支约定

Git Flow有主分支和辅助分支两类分支。其中主分支用于组织与软件开发、部署相关的活动；辅助分支组织为了解决特定的问题而进行的各种开发活动。

### 主分支

主分支是所有开发活动的核心分支。所有的开发活动产生的输出物最终都会反映到主分支的代码中。主分支分为master分支和develop分支。

#### master 分支

. master分支存放的是随时可供在生产环境中部署的稳定版本代码
. master分支保存官方发布版本历史，release tag标识不同的发布版本
. 一个项目只能有一个master分支
. 仅在发布新的可供部署的代码时才更新master分支上的代码
. 每次更新master，都需对master添加指定格式的tag，用于发布或回滚
. master分支是保护分支，不可直接push到远程仓master分支
. master分支代码只能被release分支或hotfix分支合并

#### develop 分支

. develop分支是保存当前最新开发成果的分支
. 一个项目只能有一个develop分支
. develop分支衍生出各个feature分支
. develop分支是保护分支，不可直接push到远程仓库develop分支
. develop分支不能与master分支直接交互

### 辅助分支

辅助分支是用于组织解决特定问题的各种软件开发活动的分支。辅助分支主要用于组织软件新功能的并行开发、简化新功能开发代码的跟踪、辅助完成版本发布工作以及对生产代码的缺陷进行紧急修复工作。这些分支与主分支不同，通常只会在有限的时间范围内存在。

辅助分支包括：

. 用于开发新功能时所使用的feature分支
. 用于辅助版本发布的release分支
. 用于修正生产代码中的缺陷的hotfix分支
以上这些分支都有固定的使用目的和分支操作限制。从单纯技术的角度说，这些分支与Git其他分支并没有什么区别，但通过命名，我们定义了使用这些分支的方法。

#### feature 分支

使用规范：

命名规则：feature/*
. feature分支使用develop分支作为它们的父类分支
. 以功能为单位从develop拉一个feature分支
. 每个feature分支颗粒要尽量小，以利于快速迭代和避免冲突
. 当其中一个feature分支完成后，它会合并回develop分支
. 当一个功能因为各种原因不开发了或者放弃了，这个分支直接废弃，不影响develop分支
. feature分支代码可以保存在开发者自己的代码库中而不强制提交到主代码库里
. feature分支只与develop分支交互，不能与master分支直接交互
如有几个同事同时开发，需要分割成几个小功能，每个人都需要从develop中拉出一个feature分支，但是每个feature颗粒要尽量小，因为它需要我们能尽早merge回develop分支，否则冲突解决起来就没完没了。同时，当一个功能因为各种原因不开发了或者放弃了，这个分支直接废弃，不影响develop分支。

#### release 分支

使用规范：

命名规则：release/*，“*”以本次发布的版本号为标识
. release分支主要用来为发布新版的测试、修复做准备
. 当需要为发布新版做准备时，从develop衍生出一个release分支
. release分支可以从develop分支上指定commit派生出
. release分支测试通过后，合并到master分支并且给master标记一个版本号
. release分支一旦建立就将独立，不可再从其他分支pull代码
. 必须合并回develop分支和master分支
release分支是为发布新的产品版本而设计的。在这个分支上的代码允许做小的缺陷修正、准备发布版本所需的各项说明信息（版本号、发布时间、编译时间等）。通过在release分支上进行这些工作可以让develop分支空闲出来以接受新的feature分支上的代码提交，进入新的软件开发迭代周期。

当develop分支上的代码已经包含了所有即将发布的版本中所计划包含的软件功能，并且已通过所有测试时，我们就可以考虑准备创建release分支了。而所有在当前即将发布的版本之外的业务需求一定要确保不能混到release分支之内（避免由此引入一些不可控的系统缺陷）。

成功的派生了release分支，并被赋予版本号之后，develop分支就可以为“下一个版本”服务了。所谓的“下一个版本”是在当前即将发布的版本之后发布的版本。版本号的命名可以依据项目定义的版本号命名规则进行。

#### hotfix 分支

使用规范：

命名规则：hotfix/*
. hotfix分支用来快速给已发布产品修复bug或微调功能
. 只能从master分支指定tag版本衍生出来
. 一旦完成修复bug，必须合并回master分支和develop分支
. master被合并后，应该被标记一个新的版本号
. hotfix分支一旦建立就将独立，不可再从其他分支pull代码
除了是计划外创建的以外，hotfix分支与release分支十分相似：都可以产生一个新的可供在生产环境部署的软件版本。

当生产环境中的软件遇到了异常情况或者发现了严重到必须立即修复的软件缺陷的时候，就需要从master分支上指定的TAG版本派生hotfix分支来组织代码的紧急修复工作。

这样做的显而易见的好处是不会打断正在进行的develop分支的开发工作，能够让团队中负责新功能开发的人与负责代码紧急修复的人并行的开展工作。

## 推荐工具

. [SourceTree](https://www.sourcetreeapp.com/) 集成了Git Flow 功能，能简单方便的操作和实现常规的工作流程。支持 OSX 和 Windows 平台。
. [IntelliJ GitFlow 插件](https://github.com/OpherV/gitflow4idea) 习惯于在一个IDE中搞定一切的开发们，可以考虑这个插件，并且英文不好的还有一篇中文简书。
. [Git Flow 扩展](https://github.com/nvie/gitflow) Git Flow 模型提出者 nvie 写的 Git 命令集扩展，提供了极出色的命令帮助以及输出提示。支持 OSX，Linux 和Windows 平台。参考：git-flow 备忘清单
