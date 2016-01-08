FROM frolvlad/alpine-glibc

MAINTAINER Michel Labbe

COPY /scripts/ /opt/scripts/

RUN apk add --update wget  && \
    /opt/scripts/getlatest-ts3.sh
RUN adduser -g "" -s /bin/false -D -H -u 1000 teamspeak   && \
    chown -R teamspeak /opt/teamspeak3-server_linux-amd64/   && \
    chown -R teamspeak /opt/scripts/   && \
    chmod -R 744 /opt/scripts/

USER teamspeak

# Listen to required ports
EXPOSE 9987/udp 30033 10011
  # Port 9987/udp is default TeamSpeak 3 server port
  # Port 30033 is used for File transfer
  # Port 10011 is used for Server Query

ENTRYPOINT ["/opt/scripts/docker-ts3.sh"]
