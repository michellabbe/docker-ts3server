FROM debian:wheezy

MAINTAINER Michel Labbe

COPY /scripts/ /opt/scripts/

RUN TS_VERSION=3.0.11.4 \
	&& apt-get update && apt-get install -y curl \
	&& curl -L http://dl.4players.de/ts/releases/$TS_VERSION/teamspeak3-server_linux-amd64-$TS_VERSION.tar.gz > /opt/teamspeak3-server_linux-amd64-$TS_VERSION.tar.gz \
	&& apt-get autoremove -y --purge curl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& tar -C /opt -xzf /opt/teamspeak3-server_linux-amd64-$TS_VERSION.tar.gz \
	&& rm /opt/teamspeak3-server_linux-amd64-$TS_VERSION.tar.gz \
	&& chmod -R 774 /opt/scripts/

# Listen to required ports
EXPOSE 9987/udp 30033 10011
	# Port 9987/udp is default TeamSpeak 3 server port
	# Port 30033 is used for File transfer
	# Port 10011 is used for Server Query

ENTRYPOINT ["/opt/scripts/docker-ts3.sh"]
