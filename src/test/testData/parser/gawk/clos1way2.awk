{
	# We use "&&" and not ";" so it works with Windows shells as well.
	cmd = "cat - 1>&2 && sleep 2"
	print |& cmd; close(cmd, "to")
	fflush(cmd)
	print |& cmd; print ERRNO
}
