#!/bin/bash

pushd "$1" > /dev/null
PTH=`pwd`

BASENAME='/bin/basename'
GIT_BIN='/usr/bin/git'
SVN_BIN='/usr/bin/svn'

SVN_FOLDER=".svn"
GIT_FOLDER=".git"
SKIP_REPO=".skip"

for REPOSITORY in "$PTH"/*
do
    if [[ -d $REPOSITORY ]]
    then
        
        if [[ -f $REPOSITORY/$SKIP_REPO ]]
        then
            echo -e "Ignoring `$BASENAME $REPOSITORY`...\n"
            continue;
        fi
        
        pushd "$REPOSITORY" > /dev/null
        
        echo -n Checking status on `$BASENAME $REPOSITORY`...
        
        if [[ -d $REPOSITORY/$SVN_FOLDER ]]
        then
            echo " [Subversion]"
            
            $SVN_BIN status
        fi
        
        if [[ -d $REPOSITORY/$GIT_FOLDER ]]
        then
            echo " [Git]"
            
            $GIT_BIN status
        fi
        
        echo "";
        popd > /dev/null
    fi
done

popd > /dev/null

