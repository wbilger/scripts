#!/bin/bash
# detect_stale.sh
for mountpoint in $(grep nfs /etc/mtab | awk '{print $2}')
  do
    read -t1 < <(stat -t "$mountpoint" 2>&-)
    if [ -z "$REPLY" ] ; then
      echo $mountpoint" NFS mount stale. Removing..."
      umount -l $mountpoint
      if [ $mountpoint == "/backup" ] ; then
        mount -t nfs 192.168.1.11:/export/Data/Backup/htpc/plex /backup
        echo $mountpoint" remounted successfully."
      else
        mount -t nfs 192.168.1.11:/export/Media/${mountpoint##*/} $mountpoint
        echo $mountpoint" remounted successfully."
      fi  
    fi
done
