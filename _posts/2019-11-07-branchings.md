# Git Flow, Github Flow and Gitlab Flows
## Considerations
1. release model. Release Train or Deploy fast, Deploy often.
2. keep master as close as production.

## Branching Types
### Git flow
![Git-Flow Diagram](https://nvie.com/img/git-model@2x.png)
[page](https://nvie.com/posts/a-successful-git-branching-model/)

### Gitlab Flow
[page](https://about.gitlab.com/blog/2014/09/29/gitlab-flow/)
3 types of gitlab flow
#### Production branch with GitLab flow
![GitLab Flow - Production Branch](https://about.gitlab.com/images/git_flow/production_branch.png)  

#### Environment branches with GitLab flow
![Environtment branches](https://about.gitlab.com/images/git_flow/environment_branches.png)

#### Release branches with GitLab flow
![Release branches](https://about.gitlab.com/images/git_flow/release_branches.png)

### GitHub flow
![GitHub Flow](https://user-gold-cdn.xitu.io/2018/12/3/167738fe00a73a92?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)
. Anything in the master branch is deployable
. To work on something new, create a descriptively named branch off of master (ie: new-oauth2-scopes)
. Commit to that branch locally and regularly push your work to the same named branch on the server
. When you need feedback or help, or you think the branch is ready for merging, open a pull request
. After someone else has reviewed and signed off on the feature, you can merge it into master
. Once it is merged and pushed to ¡®master¡¯, you can and should deploy immediately

#1 'master' is stable and safe for produciton, always. Thus you need to keep it tested and approved. If you break it, you will face to social pressure that comes from other team memebers.
#2 create a descriptively branch for either feature or bug fix kind of work. This is nice when you browse the branch page, all the on-going works will be clear at a glance.
#3 fire off a pull request at anytime, not only when you think it's ready. Remember you could commit unlimited times for a same PR, and each commit will fire-off CI process.
#4 Merge only PR is reviewed, and go-live it immediately.

##### Pros. & Cons.
*Pros.*
1. Simple and effective.
2. Mergeing often, deploy often, Minimize unreleased code, inline with lean and continuous delivery best practices.

*Cons*
1. not suitable for those fixed window and release train model. Such as iOS apps, you have to wait Apple review and approve your artifacts, then you go live. That will leave a gap between code in master and code in market.