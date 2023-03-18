#!/bin/bash
SCRIPT=`realpath $0`
currentdir=`dirname $SCRIPT`
plex_url=$(cat $currentdir/.plexurl)
database_download() {
    cd /home/wayne
    wget $plex_url
    unzip database?*
    for file in databaseBackup*
        do mv "$file" "com.plexapp.plugins.library.db"
    done
    echo
}

echo -n "Downloading PMS DB and copying to backup location, remove triggers (y/n)? "
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg

if echo "$answer" | grep -iq "^y" ;then
    database_download
    echo "Removing Triggers..."
    #drop sqlite3 triggers used by plex in db
    $currentdir/plex_database_trigger_drop.sh
else
    database_download
    echo "Triggers not removed."
fi

rm database?*
mkdir -p /home/wayne/tmp/plex/
cd /home/wayne/tmp/plex
mv com.plexapp.plugins.library.db com.plexapp.plugins.library.db.1
mv /home/wayne/com.plexapp.plugins.library.db ./
echo "Download db and Copy Complete!"
echo
ls -lah
echo
echo "Done."
