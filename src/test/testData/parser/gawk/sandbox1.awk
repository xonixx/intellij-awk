BEGIN {
	ARGV[ARGC++] = ARGV[1]	# should be ok
	ARGV[ARGC++] = ""	# empty string, should be ok
	ARGV[ARGC++] = "foo=bar"	# assignment, should be ok
	ARGV[ARGC++] = "junk::foo=bar"	# assignment, should be ok
	ARGV[ARGC++] = "/dev/null"	# should fatal here
}
