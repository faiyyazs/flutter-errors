#!/bin/sh

echo Marking all hooks as executable...

find flutter-errors/scripts/hooks/ -type f -exec chmod +x {} \;

echo All hooks marked as executable

echo Moving all hooks to .git/hooks/

rsync -P flutter-errors/scripts/hooks/* .git/hooks/