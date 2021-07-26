# printf with multi-byte text encoding, %c and %s, width and precision, and left-alignment.
{
	count = 1

	print NR, count++, "printf %c " $0
	printf "%d:%d: |%c|\n", NR, count++, $0
	printf "%d:%d: |%1c|\n", NR, count++, $0
	printf "%d:%d: |%3c|\n", NR, count++, $0
	# precision is ignored by %c.
	printf "%d:%d: |%3.1c|\n", NR, count++, $0
	printf "%d:%d: |%3.5c|\n", NR, count++, $0
	print NR, count++, "printf %-c " $0
	printf "%d:%d: |%-c|\n", NR, count++, $0
	printf "%d:%d: |%-1c|\n", NR, count++, $0
	printf "%d:%d: |%-3c|\n", NR, count++, $0
	# precision is ignored by %c.
	printf "%d:%d: |%-3.1c|\n", NR, count++, $0
	printf "%d:%d: |%-3.5c|\n", NR, count++, $0
	printf ORS

	print NR, count++, "printf %s " $0
	printf "%d:%d: |%s|\n", NR, count++, $0
	printf "%d:%d: |%1s|\n", NR, count++, $0
	printf "%d:%d: |%3s|\n", NR, count++, $0
	printf "%d:%d: |%3.1s|\n", NR, count++, $0
	printf "%d:%d: |%3.5s|\n", NR, count++, $0

	print NR, count++, "printf %-s " $0
	printf "%d:%d: |%-s|\n", NR, count++, $0
	printf "%d:%d: |%-1s|\n", NR, count++, $0
	printf "%d:%d: |%-3s|\n", NR, count++, $0
	printf "%d:%d: |%-3.1s|\n", NR, count++, $0
	printf "%d:%d: |%-3.5s|\n", NR, count++, $0
	printf ORS ORS
}
