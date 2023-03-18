#!/bin/bash
#balance from /media/ up so anything below (specifically PBS datastore NFS mount) do not move -- as (-E *datastore* doesn't seem to work)
/usr/local/bin/mergerfs.balance /mnt/mergerfs/backing/media/ -p 1 -e "*aquota*" -e "snapraid*" -E *download* -E *zRecyclebin* -s 200M
