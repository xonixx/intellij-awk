        # xref.awk - cross reference an awk program

	# 12/2010: Modified for gawk test suite to use a variable
	# for the sort command and to use `sort -k1' instead of `sort +1'

        BEGIN {
		if (sortcmd == "") sortcmd = "sort"		# "sort -k1"

                # create array of keywords to be ignored by lexer
                asplit("BEGIN:END:atan2:break:close:continue:cos:delete:" \
                        "do:else:exit:exp:for:getline:gsub:if:in:index:int:"  \
                        "length:log:match:next:print:printf:rand:return:sin:" \
                        "split:sprintf:sqrt:srand:sub:substr:system:while",
                        keywords,":")

                # build the symbol-state table
                split("00:00:00:00:00:00:00:00:00:00:" \
                          "20:10:10:12:12:11:07:00:00:00:" \
                          "08:08:08:08:08:33:08:00:00:00:" \
                          "08:44:08:36:08:08:08:00:00:00:" \
                          "08:44:45:42:42:41:08",machine,":")

                # parse the input and store an intermediate representation
                # of the cross-reference information

                # set up the machine
                state = 1

                # run the machine
                for (;;) {

                        # get next symbol
                        symb = lex()
                        nextstate = substr(machine[state symb],1,1)
                        act = substr(machine[state symb],2,1)

                        # perform required action
                        if ( act == "0" )
                                ; # do nothing
                        else if ( act == "1" ) {
                                if ( ! inarray(tok,names) )
                                        names[++nnames] = tok
                                lines[tok,++xnames[tok]] = NR }
                        else if ( act == "2" ) {
                                if ( tok in local ) {
                                        tok = tok "(" funcname ")"
                                        if ( ! inarray(tok,names) )
                                                names[++nnames] = tok
                                        lines[tok,++xnames[tok]] = NR }
                                else {
                                        tok = tok "()"
                                        if ( ! inarray(tok,names) )
                                                names[++nnames] = tok
                                        lines[tok,++xnames[tok]] = NR } }
                        else if ( act == "3" ) {
                                funcname = tok
                                flines[tok] = NR }
                        else if ( act == "4" )
                                braces++
                        else if ( act == "5" ) {
                                braces--
                                if ( braces == 0 ) {
                                        for ( temp in local )
                                                delete local[temp]
                                        funcname = ""
                                        nextstate = 1 } }
                        else if ( act == "6" ) {
                                local[tok] = 1 }
                        else if ( act == "7" )
                                break
                        else if ( act == "8" ) {
                                print "error: xref.awk: line " NR ": aborting" \
                                        > "/dev/con"
                                exit 1 }

                        # finished with current token
                        state = nextstate }

                # finished parsing, now ready to print output
                for ( i = 1; i <= nnames; i++ ) {
                        printf "%d ", xnames[names[i]] | sortcmd
                        if ( index(names[i],"(") == 0 )
                                printf "%s(%d)", names[i], flines[names[i]] | sortcmd
                        else
                                printf "%s", names[i] | sortcmd
                        for ( j = 1; j <= xnames[names[i]]; j++ )
                                if ( lines[names[i],j] != lines[names[i],j-1] )
                                        printf " %d", lines[names[i],j] | sortcmd
                        printf "\n" | sortcmd }

			close(sortcmd)
                } # END OF PROGRAM

        function asplit(str,arr,fs,  n) { n = split(str,temp_asplit,fs)
                for ( i = 1; i <= n; i++ ) arr[temp_asplit[i]]++ }

        function inarray(val,arr,  j, tmp) {
            for ( j in arr )
                tmp[arr[j]]++
            return (val in tmp) }

        function lex() {

                for (;;) {

                        if ( tok == "(eof)" ) return 7

                        while ( length(line) == 0 )
                                if ( getline line == 0 ) {
                                        tok = "(eof)"; return 7 }

                        sub(/^[ \t]+/,"",line)                                # remove white space,
                        sub(/^"([^"]|\\")*"/,"",line)             # quoted strings,
                        sub(/^\/([^\/]|\\\/)+\//,"",line)     # regular expressions,
                        sub(/^#.*/,"",line)                                   # and comments

                        if ( line ~ /^function/ ) {
                                tok = "function"; line = substr(line,9); return 1 }
                        else if ( line ~ /^{/ ) {
                                tok = "{"; line = substr(line,2); return 2 }
                        else if ( line ~ /^}/ ) {
                                tok = "}"; line = substr(line,2); return 3 }
			# change regexes to use posix character classes
                        else if ( match(line,/^[[:alpha:]_][[:alnum:]]*\[/) ) {
                                tok = substr(line,1,RLENGTH-1)
                                line = substr(line,RLENGTH+1)
                                return 5 }
                        else if ( match(line,/^[[:alpha:]_][[:alnum:]]*\(/) ) {
                                tok = substr(line,1,RLENGTH-1)
                                line = substr(line,RLENGTH+1)
                                if ( ! ( tok in keywords ) ) return 6 }
                        else if ( match(line,/^[[:alpha:]_][[:alnum:]]*/) ) {
                                tok = substr(line,1,RLENGTH)
                                line = substr(line,RLENGTH+1)
                                if ( ! ( tok in keywords ) ) return 4 }
                        else {
                                match(line,/^[^[:alpha:]_{}]/)
                                tok = substr(line,1,RLENGTH)
                                line = substr(line,RLENGTH+1) } } }
