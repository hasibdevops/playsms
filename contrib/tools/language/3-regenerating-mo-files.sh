#!/bin/bash

PLAYSMS=$1

if [ -z "$PLAYSMS" ]; then
	PLAYSMS=../../..
fi

if [ ! -d "$PLAYSMS/web" ]; then
	echo "Error. Usage: $(basename $0) <playSMS source dir>"
	exit 1
fi

set -e

find $PLAYSMS/web/plugin/ -type d -name "language" | grep -v "grep" | sed -e "s/\/[^\/]*$//" > /tmp/.lang_folders
for i in `cat /tmp/.lang_folders` ; do
	for j in `ls -1 "$i/language/" | grep '_'` ; do
		mkdir -p "$i/language/$j/LC_MESSAGES"
		touch "$i/language/$j/LC_MESSAGES/messages.po"
		msgfmt -vv "$i/language/$j/LC_MESSAGES/messages.po" -o "$i/language/$j/LC_MESSAGES/messages.mo"
	done
done
rm /tmp/.lang_folders

exit 0
