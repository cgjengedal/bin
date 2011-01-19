#!/bin/sh

# Script adding symlinks to extensions 
pushd /home/cpg/workspace/ezpublish/extension
rm -fr ezflow ezwt ezwebin ezstarrating

ln -s ../../ezcomments ezcomments
ln -s ../../ezevent ezevent
ln -s ../../ezfind ezfind
ln -s ../../ezflow/packages/ezflow_extension/ezextension/ezflow ezflow
ln -s ../../ezie ezie 
ln -s ../../ezjscore ezjscore
ln -s ../../ezmultiupload ezmultiupload 
ln -s ../../ezodf ezodf
ln -s ../../ezoe ezoe
ln -s ../../ezstarrating/packages/ezstarrating_extension/ezextension/ezstarrating ezstarrating
ln -s ../../ezstyleeditor ezstyleeditor
ln -s ../../ezsurvey ezsurvey
ln -s ../../ezwebin/packages/ezwebin_extension/ezextension/ezwebin ezwebin
ln -s ../../ezwt/packages/ezwt_extension/ezextension/ezwt ezwt

popd

