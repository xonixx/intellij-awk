BEGIN {
	printf "hello\n"  > "/dev/stderr"
	printf("hello\n") > "/dev/stderr"
}
