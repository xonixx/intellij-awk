BEGIN {
	split("0a", f)	# set f[0] to a strnum that is really a string
	LINT = f[1]	# lint should be enabled
	x = exp("0")	# should generate a warning
}
