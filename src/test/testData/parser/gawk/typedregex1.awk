# This file describes the semantics for hard regex constants
# As much as possible it's executable code so that it can be used
# (or split into) test cases for development and regression testing.

function simple_tests(	fbre, numresult, strresult)
{
	# usable as case value
	switch ("foobaaar") {
	case @/fo+ba+r/:
		print "switch-case: ok"
		break
	default:
		print "switch-case: fail"
		break
	}

	# usable with ~ and !~
	if ("foobaaar" ~ @/fo+ba+r/)
		print "match ~: ok"
	else
		print "match ~: fail"

	if ("quasimoto" !~ @/fo+ba+r/)
		print "match !~: ok"
	else
		print "match !~: fail"

	# assign to variable, use in match
	fbre = @/fo+ba+r/
	if ("foobaaar" ~ fbre)
		print "variable match ~: ok"
	else
		print "variable match ~: fail"

	if ("quasimoto" !~ fbre)
		print "variable match !~: ok"
	else
		print "variable match !~: fail"

	# Use as numeric value, should be zero
	numresult = fbre + 42
	if (numresult == 42)
		print "variable as numeric value: ok"
	else
		print "variable as numeric value: fail"

	# Use as string value, should be string value of regexp text
	strresult = "<" fbre ">"
	if (strresult == "<fo+ba+r>")
		print "variable as string value: ok"
	else
		print "variable as string value: fail", strresult

	# typeof should work
	if (typeof(@/fo+ba+r/) == "regexp")
		print "typeof constant: ok"
	else
		print "typeof constant: fail"

	if (typeof(fbre) == "regexp")
		print "typeof variable: ok"
	else
		print "typeof variable: fail"

	# conversion to number, works. should it be fatal?
	fbre++
	if (fbre == 1)
		print "conversion to number: ok"
	else
		print "conversion to number: fail"

	if (typeof(fbre) == "number")
		print "typeof variable after conversion: ok"
	else
		print "typeof variable after conversion: fail"
}

function match_tests(	fbre, fun)
{
	if (match("foobaaar", @/fo+ba+r/))
		print "match(constant): ok"
	else
		print "match(constant): fail"

	fbre = @/fo+ba+r/
	if (match("foobaaar", fbre))
		print "match(variable): ok"
	else
		print "match(variable): fail"

	fun = "match"
	if (@fun("foobaaar", @/fo+ba+r/))
		print "match(constant) indirect: ok"
	else
		print "match(constant) indirect: fail"

	if (@fun("foobaaar", fbre))
		print "match(variable) indirect: ok"
	else
		print "match(variable) indirect: fail"
}

function sub_tests(	fbre, count, target, fun)
{
	target = "abc foobaar def foobar ghi"
	count = sub(@/fo+ba+r/, "XX", target)
	if (count == 1 && target == "abc XX def foobar ghi")
		print "sub(constant): ok"
	else
		print "sub(constant): fail"

	fbre = @/fo+ba+r/
	target = "abc foobaar def foobar ghi"
	count = sub(fbre, "XX", target)
	if (count == 1 && target == "abc XX def foobar ghi")
		print "sub(variable): ok"
	else
		print "sub(variable): fail"

	fun = "sub"
	$0 = "abc foobaar def foobar ghi"
	count = @fun(@/fo+ba+r/, "XX")
	if (count == 1 && $0 == "abc XX def foobar ghi")
		print "sub(constant) indirect: ok"
	else
		print "sub(constant) indirect: fail"

	$0 = "abc foobaar def foobar ghi"
	count = @fun(fbre, "XX")
	if (count == 1 && $0 == "abc XX def foobar ghi")
		print "sub(variable) indirect: ok"
	else
		print "sub(variable) indirect: fail"
}

function gsub_tests(	fbre, count, target, fun)
{
	target = "abc foobaar def foobar ghi"
	count = gsub(@/fo+ba+r/, "XX", target)
	if (count == 2 && target == "abc XX def XX ghi")
		print "gsub(constant): ok"
	else
		print "gsub(constant): fail"

	fbre = @/fo+ba+r/
	target = "abc foobaar def foobar ghi"
	count = gsub(fbre, "XX", target)
	if (count == 2 && target == "abc XX def XX ghi")
		print "gsub(variable): ok"
	else
		print "gsub(variable): fail"

	fun = "gsub"
	$0 = "abc foobaar def foobar ghi"
	count = @fun(@/fo+ba+r/, "XX")
	if (count == 2 && $0 == "abc XX def XX ghi")
		print "gsub(constant) indirect: ok"
	else
		print "gsub(constant) indirect: fail"

	$0 = "abc foobaar def foobar ghi"
	count = @fun(fbre, "XX")
	if (count == 2 && $0 == "abc XX def XX ghi")
		print "gsub(variable) indirect: ok"
	else
		print "gsub(variable) indirect: fail"
}

