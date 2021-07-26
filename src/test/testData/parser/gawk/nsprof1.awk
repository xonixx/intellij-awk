@namespace "foo"

BEGIN {
	a = 5
	a++
	print a
}

/foo/ { print "bar" }

@namespace "stuff"

function stuff()
{
	print "stuff"
}
