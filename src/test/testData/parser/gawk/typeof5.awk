BEGIN {
	print typeof($0)
	print typeof($1)
}

{
	$3 = $1
	print typeof($2)
	print typeof($3)
}
