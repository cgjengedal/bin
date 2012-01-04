#!/bin/bash

pushd "$1" > /dev/null

for f in `find . -type f -name '*.emlx'`
do
    url=''
    subject=`grep Subject ${f} | cut -f3- -d ' '`
    dat=`grep 'Date:' ${f} | cut -f2- -d ':'`
    sitepackage=`grep 'Site package' ${f} | cut -f2- -d '-'`
    url=`grep 'Admin URL' ${f} | cut -f2- -d '-'`
    ezversion=`grep '^User-Agent' ${f} | cut -f5- -d ' '`
    phpversion=`sed -n '/PHP info/{n;p;}' ${f} | cut -f2- -d '-'`
    webserver=`sed -n '/Web server info/{n;p;}' ${f} | cut -f2- -d '-'`
    region=`sed -n '/Regional info/{n;p;}' ${f} | cut -f2- -d '-'`
    dbdriver=`sed -n '/Database info/{n;n;p;}' ${f} | cut -f2- -d '-'`
    cpu=`grep 'CPU Type' ${f} | cut -f2- -d '-'`
    mem=`grep 'Memory Size' ${f} | cut -f2- -d '-'`
    if [ -n "$url" ]; then
        echo $url';'$sitepackage';'$ezversion';'$phpversion';'$webserver';'$cpu';'$mem';'$dbdriver';'$region';'$dat
    fi
done

popd > /dev/null

