#!/bin/bash
SQLite="/usr/lib/plexmediaserver/Plex SQLite"
plex_db="/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-in Support/Databases/com.plexapp.plugins.library.db"


echo -n "Enter title (use % for wildcard): "
read title
if [ "$title" = "" ]; then
    echo "No title entered"
    exit 1
fi
title_entered="$title"
echo -n "Enter library Section ID ie. Movie (1) or TV Show (2), 'a' for all: "
read library
if [ $library != "a" ]; then library_filter=" and library_section_id = $library"
fi
count=$(sudo -u plex "${SQLite}" "${plex_db}" "select count(*) from metadata_items where title LIKE '$title'$library_filter")
count_orginal=$count
offset=0
echo 
while [ $offset -lt $count ]
do
    echo -n "id|parent_id|library_section_id|year|title  = "
    sudo -u plex "${SQLite}" "${plex_db}" "select id, parent_id, library_section_id, year, title from metadata_items where title LIKE '$title'$library_filter LIMIT $offset, 1"
    echo -n "summary = "
    sudo -u plex "${SQLite}" "${plex_db}" "select summary from metadata_items where title LIKE '$title'$library_filter LIMIT $offset, 1"
    echo -n "originally_available_at = "
    echo -n $(date -d "@$(sudo -u plex "${SQLite}" "${plex_db}" "select originally_available_at from metadata_items where title LIKE '$title'$library_filter LIMIT $offset, 1")")
    echo -n "  >>>>  add_at = "
    date -d "@$(sudo -u plex "${SQLite}" "${plex_db}" "select added_at from metadata_items where title LIKE '$title'$library_filter LIMIT $offset, 1")"
    offset=$(($offset+1))
    echo
done

#now copy original_available_at to added_at
echo "*****  Now using the above information you can update added_at with a new date.  *****"
echo
read -e -p "Enter metadata id (or start with 'p' for parent_id ie. pxxxxxxx): " -i $(sudo -u plex "${SQLite}" "${plex_db}" "select id from metadata_items where title LIKE '$title_entered'$library_filter LIMIT $(($offset-1)), 1") id
search_by="id"
if [ "${id:0:1}" = "p" ]; then search_by="parent_id"
fi

if [ -z $id ]||[ $(sudo -u plex "${SQLite}" "${plex_db}" "select count(*) from metadata_items where $search_by = $id") = 0 ]; then 
    echo "Invalid id, no media found."
    exit 1
fi
echo
echo -n "id|parent_id|library_section_id|year|title  = "
sudo -u plex "${SQLite}" "${plex_db}" "select id, parent_id, library_section_id, year, title from metadata_items where $search_by = $id"
echo -n "summary = "
sudo -u plex "${SQLite}" "${plex_db}" "select summary from metadata_items where $search_by = $id"
echo -n "originally_available_at = "
echo -n $(date -d "@$(sudo -u plex "${SQLite}" "${plex_db}" "select originally_available_at from metadata_items where $search_by = $id")")
added_at=$(date -d "@$(sudo -u plex "${SQLite}" "${plex_db}" "select added_at from metadata_items where $search_by = $id")")
echo "  >>>>  add_at = $added_at"
echo
echo -n "About to copy originally_available_at (or user input 'i') to added_at for the above metadata item by $search_by, continue (y/n/i)? "
old_stty_cfg=$(stty -g) 
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[iny]' ;do true ;done ) 
stty $old_stty_cfg
echo
echo
if echo "$answer" | grep -iq "^y" ;then
    sudo -u plex "${SQLite}" "${plex_db}" "update metadata_items  set added_at = originally_available_at where $search_by = '$id'"
    sudo -u plex "${SQLite}" "${plex_db}" "select * from metadata_items where $search_by = '$id'"
elif echo "$answer" | grep -iq "^i" ;then
    added_at=$(date -d "$added_at" "+%Y/%m/%d %H:%M:%S")
    read -e -p "Enter a new added_at: " -i "$added_at" added_at
    added_at=$(date -d "$added_at" +"%s")
    sudo -u plex "${SQLite}" "${plex_db}" "update metadata_items  set added_at = $added_at where $search_by = '$id'"
else
    echo
    echo "** No Changes Made **"
    echo
    exit 1
fi
echo
echo "title = $(sudo -u plex "${SQLite}" "${plex_db}" "select title from metadata_items where $search_by = '$id'")"
echo -n "new added_at = "
date -d "@$(sudo -u plex "${SQLite}" "${plex_db}" "select added_at from metadata_items where $search_by = '$id'")"
