FROM frolvlad/alpine-glibc

MAINTAINER Michel Labbe

COPY /scripts/ /opt/scripts/

RUN TS_VERSION=3.0.12.4 \
    && apk add --update wget bzip2 \
    && wget http://dl.4players.de/ts/releases/$TS_VERSION/teamspeak3-server_linux_amd64-$TS_VERSION.tar.bz2 \
            -O /opt/teamspeak3-server_linux_amd64-$TS_VERSION.tar.bz2 \
    && tar -C /opt -jxvf /opt/teamspeak3-server_linux_amd64-$TS_VERSION.tar.bz2 \
    && rm /opt/teamspeak3-server_linux_amd64-$TS_VERSION.tar.bz2 \
    && adduser -g "" -s /bin/false -D -H -u 1000 teamspeak \
    && chown -R 1000:1000 /opt/teamspeak3-server_linux_amd64/ \
    && chown -R 1000:1000 /opt/scripts/ \
    && chmod -R 744 /opt/scripts/

USER teamspeak

# Listen to required ports
EXPOSE 9987/udp 30033 10011
  # Port 9987/udp is default TeamSpeak 3 server port
  # Port 30033 is used for File transfer
  # Port 10011 is used for Server Query

ENTRYPOINT ["/opt/scripts/docker-ts3.sh"]