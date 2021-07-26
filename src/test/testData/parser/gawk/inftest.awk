BEGIN {
  k = 0
  x = 100
  # Added k limit test after finding some systems that didn't terminate
  # the loop correctly, sigh...
  do { k++; y = x ; x *= 1000; print x,y } while ( y < x  && k < 1700)
  print "loop terminated"
}
