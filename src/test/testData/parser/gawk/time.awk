@load "time"

# make sure gettimeofday() is consistent with systime().  We must call
# gettimeofday() before systime() to make sure the subtraction gives 0
# without risk of rolling over to the next second.
function timecheck(st,res) {
   res = gettimeofday()
   st = systime()
   printf "gettimeofday - systime = %d\n", res-st
   return res
}

BEGIN {
   delta = 1.3
   t0 = timecheck()
   printf "sleep(%s) = %s\n",delta,sleep(delta)
   t1 = timecheck()
   slept = t1-t0
   if ((slept < 0.9*delta) || (slept > 1.3*delta))
      printf "Warning: tried to sleep %.2f secs, but slept for %.2f secs\n",
	     delta,slept
}
