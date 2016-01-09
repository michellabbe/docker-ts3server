FROM frolvlad/alpine-glibc

MAINTAINER Michel Labbe

COPY /scripts/ /opt/scripts/

RUN TS_VERSION=3.0.11.4   && \
    apk add --update wget   && \
        #RUN chmod -R 744 /opt/scripts/   && \
        #RUN /opt/scripts/getlatest-ts3.sh   && \
    wget http://dl.4players.de/ts/releases/$TS_VERSION/teamspeak3-server_linux-amd64-$TS_VERSION.tar.gz \
         -O /opt/teamspeak3-server_linux-amd64-$TS_VERSION.tar.gz   && \
    tar -C /opt -xzf /opt/teamspeak3-server_linux-amd64-$TS_VERSION.tar.gz   && \
    rm /opt/teamspeak3-server_linux-amd64-$TS_VERSION.tar.gz   && \
    adduser -g "" -s /bin/false -D -H -u 1000 teamspeak   && \
    chown -R 1000:1000 /opt/teamspeak3-server_linux-amd64/   && \
    chown -R 1000:1000 /opt/scripts/   && \
    chmod -R 744 /opt/scripts/

USER teamspeak

# Listen to required ports
EXPOSE 9987/udp 30033 10011
  # Port 9987/udp is default TeamSpeak 3 server port
  # Port 30033 is used for File transfer
  # Port 10011 is used for Server Query

ENTRYPOINT ["/opt/scripts/docker-ts3.sh"]
