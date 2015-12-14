FROM debian:latest

MAINTAINER Michel Labbe

# build intial apt binary cache and install wget
#RUN apt-get update \
#    && apt-get install -y wget --no-install-recommends

# clean up cached binaries after install
#RUN apt-get clean

# Check latest version on http://teamspeak.com/downloads#server
#ENV TEAMSPEAK_VERSION 3.0.11.4
#ENV TEAMSPEAK_SHA1 09e7fc2cb5dddf84f3356ddd555ad361f5854321

# Inject a Volume for any TS3-Data that needs to be persisted 
# or to be accessible from the host. (e.g. for Backups)
VOLUME ["/data"]

# Download TS3 file and extract it into /opt.
#RUN wget -O teamspeak3-server_linux-amd64-${TEAMSPEAK_VERSION}.tar.gz http://dl.4players.de/ts/releases/${TEAMSPEAK_VERSION}/teamspeak3-server_linux-amd64-${TEAMSPEAK_VERSION}.tar.gz \
#        && echo "${TEAMSPEAK_SHA1} *teamspeak3-server_linux-amd64-${TEAMSPEAK_VERSION}.tar.gz" | sha1sum -c - \
#        && tar -C /opt -xzf teamspeak3-server_linux-amd64-${TEAMSPEAK_VERSION}.tar.gz \
#        && rm teamspeak3-server_linux-amd64-${TEAMSPEAK_VERSION}.tar.gz

#ADD http://dl.4players.de/ts/releases/${TEAMSPEAK_VERSION}/teamspeak3-server_linux-amd64-${TEAMSPEAK_VERSION}.tar.gz /opt
#RUN tar -C /opt -xzf /tmp/teamspeak3-server_linux-amd64-${TEAMSPEAK_VERSION}.tar.gz && rm /tmp/teamspeak3-server_linux-amd64-${TEAMSPEAK_VERSION}.tar.gz

ADD http://dl.4players.de/ts/releases/3.0.11.4/teamspeak3-server_linux-amd64-3.0.11.4.tar.gz /tmp
RUN tar -C /opt -xzf /tmp/teamspeak3-server_linux-amd64-3.0.11.4.tar.gz && rm /tmp/teamspeak3-server_linux-amd64-3.0.11.4.tar.gz

RUN echo before ADD scripts
ADD /scripts/ /opt/scripts/
RUN chmod -R 774 /opt/scripts/

RUN echo after ADD scripts
# Listen to required ports
EXPOSE 9987/udp 30033 10011
# Port 9987/udp is default TeamSpeak 3 server port
# Port 30033 is used for File transfer
# Port 10011 is used for Server Query

ENTRYPOINT ["/opt/scripts/docker-ts3.sh"]
#CMD ["-w", "/teamspeak3/query_ip_whitelist.txt", "-b", "/teamspeak3/query_ip_blacklist.txt", "-o", "/teamspeak3/logs/", "-l", "/teamspeak3/"]
