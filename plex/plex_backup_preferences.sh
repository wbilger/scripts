#!/bin/bash
mkdir -p /backup/preferences
cd /backup/preferences
mv Preferences.xml.3 Preferences.xml.4
mv Preferences.xml.2 Preferences.xml.3
mv Preferences.xml.1 Preferences.xml.2
mv Preferences.xml Preferences.xml.1
cp -a  "/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Preferences.xml" ./
cd ..
chown -R plex:plex preferences
chmod -R 755 preferences
