#!/bin/bash
FILE=/home/wayne/mem_snapshots-$(date +"%Y%m%d-%H%M%S").log
while true
do
echo $(date +"%D %T") >> $FILE
echo "Memory Usage PLEX:   $(ps -p $(pidof "Plex Media Server") -o drs=)"  >> $FILE
echo "Memory Usage-free:   $(free | awk '/Mem/{printf("RAM Usage: %.2f\n"), $3/$2*100}'| awk '{print $3}')" >> $FILE
echo "Top Processes:" >> $FILE
echo "" >> $FILE
echo "$(top -b -o +%MEM | head -n 12)" >> $FILE
echo "" >> $FILE
echo "Top Processes-ps:" >> $FILE
echo "" >> $FILE
echo "$(ps -eo pid,ppid,%mem,%cpu,cmd --sort=-%mem | head)" >> $FILE
echo "" >> $FILE
echo "***************************************************************************************************************" >> $FILE
sleep 17s
done
