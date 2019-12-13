---
layout: post
title:  "Git flow, GitHub flow and GitLab flow"
date:   2019-11-07 09:38:18 +0800
categories: git flows
---

# Git flow, GitHub flow and GitLab flow

## Considerations

1. release model. Release Train or Deploy fast, Deploy often.
2. tailor it to fit in your CI/CD process.

## Branching Types

### Git flow

![Git-Flow Diagram](https://nvie.com/img/git-model@2x.png)  

---

### GitLab Flow

3 types of gitlab flow  

#### Production branch with GitLab flow

![GitLab Flow - Production Branch](https://about.gitlab.com/images/git_flow/production_branch.png)  

#### Environment branches with GitLab flow

![Environtment branches](https://about.gitlab.com/images/git_flow/environment_branches.png)

#### Release branches with GitLab flow

![Release branches](https://about.gitlab.com/images/git_flow/release_branches.png)

Above all, there is one pic more clearly
![gitlab flow in one pic](https://pic4.zhimg.com/80/v2-8c0678c68ffe9940ce81b9b6d2fdc32b_hd.jpg)

The GitLab Flow is based on [11 rules](https://about.gitlab.com/blog/2016/07/27/the-11-rules-of-gitlab-flow/):

1. Use feature branches, no direct commits on master
2. Test all commits, not only ones on master
3. Run all the tests on all commits (if your tests run longer than 5 minutes have them run in parallel).
4. Perform code reviews before merges into master, not afterwards.
5. Deployments are automatic, based on branches or tags.
6. Tags are set by the user, not by CI.
7. Releases are based on tags.
8. Pushed commits are never rebased.
9. Everyone starts from master, and targets master.
10. Fix bugs in master first and release branches second.
11. Commit messages reflect intent.

**Pros**
It defines how to make the Continuous Integration and Continuous Delivery
The git history will be cleaner, less messy and more readable (see why devs prefers squash and merge, instead of only merging, on this article)
It is ideal when it needs to single version in production

**Cons**
It is more complex that the GitHub Flow
It can become complex as Git Flow when it needs to maintain multiple version in production

---

### GitHub flow

![GitHub Flow](https://user-gold-cdn.xitu.io/2018/12/3/167738fe00a73a92?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

. Anything in the master branch is deployable
. To work on something new, create a descriptively named branch off of master (ie: new-oauth2-scopes)
. Commit to that branch locally and regularly push your work to the same named branch on the server
. When you need feedback or help, or you think the branch is ready for merging, open a pull request
. After someone else has reviewed and signed off on the feature, you can merge it into master
. Once it is merged and pushed to 'master', you can and should deploy immediately

1. 'master' is stable and safe for produciton, always. Thus you need to keep it tested and approved. If you break it, you will face to social pressure that comes from other team memebers.
2. create a descriptively branch for either feature or bug fix kind of work. This is nice when you browse the branch page, all the on-going works will be clear at a glance.
3. fire off a pull request at anytime, not only when you think it's ready. Remember you could commit unlimited times for a same PR, and each commit will fire-off CI process.
4. Merge only PR is reviewed, and go-live it immediately.

*Pros.*
Simple and effective.
Mergeing often, deploy often, Minimize unreleased code, inline with lean and continuous delivery best practices.

*Cons*
not suitable for those fixed window and release train model. Such as iOS apps, you have to wait Apple review and approve your artifacts, then you go live. That will leave a gap between code in master and code in market.

---

### Concordya flow

1. 2 long-lived branches, master and dev.
2. developers can commit to dev directly, without code review.
3. when **Code Freeze** day comes, gate keeper will merge dev into master, and CI will deploy master to staging environment.
4. only bug fixes will be allowed, and direct commit to master in this period of time.
5. each deployed will be tagged as 'x.x.x-rc?', and tagged as 'x.x.x' after go live.
6. merge back to dev, move on to another sprint.

---

## Reference

. [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/)  
. [GitHub Flow](https://guides.github.com/introduction/flow/)  
. [GitLab Flow](https://about.gitlab.com/blog/2014/09/29/gitlab-flow/)  
. [terms in gitlab flow](https://stackoverflow.com/questions/39917843/what-is-the-difference-between-github-flow-and-gitlab-flow/47016500#47016500)