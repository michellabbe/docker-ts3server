#!/bin/bash
VOLUME=/data

echo " ----- docker-ts3 ------"
echo "1. Check if ts3server.sqlitedb exists in host-mounted volume."
if [ -f $VOLUME/ts3server.sqlitedb ]
  then
    echo "$VOLUME/ts3server.sqlitedb found. Creating Link between host-mounted db-file and ts3-folder."
	ln -s $VOLUME/ts3server.sqlitedb /opt/teamspeak3-server_linux-amd64/ts3server.sqlitedb 
fi

echo "2. Link the files-folder into the host-mounted volume."
mkdir -p $VOLUME/files
if ! [ -L /opt/teamspeak3-server_linux-amd64/files ]; then
  rm -rf /opt/teamspeak3-server_linux-amd64/files
  ln -s $VOLUME/files /opt/teamspeak3-server_linux-amd64/files
fi

echo "3. Starting TS3-Server."
echo "Check if ts3server.ini exists in host-mounted volume."
if [ -f $VOLUME/ts3server.ini ]; then
    echo "$VOLUME/ts3server.ini found. Using ini as config file."
	echo "HINT: If this ini was transfered from another ts3-install you may want to make sure the following settings are active for the usage of host-mounted volume: (OPTIONAL)"
	echo "query_ip_whitelist='/data/query_ip_whitelist.txt'"
	echo "query_ip_backlist='/data/query_ip_blacklist.txt'"
	echo "logpath='/data/logs/'"
	echo "licensepath='/data/'" 
	echo "inifile='/data/ts3server.ini'"
	/opt/teamspeak3-server_linux-amd64/ts3server_minimal_runscript.sh \
		inifile="/data/ts3server.ini"
else
	echo "$VOLUME/ts3server.ini not found. Creating new config file."
	/opt/teamspeak3-server_linux-amd64/ts3server_minimal_runscript.sh \
		query_ip_whitelist="/data/query_ip_whitelist.txt" \
		query_ip_backlist="/data/query_ip_blacklist.txt" \
		logpath="/data/logs/" \
		licensepath="/data/" 
		inifile="/data/ts3server.ini" \
		createinifile=1 
fi
