BEGIN {
	PROCINFO["NONFATAL"] = 1
	print > "/dev/no/such/file"
	print ERRNO
}
