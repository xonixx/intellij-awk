BEGIN {
	stftime::gensub = 3	# should be OK, not related to indirect calls
}


BEGIN { base_time = systime() }	# in awk namespace

@namespace "testing"

function strftime(mesg)
{
	printf("strftime(%s) - this is not the function you are looking for\n",
		mesg)
	return 0
}

BEGIN {
	strftime("from 'testing'")
	gensub = "gensub"
	print "gensub =", gensub
}

function systime()
{
	return awk::base_time
}

BEGIN {
	st = "systime"
	now[1] = @st()

	st = "awk::systime"
	now[2] = @st()

	st = "testing::systime"
	now[3] = @st()

	for (i = 1; i <= 3; i++) {
		if (now[i] == awk::base_time || now[i] == awk::base_time + 1)
			printf "iteration %d, got good result from systime\n", i
		else
			printf "iteration %d, got bad result from systime, now %d, base_time %d\n", i, now, awk::base_time
	}
}
