BEGIN {
  # check that PROCINFO["errno"] is working properly
  getline
  if (close(FILENAME)) {
      print "Error `" ERRNO "' closing input file"
      print "errno =", PROCINFO["errno"]
  }
  getline < (FILENAME "/bogus")
  print (PROCINFO["errno"] > 0), ERRNO
}
