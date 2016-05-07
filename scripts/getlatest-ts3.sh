#!/bin/sh

TS_VERSION=`wget --no-check-certificate -qO - https://www.server-residenz.com/tools/ts3versions.json|grep latest|awk '{print $2}'|sed s/\"//g|sed s/,//g`
echo "Installing Teamspeak ${TS_VERSION}"

wget http://dl.4players.de/ts/releases/${TS_VERSION}/teamspeak3-server_linux_amd64-${TS_VERSION}.tar.bz2 -P /opt/

tar -C /opt -jxf /opt/teamspeak3-server_linux_amd64-${TS_VERSION}.tar.bz2
rm /opt/teamspeak3-server_linux_amd64-${TS_VERSION}.tar.bz2
