@namespace "foo"

function test(v)
{
	print "-- 1"
	for (i in Data)
		print i

	print "-- 2"
	for (v in Data)
		print v
	print "-- 3"
}

BEGIN {
	Data[1] = 1
	Data[2] = 2

	test()
}
