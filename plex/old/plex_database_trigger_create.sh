#!/bin/bash
#drop triggers used by plex
/usr/lib/plexmediaserver/Plex\ SQLite com.plexapp.plugins.library.db <<'END_SQL'
.timeout 2000
CREATE TRIGGER fts4_metadata_titles_before_update_icu BEFORE UPDATE ON metadata_items
BEGIN 
  DELETE FROM fts4_metadata_titles_icu WHERE docid=old.rowid; 
END;
CREATE TRIGGER fts4_metadata_titles_after_update_icu AFTER UPDATE ON metadata_items
BEGIN
  INSERT INTO fts4_metadata_titles_icu(docid, title, title_sort, original_title) VALUES(new.rowid, new.title, new.title_sort, new.original_title); 
END;
END_SQL
