BEGIN {
	the_func = "p"
	print @the_func("Hello")
}

function p(str)
{
	print "! " str " !"
}
