@load "filefuncs"

function foo()
{
	print "foo!"
}

BEGIN {
	f = FUNCTAB["foo"]
	@f()

	# Do the two stats one after the other, and use ".." instead
	# of "." to avoid race conditions seen using ".".
	ret1 = stat("..", data1)

	f = "stat"
	ret2 = @f("..", data2)

	print "ret1 =", ret1
	print "ret2 =", ret2

	problem = 0
	for (i in data1) {
		if (! isarray(data1[i])) {
#			print i, data1[i]
			if (! (i in data2) || data1[i] != data2[i]) {
				printf("mismatch element \"%s\"\n", i)
				problems++
			}
		}
	}
	print(problems ? (problems+0) "encountered" : "no problems encountered")
}
