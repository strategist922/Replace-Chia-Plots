#!/bin/bash
screen -d -m -S chia1 bash -c 'sleep 0h && while /home/<USER>/bin/replace-plots-pool.sh chia1 | tee -a /home/<USER>/chialogs/chia1.log; do :; done'
screen -d -m -S chia2 bash -c 'sleep 0h && while /home/<USER>/bin/replace-plots-pool.sh chia2 | tee -a /home/<USER>/chialogs/chia2.log; do :; done'
screen -d -m -S chia3 bash -c 'sleep 0h && while /home/<USER>/bin/replace-plots-pool.sh chia3 | tee -a /home/<USER>/chialogs/chia3.log; do :; done'
