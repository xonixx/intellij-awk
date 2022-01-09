BEGIN {
    Doc=""
    Base="https://www.gnu.org/software/gawk/manual/html_node/"
}

/^<\/dl>/ && !Typeof { Content=0 }
/^<dl/    && !Typeof { Content=1; next }
/^<dt>/ && !Typeof  {
    Name = substr($0, 11, index($0,"(")-11)
    Typeof = "typeof"==Name
    sub(/ +#/,"")
}
/^<pre class="example">/ { Code=1 }
/^<\/pre>/               { Code=0 }
Content             { Doc = Doc "\n# " rmSpanId(processCode(processUrls(indentCode($0)))) }

/<\/dd>/ && Name && !Typeof    { closeItem() }
NR==152 && Typeof              { closeItem() }

function rmSpanId(line) {
    if (gsub(/<span id=".+"><\/span>/,"",line) && !line) next
    return line
}

function processCode(line) {
    gsub(/<div class="example"/,"<div class=\"example\" style=\"border: 1px dashed #888888; padding-left: 5px\"",line)
    return line
}

function indentCode(line,   n,newWs) {
    if (Code) {
        for(n=1;substr(line,n,1)==" ";n++) {
            newWs = newWs "&nbsp;"
        }
        return newWs substr(line,n)
    } else
        return line
}

function processUrls(line) {
    gsub(/<a href="/, "<a href=\"" Base, line)
    gsub(/<a id=.+<\/sup><\/a>/,"",line)
    return line
}

function closeItem() {
    if (Name=="asorti") {
        print Doc
        print "function gawk::asort() {}"
    }
    print Doc
    Doc = ""
    print "function " (Name ~ /^(asort|asorti|gensub|patsplit|strtonum|mktime|strftime|systime|and|compl|lshift|or|rshift|xor|isarray|typeof|bindtextdomain|dcgettext|dcngettext)$/ ?
    "gawk" : "awk") "::" Name "() {}"
}

# TODO sprintf format chars
# TODO strftime format chars
# TODO mark gawk-only functions