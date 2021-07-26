# Tests side effects (like caching) on the evaluation (formatting and
# rounding) of MPFR variables vs literals.
BEGIN {
	pi = 3.1416
	e = 2.7183
	golden = 1.6180

	# Evaluated as number with (default) OFMT.
	print pi
	print e
	print golden
	printf "\n"

	# Evaluated as number with (custom) OFMT.
	OFMT = "%.f"
	ROUNDMODE = "U";  print "Variable pi U:", pi
	ROUNDMODE = "D";  print "Variable pi D:", pi
	ROUNDMODE = "U";  print "Literal  pi U:", 3.1416
	ROUNDMODE = "D";  print "Literal  pi D:", 3.1416
	printf "\n"

	# Evaluated as string with (custom) CONVFMT. Absent comma.
	CONVFMT = "%.f"
	ROUNDMODE = "D";  print "Variable e D: " e
	ROUNDMODE = "U";  print "Variable e U: " e
	ROUNDMODE = "D";  print "Literal  e D: " 2.7183
	ROUNDMODE = "U";  print "Literal  e U: " 2.7183
	printf "\n"

	# Evaluated as number with (hardcoded) printf conversion.
	ROUNDMODE = "N";  printf "Variable golden N: %.f\n", golden
	ROUNDMODE = "Z";  printf "Variable golden Z: %.f\n", golden
	ROUNDMODE = "N";  printf "Literal  golden N: %.f\n", 1.6180
	ROUNDMODE = "Z";  printf "Literal  golden Z: %.f\n", 1.6180
}
