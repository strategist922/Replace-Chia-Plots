#!/bin/bash

CHIABIN=/home/<USER>/chia-blockchain
DEST=/mnt/chiafarm
TEMP=/mnt/ssd/$1
TEMP2=/mnt/ssd
FARMKEY=<Farmer public key>
P2SKEY=<P2 singleton address (pool contract address for plotting)>
AVAILSPACE=$(df --output=avail $DEST | tail -1)
# required space 210G
REQUIREDSPACE=220200960

if (( $AVAILSPACE < $REQUIREDSPACE )); then
  echo "$AVAILSPACE less than $REQUIREDSPACE"
  echo "there is not enough free space on $DEST, exiting"
  exit 1
else
  echo "$AVAILSPACE greater than $REQUIREDSPACE"
  echo "there is enough free space on $DEST, proceeding"
fi

OLDPLOT=$(ls -rt $DEST | grep plot-k32-2021-[0][3-5] | head -1)
if test -f $DEST/$OLDPLOT; then
  rm $DEST/$OLDPLOT && echo "removed $DEST/$OLDPLOT"
else
  echo "no old plots left, proceeding"
fi

cd $CHIABIN \
&& . ./activate \
&& chia plots create -f $FARMKEY -c $P2SKEY -t $TEMP -2 $TEMP2 -d $DEST || exit 1
