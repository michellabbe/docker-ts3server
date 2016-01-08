#!/bin/sh

#TS_VERSION=`wget --no-check-certificate -qO - https://www.server-residenz.com/tools/ts3versions.json|grep latest|awk '{print $2}'|sed s/\"//g|sed s/,//g`
TS_VERSION=3.0.11.4
echo "Installing Teamspeak ${TS_VERSION}"

wget http://dl.4players.de/ts/releases/$TS_VERSION/teamspeak3-server_linux-amd64-$TS_VERSION.tar.gz \
         -O /opt/teamspeak3-server_linux-amd64-$TS_VERSION.tar.gz

tar -C /opt -xzf /opt/teamspeak3-server_linux-amd64-$TS_VERSION.tar.gz
rm /opt/teamspeak3-server_linux-amd64-$TS_VERSION.tar.gz

