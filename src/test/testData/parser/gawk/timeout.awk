BEGIN {
	cmd = "echo hello; sleep 1; echo goodbye"

	print "With timeouts"
	PROCINFO[cmd, "READ_TIMEOUT"] = 400
	while ((rc = (cmd | getline x)) > 0)
		print x
	if (rc < 0)
		print rc, (PROCINFO["errno"] != 0), (ERRNO != "")
	print (close(cmd) != 0)

	PROCINFO[cmd, "RETRY"]
	print ""
	print "With timeouts and retries"
	while (((rc = (cmd | getline x)) > 0) || (rc == -2)) {
		if (rc > 0) {
			print x
			n = 0
		}
		else
			print ++n, "timed out; trying again"
	}
	if (rc < 0)
		print rc, (PROCINFO["errno"] != 0), (ERRNO != "")
	print (close(cmd) != 0)
}
