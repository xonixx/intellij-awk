BEGIN {
	PROCINFO["NONFATAL"]
	# valid host but bogus port
	print |& "/inet/tcp/0/localhost/0"
	print ERRNO != ""
}
