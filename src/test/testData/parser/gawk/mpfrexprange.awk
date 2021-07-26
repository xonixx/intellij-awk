# test change of allowed exponent range
BEGIN {
	x=1.0e-10000
	print x+0
	PREC="double"
	print x+0
}