function gensub_tests(	fbre, result, target, fun)
{
	target = "abc foobaar def foobar ghi"
	result = gensub(@/fo+ba+r/, "XX", "g", target)
	if (result == "abc XX def XX ghi")
		print "gensub(constant): ok"
	else
		print "gensub(constant): fail"

	fbre = @/fo+ba+r/
	target = "abc foobaar def foobar ghi"
	result = gensub(fbre, "XX", "g", target)
	if (result == "abc XX def XX ghi")
		print "gensub(variable): ok"
	else
		print "gensub(variable): fail"

	fun = "gensub"
	$0 = "abc foobaar def foobar ghi"
	result = @fun(@/fo+ba+r/, "XX", "g")
	if (result == "abc XX def XX ghi")
		print "gensub(constant) indirect: ok"
	else
		print "gensub(constant) indirect: fail"

	$0 = "abc foobaar def foobar ghi"
	result = @fun(fbre, "XX", "g")
	if (result == "abc XX def XX ghi")
		print "gensub(variable) indirect: ok"
	else
		print "gensub(variable) indirect: fail"

	result = @fun(@/fo+ba+r/, "XX", "g", target)
	if (result == "abc XX def XX ghi")
		print "gensub(constant) indirect 2: ok"
	else
		print "gensub(constant) indirect 2: fail"

	result = @fun(fbre, "XX", "g", target)
	if (result == "abc XX def XX ghi")
		print "gensub(variable) indirect 2: ok"
	else
		print "gensub(variable) indirect 2: fail"
}

function split_tests(	fbre, data, seps, fun, b1)
{
	delete data
	delete seps
	b1 = split("a:b:c:d", data, @/:/, seps)
	if (b1 == 4 && data[1] == "a" && seps[1] == ":")
		print "split(constant): ok"
	else
		print "split(constant): fail"

	delete data
	delete seps
	fbre = @/:/
	b1 = split("a:b:c:d", data, fbre, seps)
	if (b1 == 4 && data[1] == "a" && seps[1] == ":")
		print "split(variable): ok"
	else
		print "split(variable): fail"

	fun = "split"
	delete data
	delete seps
	b1 = @fun("a:b:c:d", data, @/:/, seps)
	if (b1 == 4 && data[1] == "a" && seps[1] == ":")
		print "split(constant) indirect: ok"
	else
		print "split(constant) indirect: fail"

	delete data
	delete seps
	b1 = @fun("a:b:c:d", data, fbre, seps)
	if (b1 == 4 && data[1] == "a" && seps[1] == ":")
		print "split(variable) indirect: ok"
	else
		print "split(variable) indirect: fail"
}

function patsplit_tests(	fbre, data, seps, fun, b1)
{
	delete data
	delete seps
	b1 = patsplit("a:b:c:d", data, @/[a-z]+/, seps)
	if (b1 == 4 && data[1] == "a" && seps[1] == ":")
		print "patsplit(constant): ok"
	else
		print "patsplit(constant): fail"

	delete data
	delete seps
	fbre = @/[a-z]+/
	b1 = patsplit("a:b:c:d", data, fbre, seps)
	if (b1 == 4 && data[1] == "a" && seps[1] == ":")
		print "patsplit(variable): ok"
	else
		print "patsplit(variable): fail"

	fun = "patsplit"
	delete data
	delete seps
	b1 = @fun("a:b:c:d", data, @/[a-z]+/, seps)
	if (b1 == 4 && data[1] == "a" && seps[1] == ":")
		print "patsplit(constant) indirect: ok"
	else
		print "patsplit(constant) indirect: fail"

	delete data
	delete seps
	b1 = @fun("a:b:c:d", data, fbre, seps)
	if (b1 == 4 && data[1] == "a" && seps[1] == ":")
		print "patsplit(variable) indirect: ok"
	else
		print "patsplit(variable) indirect: fail"
}

BEGIN {
	simple_tests()
	match_tests()
	sub_tests()
	gsub_tests()
	gensub_tests()
	split_tests()
	patsplit_tests()
}
