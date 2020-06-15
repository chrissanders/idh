#!/bin/bash

# Chris Sanders

PRT="23"
LOG=hpot.log
cat banner - | ncat -klvnp $PRT >> $LOG 2>&1



# STEP 1 - LISTENER
ncat -klvnp 23


# STEP 2 - INTERACTIVITY
cat banner - | ncat -klvnp 23


# STEP 3 - LOGGING
cat banner - | ncat -klvnp 23 >> hpot.log 2>&1


# STEP 4 - Watchdog
#!/bin/bash
if [ ! "$(pidof ncpot)" ] 
then
  sudo ./home/sanders/ncpot.sh &
fi


# One Line HTTP Server
# while [ 1 ];do ncat -l -p 8000 -c 'echo -e "HTTP/1.1 200 OK\n";cat index.html'; done