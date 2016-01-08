#!/bin/sh
DATADIR=/data

echo " ======================="
echo " ----- docker-ts3 ------"
echo " ======================="

if ! [ -d $DATADIR/files ]; then
    echo "No files folder found in the persistent storage folder. A new one will be created."
    mkdir -p $DATADIR/files
fi
echo "Linking the files folder to persistent storage folder."
rm -rf /opt/teamspeak3-server_linux-amd64/files
ln -s $DATADIR/files /opt/teamspeak3-server_linux-amd64/files


# Check if ts3server.ini exists in the persistent storage folder.
if [ -f $DATADIR/ts3server.ini ]
    then
        # ini file found
        echo "Using existing ts3server.ini file in the persistent storage folder."
        echo
        echo "    IMPORTANT: If this ini file was transfered from another ts3-install,"
        echo "               make sure the following settings are configured so the persistent storage is used:"
        echo
        echo "        -query_ip_whitelist='$DATADIR/query_ip_whitelist.txt'"
        echo "        -query_ip_blacklist='$DATADIR/query_ip_blacklist.txt'"
        echo "        -logpath='$DATADIR/logs/'"
        echo "        -licensepath='$DATADIR/'" 
        echo "        -inifile='$DATADIR/ts3server.ini'"
        echo

        # Check if dbplugin is different from default (sqlite3)
        if grep -Fcx "dbplugin=ts3db_mysql" $DATADIR/ts3server.ini > /dev/null
            then
                # dbplugin is not sqlite3.  Skipping sqlitedb file checks.
                echo "Existing ts3server.ini configured for alternate database type (e.g. MySQL).  Make sure it's configured properly."
                echo "Skipping sqlitedb file checks."
            else
                # dbplugin is sqlite3

                # Check if ts3server.sqlitedb exists in persistent storage folder.
                if ! [ -f $DATADIR/ts3server.sqlitedb ]
                    then
                        echo "No database file found. A new one will be created."
                        touch $DATADIR/ts3server.sqlitedb
                    else
                        echo "Using existing database file in the persistent storage folder."
                fi
                ln -s $DATADIR/ts3server.sqlitedb /opt/teamspeak3-server_linux-amd64/ts3server.sqlitedb 
        fi
        echo "Starting ts3server..."
        /opt/teamspeak3-server_linux-amd64/ts3server_minimal_runscript.sh \
                inifile=$DATADIR/ts3server.ini
    else
        echo "No ts3server.ini file found in the persistent storage folder. A new one will be created."

        # Check if ts3server.sqlitedb exists in persistent storage folder.
        if ! [ -f $DATADIR/ts3server.sqlitedb ]
            then
                echo "No database file found. A new one will be created."
                touch $DATADIR/ts3server.sqlitedb
            else
                echo "Using existing database file in the persistent storage folder."
        fi
        # Link database file to persistent storage folder
        ln -s $DATADIR/ts3server.sqlitedb /opt/teamspeak3-server_linux-amd64/ts3server.sqlitedb 
        
        # Create new ini file
        echo "Starting ts3server with default parameters..."
        /opt/teamspeak3-server_linux-amd64/ts3server_minimal_runscript.sh \
            query_ip_whitelist=$DATADIR/query_ip_whitelist.txt \
            query_ip_blacklist=$DATADIR/query_ip_blacklist.txt \
            logpath=$DATADIR/logs/ \
            licensepath=$DATADIR/ \
            inifile=$DATADIR/ts3server.ini \
            createinifile=1
fi
