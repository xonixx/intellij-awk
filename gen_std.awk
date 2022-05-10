BEGIN {
    Doc=""
    Base="https://www.gnu.org/software/gawk/manual/html_node/"

    if ("printf" == Stmt) { closeItem(); exit }
}

{ sub(/<\/pre><pre class="example">/,"") } # unsplit code blocks

Stmt && /<h4/            { Content=1; next }
Stmt && Content &&/<hr>/ { Content=0; closeItem(); exit }

/^<\/dl>/     && !Nested { Content=0 }
/^<dt><code>/ && !Nested { Content=1 }
/^<dt>/       && !Nested {
    sub(/ +#/,"")
    if (Vars) {
        sub(/<code><code>/,"<code>")
        sub(/<\/code><\/code>/,"</code>")
        Name = substr($0, 11, index($0,"</code>")-11)
        Nested = "PROCINFO"==Name
    } else {
        Name = substr($0, 11, index($0,"(")-11)
        Nested = "typeof"==Name
    }
}
/^<pre class="example">/ { Code=1 }
/^<\/pre>/               { Code=0 }
Content                  { appendDocLine($0) }

/<\/dd>/ && Name && !Nested    { closeItem() }
Nested && ("typeof"==Name ? NR==152 : NR==522) { closeItem(); Nested=0 }

function appendDocLine(l,   l1) {
    l1 = rmSpanId(processCode(processUrls(indentCode(l))))
    if (!l || l1)
        Doc = Doc "\n# " l1
}

function rmSpanId(line) {
    gsub(/<span id=".+"><\/span>/,"",line)
    return line
}

function processCode(line) {
    gsub(/<div class="example"/,"<div class=\"example\" style=\"border: 1px dashed #888888; padding-left: 5px\"",line)
    return line
}

function indentCode(line,   n,newWs) {
    if (Code) {
        for(n=1; substr(line,n,1)==" "; n++) {
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
    } else if (Name=="ARGC") {
        print Doc
        print "awk::ARGV = \"\""
    } else if (Name=="sprintf" || Stmt=="printf") {
        if (Stmt=="printf")
            appendDocLine("<dt><code>printf format, item1, item2, …</code></dt>")
        else
            appendDocLine("<br>")
        appendPartOfFileToDoc("temp/Control-Letters.html",70,236)
        appendDocLine("<br>")
        appendPartOfFileToDoc("temp/Format-Modifiers.html",70,280)
    } else if (Name=="strftime") {
        appendDocLine("<br>")
        appendDocLine("<h3>Format-Control Letters</h3>")
        appendPartOfFileToDoc("temp/Time-Functions.html",181,401)
    } else if (Name=="system") {
        gsub(/<a href="[^"]+">Table [0-9]+\.[0-9]+<\/a>/,"table below",Doc)
        gsub(/Table [0-9]+\.[0-9]+:/,"Table:",Doc)
    }
    print Doc
    Doc = ""
    if (Stmt)
        print "function stmt::" Stmt "() {}"
    else
        print Vars ? (Name ~ /^(BINMODE|FIELDWIDTHS|FPAT|IGNORECASE|LINT|PREC|ROUNDMODE|TEXTDOMAIN|ARGIND|ERRNO|FUNCTAB|PROCINFO|RT|SYMTAB)$/ ?
        "gawk" : "awk") "::" Name " = \"\"" : "function " (Name ~ /^(asort|asorti|gensub|patsplit|strtonum|mktime|strftime|systime|and|compl|lshift|or|rshift|xor|isarray|typeof|bindtextdomain|dcgettext|dcngettext)$/ ?
        "gawk" : "awk") "::" Name "() {}"
}

function appendPartOfFileToDoc(fName,nrFrom,nrTo,   l,nr) {
    while ((getline l < fName)>0) {
        nr++
        if (nr>=nrFrom && nr<=nrTo) {
            if (l ~ /<h4/) {
#                print "here ", l
                gsub(/h4/,"h3",l)
                gsub(/([0-9]+\.)+[0-9]+ */,"",l) # remove section number
#                print "here1", l
            }
            appendDocLine(l)
        }
    }
}
