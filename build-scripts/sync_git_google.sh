#!/bin/bash

# First time add entries to .git/config (!) and add .netrc file
# [remote "google"]
#	url = https://code.google.com/p/osmand/
#   fetch = +refs/heads/*:refs/remotes/google/*
git fetch origin -p
git fetch google

# Delete old branches
for f in `git for-each-ref --format='%(refname)' | grep 'refs/remotes/google'`
do 
 Branch=`echo $f | cut -d '/' -f 4`
 if [[ -z `git show-ref refs/remotes/origin/$Branch` ]]; then
	echo git push google :$Branch
	git push google :$Branch
 fi	 
done

# Delete old branches
for f in `git for-each-ref --format='%(refname)' | grep 'refs/remotes/origin'`
do 
 Branch=`echo $f | cut -d '/' -f 4`
 echo git push google origin/$Branch:refs/heads/$Branch
 git push google origin/$Branch:refs/heads/$Branch --force
done

echo "Synchronization is ok"
