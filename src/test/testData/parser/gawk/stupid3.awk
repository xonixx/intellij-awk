BEGIN {
	test(someidentifier)
}


function test(p)
{
	test0(p)
	p
	test0(p)
}

function test0(p)
{
	print "TYPEOF: " typeof(p)
}
