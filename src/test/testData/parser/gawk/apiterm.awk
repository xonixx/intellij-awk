@load "filefuncs"

{
	print $1
	# check whether API terminates field strings properly
	print chdir($1)
	print ERRNO
}
