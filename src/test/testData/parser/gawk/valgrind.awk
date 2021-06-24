function show()
{
	error_count++
	if (cmd) {
		printf "%s: %s\n", FILENAME, cmd
		cmd = ""
	}
	printf "\t%s\n",$0
}

FNR == 1 {
	error_count = 0
}

{ $1 = "" }

$2 == "Command:" {
	incmd = 1
	$2 = ""
	cmd = $0
	next
}

incmd {
	if (/Parent PID:/)
		incmd = 0
	else {
		cmd = (cmd $0)
		next
	}
}

/ERROR SUMMARY:/ && !/: 0 errors from 0 contexts/ && error_count > 0 {
	show()
}

/definitely lost:/ && !/: 0 bytes in 0 blocks/		{ show() }

# /possibly lost:/ && !/: 0 bytes in 0 blocks/		{ show() }

# / suppressed:/ && !/: 0 bytes in 0 blocks/		{ show() }

/[Ii]nvalid (read|write)/				{ show() }
