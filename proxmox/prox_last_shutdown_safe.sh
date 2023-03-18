#!/bin/bash
B="1"
touch data_file
echo $(($(grep -nr "$(cat  /var/log/kern.log | grep "$(date -d $(who -b | awk '{printf $3}') '+%b %-d')" | grep imklog   | grep $(cat  /var/log/kern.log | grep "$(date -d $(who -b | awk '{printf $3}') '+%b %-d')" | grep imklog | cut -d' ' -f3 | sort -k1 -r | sort --unique --stable -k2,3))" /var/log/kern.log | awk '{printf $1}' | grep -oE "[[:digit:]]{1,}")-$B))  >  data_file

if [[

($(sed -n $(cat data_file)p /var/log/kern.log | awk '{print $6}') == "Kernel") && 
($(sed -n $(cat data_file)p /var/log/kern.log | awk '{print $7}') == "logging") &&
($(sed -n $(cat data_file)p /var/log/kern.log | awk '{print $8}') == "(proc)") &&
($(sed -n $(cat data_file)p /var/log/kern.log | awk '{print $9}') == "stopped.") 

]]; then
  echo Last Shutdown-proper
else
   echo Last Shutdown_not proper 
fi
rm data_file
