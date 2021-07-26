@namespace "foo"

function test(v)
{
	if (v <= 0)
		return

	Level++
	v--
	printf("Level = %d, v = %d\n", Level, v)
	test(v)
	Level--
}

BEGIN {
	Level = 0
	test(5)
}
