#!/bin/bash

TS_VERSION=`wget --no-check-certificate -qO - https://www.server-residenz.com/tools/ts3versions.json|grep latest|awk '{print $2}'|sed s/\"//g|sed s/,//g`
echo "Installing Teamspeak ${TS_VERSION}"

wget http://dl.4players.de/ts/releases/$TS_VERSION/teamspeak3-server_linux-amd64-$TS_VERSION.tar.gz \
         -O /opt/teamspeak3-server_linux-amd64-$TS_VERSION.tar.gz

tar -C /opt -xzf /opt/teamspeak3-server_linux-amd64-$TS_VERSION.tar.gz
rm /opt/teamspeak3-server_linux-amd64-$TS_VERSION.tar.gz
adduser -g "" -s /bin/false -D -H -u 1000 teamspeak
chown -R 1000:1000 /opt/teamspeak3-server_linux-amd64/
chown -R 1000:1000 /opt/scripts/
chmod -R 774 /opt/scripts/
