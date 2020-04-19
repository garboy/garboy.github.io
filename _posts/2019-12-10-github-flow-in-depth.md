---
title:  "GitHub flow 介绍"
date:   2019-12-10 16:38:18 +0800
categories: git flows
---

## Basic GitHub Flow

Start with 'master' brach, open 'feature' branch for feature develop, bug fix and etc. When the time comes, open a pull request, to discuss the code, solution with your team members, then deploy to production and merge back to 'master'.  
So open the PR early. It is better to know your direction is wrong better than know it in the last minute, lol.  

It looks easy, then a lot of questions comes after. Where do I deploy and test it before put into production? When do I do the code review, security checks, unit tests and etc?  
Do we need to run tests on each commit, PR or deploy?  

### Proect Branch

#### Rule #1

Proect master branch, disable force-pushes to it and prevents it from being deleted. It help reduce the accidental commits to master, and discussions are made before merge. Only authorized users can bypass. 

#### Rule #2

Require pull request reviews before merging. That means a pull request must be approved by certain numbers of reviewers, then it can be merged to protected branch.

### Rule #3

Only certain roles in team can merge the PR, let's say team leaders, development managers.  

### Rule #4

Require status checks passed before merging. Each commit will trigger a CI and feedback with a status check.  

### Continuous Integration, Continuous Delivery and Continious Deploy

## Refer

[GitHub Flow](https://guides.github.com/introduction/flow/)