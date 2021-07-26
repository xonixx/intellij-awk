function foo()
{
	print "foo!"
}

BEGIN {
	FUNCTAB["a"] = "something"
}
