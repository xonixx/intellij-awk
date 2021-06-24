BEGIN {
	# We use "&&" and not ";" so it works with Windows shells as well.
	cmd = "cat - 1>&2 && sleep 2"
	printf "%s\n", "test1" |& cmd
	close(cmd, "to")
	printf "%s\n", "test2" |& cmd
	print ERRNO
}
