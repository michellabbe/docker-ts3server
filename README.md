# docker: ts3server

This is a Docker image to run a [TeamSpeak 3](http://www.teamspeak.com/) server with persistent data moved to a persistent storage folder.

Please note that Docker 1.9 or later is required for persistent storage.

### Prepare folder for persistent storage
Create a folder on your Docker host that will be used for persistent data in the ts3server container:
```
mkdir {FOLDER}
chown 1000:1000 {FOLDER}
```
Replace `{FOLDER}` with an absolute path on the Docker host (e.g. `/docker-persist/ts3server`).  This `{FOLDER}` on the host will be mapped as `/data` inside the container and this is where your database and some other files will be stored.

If you want to backup your TeamSpeak 3 Server files, this `{FOLDER}` on the host is the one you need to backup.

### Pulling from Docker Hub
To pull the latest image from Docker registry, use the following command:
```
docker pull mlabbe/ts3server
```

### Running the image
In order to run the TeamSpeak 3 Server, use the following:
```
docker run --restart=unless-stopped --name=ts3server -d -p 9987:9987/udp -p 30033:30033 -p 10011:10011 -v {FOLDER}:/data mlabbe/ts3server
```

You can bind only port `9987/udp` if you don't need Server Query and File Transfer.

You can also use different port(s) if you want.  You can keep the default built-in ports inside the container and just map them to different ports on the host, e.g.:

`-p 9988:9987/udp -p 30034:30033 -p 10012:10011`

The script will create symlinks to move sqlite database & config files to your persistent storage folder (existing files will be reused and missing files will be created).

**IMPORTANT**: if you bring files from another TeamSpeak3 server, make sure you edit paths in _ts3server.ini_ accordingly:
- `licensepath=/data/`
- `query_ip_whitelist=/data/query_ip_whitelist.txt`
- `query_ip_blacklist=/data/query_ip_blacklist.txt`
- `logpath=/data/logs`

### First Run
If no database exist in the persistent storage folder, a new database will be created. Make sure you check the logfile, using the following command:
```
docker logs ts3server
```

You will need your randomized ServerAdmin password/token to manage your new server. These are found in the log file on first run:
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
**Write them down for later use.**

### Upgrading
Since the config/data files should be stored in the persistent storage folder, just pull the newer image from Docker Hub, then stop/remove the container and create it again:
```
docker pull mlabbe/ts3server
docker stop ts3server
docker rm ts3server
docker run --restart=unless-stopped --name=ts3server -d -p 9987:9987/udp -p 30033:30033 -p 10011:10011 -v {FOLDER}:/data mlabbe/ts3server
```
