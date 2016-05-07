FROM debian:wheezy

MAINTAINER Michel Labbe

COPY /scripts/ /opt/scripts/

RUN TS_VERSION=3.0.12.4 \
	&& apt-get update && apt-get install -y curl bzip2 \
	&& curl -L http://dl.4players.de/ts/releases/$TS_VERSION/teamspeak3-server_linux_amd64-$TS_VERSION.tar.bz2 > /opt/teamspeak3-server_linux_amd64-$TS_VERSION.tar.bz2 \
	&& tar -C /opt -jxvf /opt/teamspeak3-server_linux_amd64-$TS_VERSION.tar.bz2 \
	&& apt-get autoremove -y --purge curl bzip2 \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm /opt/teamspeak3-server_linux_amd64-$TS_VERSION.tar.bz2 \
	&& chmod -R 774 /opt/scripts/

# Listen to required ports
EXPOSE 9987/udp 30033 10011
	# Port 9987/udp is default TeamSpeak 3 server port
	# Port 30033 is used for File transfer
	# Port 10011 is used for Server Query

ENTRYPOINT ["/opt/scripts/docker-ts3.sh"]
