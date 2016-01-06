# docker: ts3server

This is a Docker image to run a [TeamSpeak 3](http://www.teamspeak.com/) server with persistent data moved to a persistent storage folder.
Docker 1.9 or later required for persistent storage.

### Pulling from Docker hub
If you want to obtain the image from Docker registry, you can use the following commands:
```
docker pull mlabbe/ts3server
mkdir {FOLDER}
chown 1000:1000 {FOLDER}
```
Replace {FOLDER} with an absolute path on the Docker host (e.g. /docker-persist/ts3server) where your persistent data will be placed.
This folder on the host will be mapped as /data inside the container.

### Running the image
In order to run the TeamSpeak 3 Server, use the following:
```
docker run --restart=unless-stopped --name=ts3server -d -p 9987:9987/udp -p 30033:30033 -p 10011:10011 -v {FOLDER}:/data mlabbe/ts3server
```

You can bind only port 9987/udp if you don't need Server Query and File Transfer.

You can also use different port(s) if you want.  Keep the default built-in ports inside the container, just map them to different ports on the host, e.g.:

```
-p 9988:9987/udp -p 30034:30033 -p 10012:10011
```

The script will create symlinks to move sqlite database & config files to your persistent storage folder (existing files will be reused and missing files will be created).

IMPORTANT: if you bring files from another TeamSpeak3 server, make sure you edit paths in ts3server.ini accordingly:
- licensepath=/data/
- query_ip_whitelist=/data/query_ip_whitelist.txt
- query_ip_blacklist=/data/query_ip_blacklist.txt
- logpath=/data/logs

### First Run
If no database exist in the persistent storage folder, a new database will be created.
Make sure you check the logfile, using the following command:
```
docker logs ts3server
```

You will need your randomized serveradmin password/token to manage your new server.
These are found in the log file on first run:
```
------------------------------------------------------------------
                      I M P O R T A N T
------------------------------------------------------------------
               Server Query Admin Account created
         loginname= "serveradmin", password= "nRb1UVuT"
------------------------------------------------------------------
```
[...]
```
------------------------------------------------------------------
                      I M P O R T A N T
------------------------------------------------------------------
      ServerAdmin privilege key created, please use it to gain
      serveradmin rights for your virtualserver. please
      also check the doc/privilegekey_guide.txt for details.

       token=ksPgCPfsORchEe22sz+u339+ybQR3BhgYHttgLOE
------------------------------------------------------------------
```
*Write them down for later use.*

### Upgrading
Since the config/data files should be stored in the persistent storage folder,
just pull the newer image from Docker Hub, then stop/destroy the container and create it again:
```
docker pull mlabbe/ts3server
docker stop ts3server
docker rm ts3server
docker run --restart=unless-stopped --name=ts3server -d -p 9987:9987/udp -p 30033:30033 -p 10011:10011 -v {FOLDER}:/data mlabbe/ts3server
```
