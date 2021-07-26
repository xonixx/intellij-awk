# NOTE: This program is not a generalized parser for the output of 'ls'.
# It's job is to read the output of ls from the gawk source code directory,
# where we know there are no files with spaces in their file names, etc.
BEGIN {
	# analyze results from readdir extension
	while ((getline x < extout) > 0) {
		numrec++
		if ((split(x, f, "/") == 3) && (f[3] == "u"))
			num_unknown++
	}
	close(extout)
	if ((numrec > 0) && (num_unknown == numrec)) {
		print "Notice: this filesystem does not appear to support file type information" > "/dev/stderr"
		ftype_unknown = 1
	}
}

BEGIN {
	for (i = 1; (getline < dirlist) > 0; i++) {
		# inode number is $1, filename is read of record
		inode = $1
		$1 = ""
		$0 = $0
		sub(/^ */, "")
		names[i] = $0
		ino[names[i]] = inode
	}
	close(dirlist)

	for (j = 1; (getline < longlist) > 0; j++) {
		type_let = substr($0, 1, 1)
		if (type_let == "-")
			type_let = "f"
		if (type_let == "l")
			type[$(NF-2)] = type_let
		else
			type[$NF] = type_let
	}
	close(longlist)

	if (i != j)
		printf("mismatch: %d from `ls -afi' and %d from `ls -lna'\n", i, j) > "/dev/stderr"
	
	for (i = 1; i in names; i++)
		printf("%s/%s/%s\n", ino[names[i]], names[i], (ftype_unknown ? "u" : type[names[i]]))
}
