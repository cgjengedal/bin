#!/bin/sh

# Script for checking your own local network.
# Simulates broadcast ping which does not work too well.
# Sends ordinary ping to all addresses
# 
# Author: Jon Haugsand <jonhaug at ifi.uio.no>
# Date:   2004-02-09
#
# For free use, but I am interested in any extentions or
# program that makes my script superfluous

# Network to test.  Should be read as parameters.
NETWORK="10.0.0."
LOWADDR="1"
HIADDR="150"
PING="/bin/ping"

# Reads in /ets/hosts for convenience
# Does not work wit DNS though
while read a b; do
  if [ "${a%.*}." = "$NETWORK" ]; then
     ttt[${a##*.}]=$b
  fi 
done < /etc/hosts

# Loops through all addresses
for ((i=$LOWADDR;i<=$HIADDR;i++)); do
  ADDR=$NETWORK$i

#Subshell start:
 ( res=$($PING -w 5 -c 1 -n $ADDR | grep -E "100%|time=" | head -1 | awk '{print $(NF-1)}')
  if [ "$res" = "time" ]; then
#    echo "<none>"
     :
  else
  if [ "${ttt[$i]}" = "" ]; then
    nvn="()"
  else
    nvn="(${ttt[$i]})"
  fi
  echo -n "$ADDR $nvn:"
    echo $res
  fi ) &
#Subshell end

done
# Wait for all forked processes to end
wait

