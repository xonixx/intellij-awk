BEGIN {
	Quarter_pi = 3.1415927 / 4
	print sin(Quarter_pi)

	f = "sin"
	print @f(Quarter_pi)

	print substr("abcdefgh", 2, 3)
	f = "substr"
	print @f("abcdefgh", 2, 3)
}
