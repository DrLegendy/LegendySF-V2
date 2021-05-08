### How to execute admin_panel.sh

READ THE README-MAIN.txt to know how to setup gen_settings.py and the mysql backups!

## Set the privileges:
chmod u+x *.py *.sh

## You can execute it in several ways:

# via number as argument
./admin_panel.sh 1

# via number as input
./admin_panel.sh
1

# via name as argument
./admin_panel.sh start

# via name as input
./admin_panel.sh

# and also... via sh
sh admin_panel.sh


### List of the admin_panel.sh options:

## 1. Start (start)
# You start the server

## 1i. Start Interactive (starti)
# You start the server choosing which channel or core start

## 2. Stop (stop)
# You stop the server

## 2i. Stop Interactive (stopi)
# You stop the server choosing which channel or core stop

## 3. Clean (clean|clear)
# You clear the logs

## 33. Clean All (cleanall|clearall)
# You clear the logs and also the backup files

## 4. Backup mysql/db (bak1)
# It will generate a mysql backup in baks/db/

## 5. Backup game/fs (bak2)
# It will generate a fs backup in baks/fs/

## 666. Generate (gen)
# It will generate the server struct

## 777. Compile Quests (quest)
# It will compile the quests

## 999. Search (search)
# It will search all the HOSTNAME and PORT settings in each config and print them
# Useful to make the serverinfo.py files... you need to pickup every channelX-core1 PORT

## 1a. Start+Daemon (startall)
# It will start the server and also the daemon script to keep the processes always on

## 2a. Stop+Daemon (stopall)
# It will stop the server and also the daemon script that keeps the processes always on

## 0. Quit (quit)
# Exit from the admin panel script
