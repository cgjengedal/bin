#!/bin/bash

# This script semi-automates the process of updating datafiles for ezwebin and ezflow in the test system

DOCROOT='/home/cpg/workspace/ezpublish'
PACKAGEREPOSITORY='/home/cpg/tmp/ez_packages'
PACKAGEURL='http://packages.ez.no/ezpublish/4.5/4.5.0beta1/'

function removeOldPackages
{
    echo Cleaning $DOCROOT/var/storage/packages/
    if [ -d $DOCROOT ]; then
        rm -Rf $DOCROOT/var/storage/packages/*
    fi
    echo Cleaning $PACKAGEREPOSITORY
    if [ -d $PACKAGEREPOSITORY ]; then
        rm -Rf $PACKAGEREPOSITORY/*
    fi
}

function fixPermissions
{
    # Fix permissions the wizard requires/proposes
    cd $DOCROOT
    chmod -R a+rwx design settings settings/siteaccess settings/siteaccess/admin var var/cache var/cache/codepages var/cache/ini var/cache/template var/cache/texttoimage var/log var/storage
    cd - > /dev/null
    
    # Fix the permissions for the packages
    cd ${DOCROOT}/var/storage
    chmod a+rwx -R packages
    cd - > /dev/null
}

function touchFiles
{
    # Touching files in order to avoid apc problems
    find  docroot -exec touch '{}' ';'
}

function extracteZWebinPackages
{
    local startDir
    local packageName
    startDir=`pwd`
    mkdir -p ${DOCROOT}/var/storage/packages/eZ-systems
    cd ${DOCROOT}/var/storage/packages/eZ-systems
    wget -O ${PACKAGEREPOSITORY}/index.xml ${PACKAGEURL}/index.xml
    
    for i in ezwebin_site.ezpkg ezwt_extension.ezpkg ezgmaplocation_extension.ezpkg ezstarrating_extension.ezpkg ezwebin_classes.ezpkg ezwebin_democontent.ezpkg ezwebin_design_blue.ezpkg ezwebin_design_cleangray.ezpkg ezwebin_design_gray.ezpkg ezwebin_extension.ezpkg ezwebin_banners.ezpkg; do
        # Download package
        wget -O ${PACKAGEREPOSITORY}/$i ${PACKAGEURL}/$i 
        # cut of .ezpk from filename
        packageName=`echo $i|cut -f 1 -d "."`
        mkdir $packageName
        cd $packageName
        tar -xzf ${PACKAGEREPOSITORY}/$i
        cd - > /dev/null
    done
    cd $startDir
}

function extracteZFlowPackages
{
    local startDir
    local packageName
    startDir=`pwd`
    mkdir -p ${DOCROOT}/var/storage/packages/eZ-systems
    cd ${DOCROOT}/var/storage/packages/eZ-systems
    wget -O ${PACKAGEREPOSITORY}/index.xml ${PACKAGEURL}/index.xml    
    
    for i in ezflow_site.ezpkg ezwt_extension.ezpkg ezgmaplocation_extension.ezpkg ezstarrating_extension.ezpkg ezwebin_extension.ezpkg ezflow_classes.ezpkg ezflow_democontent.ezpkg ezflow_design.ezpkg ezflow_extension.ezpkg; do
        # Download package
        wget -O ${PACKAGEREPOSITORY}/$i ${PACKAGEURL}/$i 
        # cut of .ezpk from filename
        packageName=`echo $i|cut -f 1 -d "."`
        mkdir $packageName
        cd $packageName
        tar -xzf ${PACKAGEREPOSITORY}/$i
        cd - > /dev/null
    done
    cd $startDir
}

function doeZWebin
{
    echo Installing ezwebin
    extracteZWebinPackages
}

function doeZFlow
{
    echo Installing ezflow
    extracteZFlowPackages
}

removeOldPackages
#doeZWebin
doeZFlow
#fixPermissions
#touchFiles

