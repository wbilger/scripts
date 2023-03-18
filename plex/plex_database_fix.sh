#!/bin/bash
echo "** About to do a database repair on Plex DB."
echo -n "Is the db file already located in /home/wayne, press N to copy from tmp/plex/ (y/n)? "

old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg

cd /home/wayne
if echo "$answer" | grep -iq "^n" ;then
    echo "Copying db from /home/wayne/tmp/plex to /home/wayne/ ..."
    cp -a /home/wayne/tmp/plex/com.plexapp.plugins.library.db ./
    echo "Copy Complete!"
    echo
fi

echo -n "Perform a db repair on /home/wayne/com.plexapp.plugins.library.db, press N to perform and Integrity Check (y/n)? "
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg

if echo "$answer" | grep -iq "^n" ;then
    echo "Proceeding with Integrity Check on /home/wayne/com.plexapp.plugins.library.db."
    /usr/lib/plexmediaserver/Plex\ SQLite com.plexapp.plugins.library.db "DROP index 'index_title_sort_naturalsort'"
    /usr/lib/plexmediaserver/Plex\ SQLite com.plexapp.plugins.library.db "DELETE from schema_migrations where version='20180501000000'"
    /usr/lib/plexmediaserver/Plex\ SQLite com.plexapp.plugins.library.db "PRAGMA integrity_check"
    echo "Plex db Integrity Check complete."
else
    cp com.plexapp.plugins.library.db com.plexapp.plugins.library.db.original
    echo "Proceeding with repair db on /home/wayne/com.plexapp.plugins.library.db."
    /usr/lib/plexmediaserver/Plex\ SQLite com.plexapp.plugins.library.db "DROP index 'index_title_sort_naturalsort'"
    /usr/lib/plexmediaserver/Plex\ SQLite com.plexapp.plugins.library.db "DELETE from schema_migrations where version='20180501000000'"
    /usr/lib/plexmediaserver/Plex\ SQLite com.plexapp.plugins.library.db .dump > dump.sql
    rm com.plexapp.plugins.library.db
    /usr/lib/plexmediaserver/Plex\ SQLite com.plexapp.plugins.library.db < dump.sql
    rm dump.sql
    echo "Plex db repair complete."
fi
