#!/bin/bash
#percentage full expiring
#Move the oldest file from the cache to the backing pool. Continue till below percentage threshold, or error
#NOTE: The arguments to these scripts include the cache drive. Not the pool with the cache drive. You could have data loss if the source is the cache pool.

if [ $# != 4 ]; then
  echo "usage: $0 <cache-drive> <backing-pool> <percentage> <logfile>"
  exit 1
fi

CACHE="${1}"
BACKING="${2}"
PERCENTAGE=${3}
LOGFILE="${4}"
script_path=$(dirname "$0")

set -o errexit

while [ $(df --output=pcent "${CACHE}" | grep -v Use | cut -d'%' -f1) -gt ${PERCENTAGE} ]
do
    FILE=$(find "${CACHE}/media/videos/TV-Reality" -type f -printf '%A@ %P\n' | \
                  sort | \
                  head -n 1 | \
                  cut -d' ' -f2-)
    test -n "${FILE}"
    echo rsync "${CACHE}/media/videos/TV-Reality/./${FILE}" "${BACKING}/media/videos/TV-Reality" >> ${LOGFILE}
    rsync -axqHAXWESR --preallocate --remove-source-files "${CACHE}/media/videos/TV-Reality/./${FILE}" "${BACKING}/media/videos/TV-Reality/" 
done
