#!/bin/sh

# Script refreshing the svn checked out eZ setup
pushd /home/cpg/workspace/ezpublish
rm -fr var/ezwebin_site/cache/*; rm -fr var/ezflow_site/cache/*
popd

