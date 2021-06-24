BEGIN {
	test(someidentifier)
}


function test(a)
{
	print typeof(a)
	a
	print typeof(a)
}
