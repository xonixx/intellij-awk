BEGIN {
   cmd = "tr '[A-Z]' '[a-z]' 2> /dev/null"
   PROCINFO[cmd, "pty"] = 1
   input = "ABCD"
   print input |& cmd
   cmd |& getline x
   print x
#   close(cmd)
}
