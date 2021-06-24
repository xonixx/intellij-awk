BEGIN {
	x = @/xx/
	print typeof(x)
	print x
}

# this set may not really be needed for the test
BEGIN {
	x = 4
	print typeof(@/xxx/)
	print typeof(3)
	print x
}

BEGIN {
	print typeof(x)
	print typeof(a[1])
	a[1][2]	# fatals on this
}
