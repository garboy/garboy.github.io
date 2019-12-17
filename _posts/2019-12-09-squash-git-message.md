---
layout: post
title:  "砸扁，并提交一个干净的Git Commit历史"
date:   2019-12-09 09:38:18 +0800
categories: git flows
---

不管是 GitFlow 还是 GitHub Flow，都不可避免的会碰到编码的最佳实践要求尽可能小、尽可能频繁的提交代码，可代码提交频繁了，到时候万一需要整体撤销这些改动，如果没有做好 [Feature Flag](https://www.martinfowler.com/articles/feature-toggles.html)，不管是 revert 还是 cherry-pick，都不容易，因为提交历史都太零碎。  
其实这时候有3种解决办法，基本思路都是 squash。不同的地方在于，一是用 git rebase 的 squash，二是用 git merge --squash，两个命令不同的地方见下面。  

### Rebase & Squash

通过 git rebase 来 squash 其实就是先通过 git 历史，确定需要合并哪几个 commit，然后通过 `git rebase -i [SHA]`或者`git rebase -i HEAD~[NUMBER OF COMMITS]` 来合并多次提交历史。  
如这样的一个例子，b.py文件有三次修改记录，我们想把这三行提交记录合并为一次提交。
git log 如下，

``` shell

$ git log --oneline --graph --decorate
* dfc0295 (HEAD -> master) b.py Modification 2
* ce9e582 b.py Modification 1
* 7a62538 Added b.py
* 952244a Added a.py
```

然后我们通过 git rebase 来合并提交。  

`git rebase -i HEAD~3`

上述命令会打开一个文本界面，用于指定rebase 的具体命令。  

``` shell

pick 7a62538 Added b.py
pick ce9e582 b.py Modification 1
pick dfc0295 b.py Modification 2
 
# Rebase 952244a..dfc0295 onto 952244a (3 command(s))
#
# Commands:
# p, pick = use commit
# r, reword = use commit, but edit the commit message
# e, edit = use commit, but stop for amending
# s, squash = use commit, but meld into previous commit
# f, fixup = like "squash", but discard this commit's log message
# x, exec = run command (the rest of the line) using shell
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
# Note that empty commits are commented out
~

```

像文件里面提到的那些 rebase 命令，我们可以用第一个 commit 的 message，合并后面两个提交，也就是 pick 第一个，squash 后面两个。  
修订后的命令如下  

```shell

pick 7a62538 Added b.py
squash ce9e582 b.py Modification 1
squash dfc0295 b.py Modification 2
 
# Rebase 952244a..dfc0295 onto 952244a (3 command(s))
#
# Commands:
# p, pick = use commit
# r, reword = use commit, but edit the commit message
# e, edit = use commit, but stop for amending
# s, squash = use commit, but meld into previous commit
# f, fixup = like "squash", but discard this commit's log message
# x, exec = run command (the rest of the line) using shell
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
# Note that empty commits are commented out
```

保存并关闭(:wq)上述文档后，会有下面一屏的内容提示，  

``` shell

# This is a combination of 3 commits.
# The first commit's message is:
Added b.py
 
# This is the 2nd commit message:
 
b.py Modification 1
 
# This is the 3rd commit message:
 
b.py Modification 2
 
# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# Date:      Fri Mar 30 21:09:43 2018 -0700
#
# rebase in progress; onto 952244a
# You are currently editing a commit while rebasing branch 'master' on '952244a'.
#
# Changes to be committed:
#       new file:   b.py
#
```

保存关闭后，你会看到下面内容。  

``` shell

$ git rebase -i HEAD~3
[detached HEAD 0798991] Added b.py
Date: Fri Mar 30 21:09:43 2018 -0700
1 file changed, 1 insertion(+)
create mode 100644 b.py
Successfully rebased and updated refs/heads/master.
```

git 历史也会变成下面这样。  

``` shell

$ git log --oneline --graph --decorate
* 0798991 (HEAD -> master) Added b.py
* 952244a Added a.py
```

这样的方式有个不太方便的地方，这些合并，会变更分支，而不是在原始分支里面合并。

### Merge & Squash

``` shell

git commit -am "Message describing all squashed commits"
git branch -m mybranchname mybranchname_unsquashed
git branch -m mybranchname

# Optional cleanup:
git branch -D mybranchname_unsquashed

# If squashing already-pushed commits...
git push -f
```

setup and push to origin  
`git push --set-upstream origin add-description-on-readme`  

### Squash in Merge Rquest

Gitlab 8之后，再合并 Merge Request 请求的时候，可以选择"squash ..."，一下就搞定了！
![Sqush in Gitlab MR](https://user-images.githubusercontent.com/1076902/70955008-4d33f000-20aa-11ea-82c6-7e3d430192fa.png)
