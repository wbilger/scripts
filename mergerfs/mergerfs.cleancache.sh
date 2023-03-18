#!/bin/bash
#percentage full expiring
#Move the oldest file from the cache to the backing pool. Continue till below percentage threshold, or error
#NOTE: The arguments to these scripts include the cache drive. Not the pool with the cache drive. You could have data loss if the source is the cache pool.

if [ $# != 3 ]; then
  echo "usage: $0 <cache-drive> <backing-pool> <percentage>"
  exit 1
fi

CACHE="${1}"
BACKING="${2}"
PERCENTAGE=${3}
script_path=$(dirname "$0")
script_path_sub=".cleancache"
logfile=$script_path/$script_path_sub/"cleancache.log"
touch $logfile

if [ $(df --output=pcent "${CACHE}" | grep -v Use | cut -d'%' -f1) -gt ${PERCENTAGE} ]; then
  echo $(date)    "Begin cache drive clean..." >> $logfile
  $script_path/$script_path_sub/.clean_data.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_tmp.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_media_videos_movies-3d.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_media_books.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_media_music.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_media_pictures.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_media_videos_chritsmas.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_media_videos_chritsmas-4k.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_media_videos_movies-cartoons-4k.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_media_videos_movies-cartoons.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_media_videos_stand_up.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_media_videos_tv-nature.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_media_videos_documentaries.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_media_videos_documentaries-4k.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_media_videos_tv-reality.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_media_videos_tv-hgtv.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_media_videos_movies.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_media_videos_tv.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_media_videos_movies-4k.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_media_videos_tv-4k.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_media_videos.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  $script_path/$script_path_sub/.clean_media.sh "${CACHE}" "${BACKING}" "${PERCENTAGE}" "$logfile"
  echo $(date)    "Done" >> $logfile 
fi
