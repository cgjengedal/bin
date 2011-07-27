#!/bin/bash
pushd $1

# Find those special characters in extensions (non-english comments, etc...)
echo -e '\nText files with non-ascii characters (ie non-english comments)'
for p in `find . -path '*/translations' -prune -o -type f -print | xargs file | grep -i text | cut -f1 -d:`
do
   res=`grep -n -P "[\x80-\xFF]" $p`; 
   if [ ${#res} -ne 0 ]; then 
      echo $p; 
      echo -e "\t" $res; 
   fi
done 


# Disabled caching
echo -e '\nTemplates with disabled caching'
for f in `find . -iname '*.tpl'`
do
   res=`grep -irn cache_ttl $f`; 
   if [ ${#res} -ne 0 ]; then 
      echo $f; 
      echo -e "\t" $res; 
   fi
done 

# All tpl and php files
files=`find -name "*.php" -o -name "*.tpl"`

# Find TODOs and FIXMEs: 
echo -e '\nTODOs or FIXMEs'
for t in $files 
do
   res=`grep -in -E 'todo|fixme' $t`
   if [ ${#res} -ne 0 ]; then 
      echo $t; 
      echo "${res}"
#      for r in "${res}"
#      do 
#         echo -e "\t" $r;
#      done
   fi
done
# Filehandlers: 
echo -e '\nPHP filehandlers'
for x in $files 
do
   res=`grep -n -E 'fopen|fputs|fwrite|fclose|file_get_contents|file_put_contents|splfileinfo|splfileobject|file_exists' $x`
   if [ ${#res} -ne 0 ]; then 
      echo $x; 
      echo "${res}"
   fi
done


# 20 biggest files: 
echo -e '\n10 biggest php and tpl files in number of lines'
res=`wc -l $files | sort -n | tail -n 10`
echo "${res}"

popd
