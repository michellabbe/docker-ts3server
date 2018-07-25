FROM alpine:latest
#FROM alpine:3.8

MAINTAINER Michel Labbe

COPY /scripts/ /opt/scripts/

RUN TS_VERSION=3.2.0 \
    && apk add --no-cache ca-certificates libstdc++ \
    && wget http://dl.4players.de/ts/releases/$TS_VERSION/teamspeak3-server_linux_alpine-$TS_VERSION.tar.bz2 \
            -O /opt/teamspeak3-server_linux_alpine-$TS_VERSION.tar.bz2 \
    && tar -C /opt -jxvf /opt/teamspeak3-server_linux_alpine-$TS_VERSION.tar.bz2 \
    && rm /opt/teamspeak3-server_linux_alpine-$TS_VERSION.tar.bz2 \
    && adduser -g "" -s /bin/false -D -H -u 1000 teamspeak \
    && chown -R 1000:1000 /opt/teamspeak3-server_linux_alpine/ \
    && chown -R 1000:1000 /opt/scripts/ \
    && chmod -R 744 /opt/scripts/ \
    && mv /opt/teamspeak3-server_linux_alpine/*.so /opt/teamspeak3-server_linux_alpine/redist/* /usr/local/lib

VOLUME ["/data"]

USER teamspeak

# Listen to required ports
EXPOSE 9987/udp 10011 30033
  # Port 9987/udp is default TeamSpeak 3 server port
  # Port 10011 is used for Server Query
  # Port 30033 is used for File transfer

ENTRYPOINT ["/opt/scripts/docker-ts3.sh"]
