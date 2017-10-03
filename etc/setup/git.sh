#!/bin/sh
#-------------------------------------------------------------------------------
# git.sh
# git に関する設定
#-------------------------------------------------------------------------------

echo Current Settings
echo user.name=`git config --global user.name`
echo user.email=`git config --global user.email`

while true; do
  read -p 'Change settings？[y/n] ' yn
  case $yn in
    [Yy] ) break;;
    [Nn] ) exit 0 ;;
    * ) echo "Enter [y/n]";;
  esac
done

echo "user name: \c"
read USER_NAME
git config --global user.name "${USER_NAME}"
echo "user email: \c"
read USER_EMAIL
git config --global user.email "${USER_EMAIL}"

echo Changed Settings
echo user.name=`git config --global user.name`
echo user.email=`git config --global user.email`
