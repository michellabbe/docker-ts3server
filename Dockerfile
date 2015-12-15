FROM debian:latest

MAINTAINER Michel Labbe

ADD http://dl.4players.de/ts/releases/3.0.11.4/teamspeak3-server_linux-amd64-3.0.11.4.tar.gz /opt/

COPY /scripts/ /opt/scripts/

RUN chmod -R 774 /opt/scripts/ \
 && tar -C /opt -xzf /opt/teamspeak3-server_linux-amd64-3.0.11.4.tar.gz \
 && rm /opt/teamspeak3-server_linux-amd64-3.0.11.4.tar.gz

# Listen to required ports
EXPOSE 9987/udp 30033 10011
# Port 9987/udp is default TeamSpeak 3 server port
# Port 30033 is used for File transfer
# Port 10011 is used for Server Query

ENTRYPOINT ["/opt/scripts/docker-ts3.sh"]
#CMD ["-w", "/data/query_ip_whitelist.txt", "-b", "/data/query_ip_blacklist.txt", "-o", "/data/logs/", "-l", "/data/"]
