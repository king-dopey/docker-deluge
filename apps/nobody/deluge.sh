#!/bin/bash

# if config file doesnt exist (wont exist until user changes a setting) then copy default config file
if [[ ! -f /config/core.conf ]]; then

	echo "[info] Deluge config file doesn't exist, copying default..."
	cp /home/nobody/deluge/core.conf /config/

else

	echo "[info] Deluge config file already exists, skipping copy"

fi

# Set core.conf IP if interface is set
if [ ! -z {$INTERFACE+x} ]
then
	echo "Setting Exteneral IP in core.conf to the $INTERFACE interface IP"
	ip addr show | grep $INTERFACE | grep inet | cut -f 6 -d " " | cut -f 1 -d "/" | while read EXTERNAL_IP; do sed 's/\"listen_interface.*/\"listen_interface\": \"'"$EXTERNAL_IP"\"',/g' -i /config/core.conf ; done
fi

echo "[info] Starting Deluge daemon..."
/usr/bin/deluged -d -c /config -L info -l /config/deluged.log
