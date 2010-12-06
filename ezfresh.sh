#!/bin/sh

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Pear update
pear update-channels
pear upgrade-all

# Script refreshing the svn checked out eZ setup
pushd /home/cpg/workspace/ezpublish
sudo -u cpg php bin/php/ezcache.php --clear-all --purge
php bin/php/ezpgenerateautoloads.php -e -p
popd

# Restart apache
service httpd restart

