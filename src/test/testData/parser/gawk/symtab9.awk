BEGIN {
	file = "testit.txt"
	for (i = 1; i <= 3; i++)
		print("line", i) > file
	close(file)

	ARGV[1] = file
	ARGC = 2

	for (i = 1; i <= 3; i++)
		getline

	printf "NR should be 3, is %d\n", SYMTAB["NR"]

	# Can't do this here. Windows doesn't let you remove a file that
	# is still open. Moving it to END won't help either, since the file
	# (correctly) remain open until after the END finishes.
	# system("rm testit.txt")
}
