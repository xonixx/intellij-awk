# Mon Jan 31 09:57:30 IST 2005
# test both dfa and regex matchers on \B
# tests from Stepan Kasal, kasal@ucw.cz
BEGIN {

	print ("  " ~ / \B /)	# test dfa matcher
	print ("a b" ~ /\B/)
	print (" b" ~ /\B/)
	print ("a " ~ /\B/)

	a = "  "
	gsub(/\B/, "x", a)	# test regex matcher
	print a
}
