# docker: ts3server

This is a Docker image to run a [TeamSpeak 3](http://teamspeak.com/) server.

### Pulling from Docker hub
If you want to obtain the image from Docker registry, you can use the following command:
```
docker pull mlabbe/ts3server
```
### Running the image
In order to run the TeamSpeak 3 Server, use the following:
```
docker run --restart=unless-stopped --name=ts3server -d -p 9987:9987/udp -p 30033:30033 -p 10011:10011 -v /docker-static/ts3server:/data mlabbe/ts3server
```

Note: only port 9987/udp is mandatory.

The script does look for an sqlite db in the linked host-folder.
If its found, a symlink is created to the ts3-folder inside the container.
