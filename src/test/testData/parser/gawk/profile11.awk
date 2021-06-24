
# comments/for.awk
BEGIN {
	for (i = 1; i <= 10; i++) print i

	for (i = 1; i <= 10; i++)	# comment 0
		print i

	for (i = 1; # comment 1a
		i <= 10; i++) print i

	for (i = 1; i <= 10; # comment 2a
			i++) print i

	for (i = 1;	# comment 1b
		i <= 10;	# comment 2b
		i++) print i

	for (i = 1;	# comment 1c
		i <= 10;	# comment 2c
		i++)	# comment 3c
		print i
}

# comments/for0.awk
BEGIN {
	for (iggy in foo)	# comment 5
		# comment 6
		;
}

# comments/for1.awk
BEGIN {
	for (iggy in foo)	# comment 1
		# comment 2
	{
		print iggy
	}

	for (iggy in foo)	# comment 3
		# comment 4
		print iggy

	for (iggy in foo)	# comment 5
		# comment 6
		;
}

# comments/for2.awk
BEGIN {
	for (;;) print i

	for (;;)	# comment 0
		print i

	for (; # comment 1a
		;) print i

	for (; ; # comment 2a
			) print i

	for (;	# comment 1b
		;	# comment 2b
		) print i

	for (;	# comment 1c
		;	# comment 2c
		)	# comment 3c
		print i
}

# comments/for_del.awk
BEGIN { for (iggy in foo) delete foo[iggy] }

# comments/do.awk
BEGIN {
	do	# DO comment
	{	# LBRACE comment
		# block comment
		print 42
	} # rbrace comment
	while (0)	# WHILE comment
}

# comments/do2.awk
BEGIN {
	do	# DO comment
	{	# LBRACE comment
		# block comment
		print 42
	} # rbrace comment
	while (0)
}

# comments2/do.awk
BEGIN {
	do  # do comment
	{	# lbrace comment
		# block comment
		print 42
	} # rbace EOL comment
	# rbrace block comment
	while (1)	# while comment
}

# comments2/if.awk
BEGIN {
	if (a)	# IF comment
		print "foo"	# print comment

	if (a)	# IF comment 2
	{	# lbrace comment
		print "bar"
	}
	else	# ELSE comment
		print "baz"
}

# comments/if0.awk
BEGIN {
	if (a)
		; # nothing
	else
		print "b"
}

# comments/switch.awk
BEGIN {
	a = 5
	switch (a)	# switch EOL comment
		# switch block comment
	{		# lbrace EOL comment
		# lbrace block comment
	case 5:	# comment after case
		print "five!"
		break
	# block comment after case
	default:	# comment after default
		print "default"		# print comment
		break
	}	# rbrace EOL comment
	# rbrace block comment
}

# comments2/switch.awk
BEGIN {
	a = 5
	switch (a)	# switch EOL comment
		# switch block comment
	{		# lbrace EOL comment
		# lbrace block comment
	case 5:
		print "five!"
		break;
	# block comment after case
	}	# rbrace EOL comment
	# rbrace block comment
}

# comments2/switch0.awk
BEGIN {
	a = 5
	switch (a)
	{
	case 5: # case comment
		print "five!"
		break
    default:    # default comment
        print "default"
        break
	}
}

# comments2/switch1.awk
BEGIN {
	a = 5
	switch (a)
	{
	case 5:
        # case comment
		print "five!"
		break
    default:    # default comment
        print "default"
        break
	}
}

# comments2/while.awk
BEGIN {
	while (1)	# while comment
	{	# lbrace comment
		# block comment
		print 42
	}
}

# comments2/while2.awk
BEGIN {
	while (1)	# while comment
	{	# lbrace comment
		# block comment
	}
}

# comments2/f.awk
function bar(p1,
	p2)
{
	print "foo"
}	# rbrace eol bar
	# rbrace block bar

# comments2/function.awk
function baz(p1, # comment
	p2)
	# comment before braces
{	# lbrace eol
	# lbrace block
	print "foo"
}	# rbrace eol baz
	# rbrace block baz

# comments/function.awk
function funny(param1,	# param comment 1
		param2, param3,	# param comment 2
		param4)
	# Comment between header and body
{	# lbrace EOL comment
	# lbrace block comment
	print "funny"
}	# rbrace EOL comment funny
	# rbrace block comment funny

# comments/function2.awk
function funnyhaha(param1,
		param2, param3,
		param4)
{	# lbrace EOL comment
	# lbrace block comment
	print "funny"
}	# rbrace EOL comment funnyhaha
	# rbrace block comment funnyhaha

# comments/callcoma.awk
function callme(a, b, c)
{
	printf("a = %s, b = %s, c = %s\n",	# format comment
		a,	# a2 comment
		b,	# b2 comment
		c)
}

BEGIN {
	callme(1,	# 1 comment
		2, # 2 comment
		3)
}

# comments/exp.awk
/foo/,  # range comment
        # range comment 2

# range comment b

# range comment c
/bar/   { print }

# comments/load.awk
@load "filefuncs" 	# get file functions

BEGIN {
	stat("/etc/passwd", data)
	for (i in data)
		print i, data[i]
}

# comments/andor.awk
BEGIN {
	if (a &&	# and comment
		b ||	# or comment
		c)
		print "foo"
}

# comments/qmcol-qm.awk
BEGIN {
	a = 1 ? # qm comment
		2 :
		3
	print a
}

# comments/qmcol-colon.awk
BEGIN {
	a = 1 ?
		2 : # colon comment
		3
	print a
}

# comments/qmcolboth.awk
BEGIN {
	a = 1 ? # qm comment
		2 : # colon comment
		3
	print a
}

# test beginning of line block comments (com2.awk)
BEGIN {
	print "hi" # comment 1
# comment 2
	print "there"

	if (foo) {
		print "hello" # comment 3
# comment 4
 		print "world"
	}
}
