#!/bin/bash
### dd write/read test on data1-8
sudo cd /mnt/mergerfs/data/1/
echo "Testing all mergerfs data drives 1-8, write 1G file, clear cache,  then read back..."
echo "Testing data1 ..."
sudo sync; dd if=/dev/zero of=tempfile bs=1M count=1024; sync
sudo /sbin/sysctl -w vm.drop_caches=3
sudo dd if=tempfile of=/dev/null bs=1M count=1024
sudo rm tempfile
echo "Testing data2 ..."
cd ../2
sudo sync; dd if=/dev/zero of=tempfile bs=1M count=1024; sync
sudo /sbin/sysctl -w vm.drop_caches=3
sudo dd if=tempfile of=/dev/null bs=1M count=1024
sudo rm tempfile
echo "Testing data3 ..."
cd ../3
sudo sync; dd if=/dev/zero of=tempfile bs=1M count=1024; sync
sudo /sbin/sysctl -w vm.drop_caches=3
sudo dd if=tempfile of=/dev/null bs=1M count=1024
sudo rm tempfile
echo "Testing data4 ..."
cd ../4
sudo sync; dd if=/dev/zero of=tempfile bs=1M count=1024; sync
sudo /sbin/sysctl -w vm.drop_caches=3
sudo dd if=tempfile of=/dev/null bs=1M count=1024
sudo rm tempfile
echo "Testing data5 ..."
cd ../5
sudo sync; dd if=/dev/zero of=tempfile bs=1M count=1024; sync
sudo /sbin/sysctl -w vm.drop_caches=3
sudo dd if=tempfile of=/dev/null bs=1M count=1024
sudo rm tempfile
echo "Testing data6 ..."
cd ../6
sudo sync; dd if=/dev/zero of=tempfile bs=1M count=1024; sync
sudo /sbin/sysctl -w vm.drop_caches=3
sudo dd if=tempfile of=/dev/null bs=1M count=1024
sudo rm tempfile
hdparm -tT /dev/disk/by-id/ata-WDC_WD40EFRX-68N32N0_WD-WCC7K3HN32A9-part1     #data6
echo "Testing data7 ..."
cd ../7
sudo sync; dd if=/dev/zero of=tempfile bs=1M count=1024; sync
sudo /sbin/sysctl -w vm.drop_caches=3
sudo dd if=tempfile of=/dev/null bs=1M count=1024
sudo rm tempfile
hdparm -tT /dev/disk/by-id/ata-WDC_WD40EFAX-68JH4N1_WD-WX22D904D8HZ-part1     #data7
echo "Testing data8 ..."
cd ../8
sudo sync; dd if=/dev/zero of=tempfile bs=1M count=1024; sync
sudo /sbin/sysctl -w vm.drop_caches=3
sudo dd if=tempfile of=/dev/null bs=1M count=1024
sudo rm tempfile
echo "Done"

