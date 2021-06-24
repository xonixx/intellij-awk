BEGIN {
	cmd = "cat - 1>&2; sleep 2"
	PROCINFO[cmd, "NONFATAL"] = 1
	print "test1" |& cmd; close(cmd, "to")
	fflush(cmd)
	print "test2" |& cmd; print gensub(/number/, "descriptor", 1, ERRNO)
}
