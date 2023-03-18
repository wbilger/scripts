#!/bin/bash
### ddparm read test on data1-8

echo "Testing data1 ..."
hdparm -tT /dev/disk/by-id/ata-ST4000VN008-2DR166_ZDHBSYAJ-part1              #data1
echo "Testing data2 ..."
hdparm -tT /dev/disk/by-id/ata-ST4000VN008-2DR166_ZDHBSYHF-part1              #data2
echo "Testing data3 ..."
hdparm -tT /dev/disk/by-id/ata-WDC_WD40EFAX-68JH4N1_WD-WX42D61ANHFF-part1     #data3
echo "Testing data4 ..."
hdparm -tT /dev/disk/by-id/ata-ST4000VN000-2AH166_ZDH01D9X-part1              #data4
echo "Testing data5 ..."
hdparm -tT /dev/disk/by-id/ata-WDC_WD40EFRX-68N32N0_WD-WCC7K7NPHHUV-part1     #data5
echo "Testing data6 ..."
hdparm -tT /dev/disk/by-id/ata-WDC_WD40EFRX-68N32N0_WD-WCC7K3HN32A9-part1     #data6
echo "Testing data7 ..."
hdparm -tT /dev/disk/by-id/ata-WDC_WD40EFAX-68JH4N1_WD-WX22D904D8HZ-part1     #data7
echo "Testing data8 ..."
hdparm -tT /dev/disk/by-id/ata-WDC_WD40EFRX-68N32N0_WD-WCC7K0AUHX5A-part1     #data8
echo "Done"

