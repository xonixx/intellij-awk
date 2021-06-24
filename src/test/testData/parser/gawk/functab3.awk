function foo()
{
	print "foo!"
}

BEGIN {
	x = FUNCTAB["foo"]
	print "x =", x
	@x()
}
