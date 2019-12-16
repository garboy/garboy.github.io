---
layout: post
title:  "砸扁，并提交一个干净的Git Commit历史"
date:   2019-12-09 09:38:18 +0800
categories: tech
---

## Why

1. 各个项目组分支情况不统一，换项目组都需要重新了解一下分支模型。
2. 不能保证环境与分支的关系，比如生产只允许 master 分支。
3. 代码扫描无法统一进行，需要开发团队自行扫描，提交数据，无法控制扫描的是实际的代码。

## Take away

1. develop/master 这两个分支必须存在，并且受保护，禁止直接 commit 至这两个分支。
2. 只有 master 角色可以合并请求。
3. 项目代码工程创建在 Group 中，可以再创建 sub-group，禁止项目代码创建在个人空间
4. 根据发布计划，挑选需要发布的分支到 develop 中。如果不需要上线的代码，尽量通过功能开关来关闭，下策是通过 git 的提交历史，cherry-pick 出不需要发布的代码。

### Plan

### Commands

`git log --graph --decorate --pretty=oneline --abbrev-commit`
`git rebase -i HEAD~n`
