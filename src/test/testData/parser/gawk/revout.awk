@load "revoutput"

BEGIN {
	REVOUT = 1
	print "hello, world" > "/dev/stdout"
}
