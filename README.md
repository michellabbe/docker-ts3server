# docker: ts3server

This is a Docker image to run a [TeamSpeak 3](http://www.teamspeak.com/) server.

### Pulling from Docker hub
If you want to obtain the image from Docker registry, and link it with local files in /docker-persist/ts3server dir, you can use the following commands:
```
docker pull mlabbe/ts3server
mkdir /docker-persist/ts3server
chown 1000:1000 /docker-persist/ts3server
```
### Running the image
In order to run the TeamSpeak 3 Server, use the following:
```
docker run --restart=unless-stopped --name=ts3server -d -p 9987:9987/udp -p 30033:30033 -p 10011:10011 -v /docker-persist/ts3server:/data mlabbe/ts3server
```

Note: only port 9987/udp is mandatory.

The script does look for an sqlite db in the linked host-folder.
If its found, a symlink is created to the ts3-folder inside the container.

IMPORTANT: if you bring files from another TeamSpeak3 server, make sure you edit paths in ts3server.ini accordingly:
- licensepath=/data/
- query_ip_whitelist=/data/query_ip_whitelist.txt
- query_ip_blacklist=/data/query_ip_blacklist.txt
- logpath=/data/logs
