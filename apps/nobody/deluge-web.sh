#!/bin/bash

# wait for deluge daemon process to start (listen for port)
while [[ $(netstat -lnt | awk '$6 == "LISTEN" && $4 ~ ".58846"') == "" ]]; do
	sleep 0.1
done

# if config file doesnt exist then copy stock config file
if [[ ! -f /config/web.conf ]]; then

	echo "[info] Deluge webui config file doesn't exist, copying default..."
	cp /home/nobody/webui/web.conf /config/

fi

echo "[info] Starting Deluge webui..."
/usr/bin/deluge-web -c /config
