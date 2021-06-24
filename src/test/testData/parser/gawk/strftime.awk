# strftime.awk ; test the strftime code
#
# input is the output of `date', see Makefile.in

BEGIN {
	maxtries = 10
	# On DOS/Windows, DATECMD is set by the Makefile to point to
	# Unix-like 'date' command.
	datecmd = DATECMD
	if (datecmd == "")
	    datecmd = "date"
	fmt = "%a %b %e %H:%M:%S %Z %Y"

	# loop until before equals after, thereby protecting
	# against a race condition where the seconds field might have
	# incremented between running date and strftime
	i = 0
	while (1) {
		if (++i > maxtries) {
			printf "Warning: this system is so slow that after %d attempts, we could never get two sequential invocations of strftime to give the same result!\n", maxtries > "/dev/stderr"
			break
		}
		before = strftime(fmt)
		datecmd | getline sd
		after = strftime(fmt)
		close(datecmd)
		if (before == after) {
			if (i > 1)
				printf "Notice: it took %d loops to get the before and after strftime values to match\n", i > "/dev/stderr"
			break
		}
	}
	print sd > "strftime.ok"
	print after > OUTPUT
}
