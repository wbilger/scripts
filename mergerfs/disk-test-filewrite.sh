#!/bin/bash
### test quick read/write on data1-8, parity1-2

touch /mnt/mergerfs/data/1/media/hd-test.tmp
touch /mnt/mergerfs/data/2/media/hd-test.tmp
touch /mnt/mergerfs/data/3/media/hd-test.tmp
touch /mnt/mergerfs/data/4/media/hd-test.tmp
touch /mnt/mergerfs/data/5/media/hd-test.tmp
touch /mnt/mergerfs/data/6/media/hd-test.tmp
touch /mnt/mergerfs/data/7/media/hd-test.tmp
touch /mnt/mergerfs/data/8/media/hd-test.tmp
sudo touch /mnt/mergerfs/parity/1/hd-test.tmp
sudo touch /mnt/mergerfs/parity/2/hd-test.tmp

ls /mnt/mergerfs/data/*/media/hd-test.tmp
ls /mnt/mergerfs/parity/*/

rm /mnt/mergerfs/data/*/media/hd-test.tmp
sudo rm /mnt/mergerfs/parity/*/hd-test.tmp

echo "done... OK if no errors"
