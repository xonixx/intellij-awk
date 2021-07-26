match($0,/:deathdate=2007....:/) { print substr($0,RSTART+11,RLENGTH-16) }
