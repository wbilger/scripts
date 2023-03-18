#!/bin/bash

# chmod files
# finds files which are not 644 permission and fixes them
find /mnt/mergerfs/union/media/videos        -type f \! -perm 644 -exec chmod 644 {} \; -print
find /mnt/mergerfs/union/media/music         -type f \! -perm 644 -exec chmod 644 {} \; -print
#find /mnt/mergerfs/union/media/books         -type f \! -perm 644 -exec chmod 644 {} \; -print
#find /mnt/mergerfs/union/media/pictures      -type f \! -perm 644 -exec chmod 644 {} \; -print

# chmod directories
# finds directories which are not 755 and fixes them
find /mnt/mergerfs/union/media/videos        -type d \! -perm 755 -exec chmod 755 {} \; -print
find /mnt/mergerfs/union/media/music         -type d \! -perm 755 -exec chmod 755 {} \; -print
#find /mnt/mergerfs/union/media/books         -type d \! -perm 755 -exec chmod 755 {} \; -print
#find /mnt/mergerfs/union/media/pictures      -type d \! -perm 755 -exec chmod 755 {} \; -print

# chown everything
# finds anything not owned by plex and fixes them
find /mnt/mergerfs/union/media/videos        \! -user wayne -exec chown wayne.wayne {} \; -print
find /mnt/mergerfs/union/media/music         \! -user wayne -exec chown wayne.wayne {} \; -print
#find /mnt/mergerfs/union/media/books         \! -user wayne -exec chown wayne.wayne {} \; -print
#find /mnt/mergerfs/union/media/pictures      \! -user wayne -exec chown wayne.wayne {} \; -print
