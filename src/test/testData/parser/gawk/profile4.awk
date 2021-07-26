BEGIN {
	a = ("foo" (c = "bar"))
	a = (b - c) "foo"
	a = "foo" (b - c)
	q = (d = "x") (e = "y")
	a = ((c = tolower("FOO")) in JUNK)
	x = (y == 0 && z == 2 && q == 45)
}
