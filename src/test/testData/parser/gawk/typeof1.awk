BEGIN {
	a = 5 ; print typeof(a)
	print typeof(b)
	print typeof(@/foo/)
	c = "foo" ; print typeof(c)
	d[1] = 1 ; print typeof(d), typeof(d[1])
	e = @/foo/ ; print typeof(e)
	print typeof(@/bar/)
}
