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
This means the server should use your old ts3 db if present.
If not present it will create a new one.

Right now this will NOT be created under the linked host-folder!
The problem here is i cant tell the TS3 server to create the db in 
specific folder.

Creating a empty file and then linking this did not work either since 
TS3 is then complaining its no sqlite db.
