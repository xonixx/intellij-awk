BEGIN {
	split("5apple", f)	# make a strnum
	x = f[1]+0		# force strnum conversion to number or string
	print typeof(f[1])	# should be string
}
