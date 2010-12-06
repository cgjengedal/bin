#!/bin/bash
# Find those special characters in extensions (non-english comments, etc...)
pushd $1
for p in `find . -path '*/translations' -prune -o -type f -print | xargs file | grep -i text | cut -f1 -d:`
do
   res=`grep -n -P "[\x80-\xFF]" $p | awk '{sub(/^/, "\t");print}'`; 
   if [ ${#res} -ne 0 ]; then 
      echo $p; 
      grep -n -P "[\x80-\xFF]" $p | awk '{sub(/^/, "\t");print}'; 
   fi
done 
popd
