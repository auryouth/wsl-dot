#!/bin/bash

# To Do: Sync latest packages

# Cd to the parent directory of script
cd "$(dirname "$0")" || exit 1

# first sync all the packages
paru -Qq >../pkglist_all_newest.txt

# then sync all the explicitly installed packages

file=../pkglist_newest.txt

# define old pkglist file
if [ -e $file ]; then
	mv $file ../pkglist_old.txt
	pkglist_old=../pkglist_old.txt
fi

# get all the newest explicitly installed packages
paru -Qqe >../pkglist_newest.txt

if [ $? -ne 0 ]; then
	echo "Failed , please try again"
	exit
else
	DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
	echo "************************************"
	echo "Successfully Sync Installed Packages"
	echo "************************************"
fi

# define newest pkglist file
pkglist_newest=../pkglist_newest.txt

# define add and old file
pkglist_add=../pkglist_add.txt
pkglist_remove=../pkglist_remove.txt

# compare
grep -Fxvf $pkglist_old $pkglist_newest >$pkglist_add
grep -Fxvf $pkglist_newest $pkglist_old >$pkglist_remove

# remove the old one
rm -rf $pkglist_old

# list code extensions
code --list-extensions >../code_extensions.txt
