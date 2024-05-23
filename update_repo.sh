#!/bin/bash

# 定义远程仓库和分支
UPSTREAM_REMOTE="origin"
UPSTREAM_BRANCH="openwrt-23.05"
CUSTOM_BRANCH="custom"
DESTINATION_REMOTE="wang1zhen"

# 切换到本地openwrt-23.05分支并更新
git checkout $UPSTREAM_BRANCH
git pull $UPSTREAM_REMOTE $UPSTREAM_BRANCH

# 切换到定制化分支
git checkout $CUSTOM_BRANCH

# 删除已有的custom-base标签（如果存在）
git tag -d custom-base

# 标记定制化提交的起点
git tag custom-base $(git merge-base $UPSTREAM_BRANCH $CUSTOM_BRANCH)

# 从本地的openwrt-23.05分支进行rebase
git rebase $UPSTREAM_BRANCH

# 重新应用定制化提交到最新的openwrt-23.05之后
git rebase --onto $UPSTREAM_BRANCH custom-base

# 强制推送到远程仓库
git push -f $DESTINATION_REMOTE $CUSTOM_BRANCH
