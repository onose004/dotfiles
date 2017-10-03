#!/bin/sh
#-------------------------------------------------------------------------------
# git.sh
# git に関する設定
#-------------------------------------------------------------------------------

echo "user name: \c"
read USER_NAME
git config --global user.name "${USER_NAME}"
echo "user email: \c"
read USER_EMAIL
git config --global user.email "${USER_EMAIL}"
echo user.name=`git config --global user.name`
echo user.email=`git config --global user.email`
