@namespace "1foo"
@namespace "for"
@namespace "42f"
@namespace "ab#d"

BEGIN {
	foo75::bar = 57
	if::junk = 1
	foo::match = 3
}

@namespace "foo"
function gsub () {
	print "foo::gsub"
}
