BEGIN {
	PROCINFO["sorted_in"] = "@val_type_asc"	# okay with PROCINFO commented out, kaboom if not
	IGNORECASE = 1	# yes

	printf("BEGIN -- Symtab is next\n") > "/dev/stdout"
	for (i in SYMTAB) {
		printf "[%s] = %s\n", i, isarray(SYMTAB[i]) ? "<array>" : SYMTAB[i]	# else {printf("[%s]\t(%s)\n",i,SYMTAB[i]);}
	}
	printf("BEGIN-- after Symtab loop\n") > "/dev/stdout"	# never got here

	printf("BEGIN -- Functab is next\n") > "/dev/stdout"
	for (i in FUNCTAB) {
		printf "[%s] = %s\n", i, FUNCTAB[i]	# else {printf("[%s]\t(%s)\n",i,FUNCTAB[i]);}
	}
	printf("BEGIN-- after Functab loop\n") > "/dev/stdout"	# never got here
	exit
}

function foo()
{
	print "foo called"
}

function bar()
{
	print "bar called"
}

# e-o-begin
# --- No END, No Main ... ---
