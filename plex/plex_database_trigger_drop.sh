#!/bin/bash
#drop triggers used by plex
/usr/lib/plexmediaserver/Plex\ SQLite com.plexapp.plugins.library.db <<'END_SQL'
.timeout 2000
DROP TRIGGER IF EXISTS fts4_metadata_titles_before_update_icu;
DROP TRIGGER IF EXISTS fts4_metadata_titles_after_update_icu;
END_SQL
