BEGIN {
	# N.B. This relies upon the undocumented 2nd argument to typeof
	x[0] = 0
	print typeof(x, a)
	print a["array_type"]

	# make sure it resets
	delete x[0]
	print typeof(x, a)
	print a["array_type"]

	x["fubar"] = 0
	print typeof(x, a)
	print a["array_type"]

	delete x["fubar"]
	print typeof(x, a)
	print a["array_type"]

	x[-2] = 0
	print typeof(x, a)
	print a["array_type"]

	delete x[-2]
	print typeof(x, a)
	print a["array_type"]

	x[2] = 0
	print typeof(x, a)
	print a["array_type"]

	delete x
	print typeof(x, a)
	print a["array_type"]
}
