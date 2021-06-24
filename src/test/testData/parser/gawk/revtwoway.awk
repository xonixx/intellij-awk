@load "revtwoway"

BEGIN {
	cmd = "/magic/mirror"

	print "hello, world" |& cmd
	cmd |& getline line

	printf("got back: <%s>, RT = <%s>\n", line, RT)
	close(cmd)
}
