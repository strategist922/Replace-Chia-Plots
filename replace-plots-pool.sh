#!/bin/bash

chia_dir=/home/james/chia-blockchain
dest=/mnt/chiafarm
temp=/mnt/ssd/$1
temp2=/mnt/ssd
farm_key=b941fd63b49fbd43a822842bed002e341a3653ab4290a09803d6a160235fca970e7027495ad67a8f8b3377495617dc8a
p2s_key=xch1tx0fnx0qmn744l8du7v7yqze3wu49ryelk2lgq7swfaa8wwr7lgs6xpwwd
avail_space=$(df --output=avail $dest | tail -1)
# required space 110G
required_space=115343400
free_space_threshold=230686720

if (( $avail_space < $required_space )); then
  echo "$avail_space less than $required_space"
  echo "there is not enough free space on $dest, exiting"
  exit 1
else
  echo "$avail_space greater than $required_space"
  echo "there is enough free space on $dest, proceeding"
fi

if (( $avail_space > $free_space_threshold )); then
  echo "$avail_space greater than $free_space_threshold"
  echo "More then 220G free, not going to remove old plot"
else
  old_plot=$(ls -rt $dest | grep plot-k32-2021-[0][3-5] | head -1)
  if test -f $dest/$old_plot; then
    rm $dest/$old_plot && echo "removed $dest/$old_plot"
  else
    echo "no old plots left, proceeding"
  fi
fi

cd $chia_dir \
&& . ./activate \
&& chia plots create -f $farm_key -c $p2s_key -t $temp -2 $temp2 -d $dest || exit 1
