#!/bin/bash
set -e
echo "start check up status"

if [[ "$*" == node*index.js* ]]; then
	if [[ ! -f "$GHOST_CONTENT/installed" ]]; then
		echo "first start ghost, init ..."
		#check if the folder is null
		count=`ls $GHOST_CONTENT | wc -w`
		if [ "$count" -gt "0" ];then
		echo "this folder have $count files"
		exit 1
		else
		echo "content folder is empty"
		mkdir "$GHOST_CONTENT/data"
		mkdir "$GHOST_CONTENT/logs"
		mkdir "$GHOST_CONTENT/images"
		mkdir "$GHOST_CONTENT/themes"
		fi

		if [[ ! -f "$GHOST_CONTENT/config.production.json" ]];then
			mv config.production.json.default "$GHOST_CONTENT/config.production.json"
			ln -sf "$GHOST_CONTENT/config.production.json" "$GHOST_SOURCE/config.production.json"
		fi
		knex-migrator init
		touch "$GHOST_CONTENT/installed"
	else
		echo "not need to init ghost, start up ghost"
	fi
	ln -sf "$GHOST_CONTENT/config.production.json" "$GHOST_SOURCE/config.production.json"
fi

exec "$@"
