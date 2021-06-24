BEGIN {
	PROCINFO["NONFATAL"]
	# note the bad characters in the hostname
	print |& "/inet/tcp/0/1.2.3.4.5/25"
	print (ERRNO != "")
}
