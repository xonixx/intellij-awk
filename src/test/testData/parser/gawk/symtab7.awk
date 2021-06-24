BEGIN {
	getline
	for (i = 1; i <= NF;++i)
		SYMTAB[$i] = i
}

{ print $Age }
