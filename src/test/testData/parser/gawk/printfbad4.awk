BEGIN {
	for (i = 1; i <= 10; i++) {
		printf "%03$*d %2$d \n", 4, 5, i
	}
}
