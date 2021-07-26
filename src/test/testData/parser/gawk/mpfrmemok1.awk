# This program tests that -M works with profiling.
# It does not do anything real, but there should not be glibc memory
# errors and it should be valgrind-clean too.

BEGIN {
	v = 0x0100000000000000000000000000000000
}
