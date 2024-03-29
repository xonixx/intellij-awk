BEGIN {
    HtmlFolder="std_awk_html"
    Doc=""
    Base="https://www.gnu.org/software/gawk/manual/html_node/"

    if ("getline" == Stmt || "printf" == Stmt) { closeItem(); exit }
}

{ sub(/<\/pre><pre class="example">/,"") } # unsplit code blocks

Stmt && /<h4/            { Content=1; next }
Stmt && Content &&/<hr>/ { Content=0; closeItem(); exit }

/^<\/dl>/     && !Nested { Content=0 }
/^<dt( id='[a-z0-9_-]+')?><span><code>/ && !Nested { Content=1 }

# isarray after typeof()
# RLENGTH after PROCINFO
(/^<p><code>isarray\(\)<\/code>/ ||
/<code>RLENGTH<\/code>/) && Nested  { closeItem(); Nested=0 }

/^<dt/        && !Nested {
    sub(/ +#/,"")
    start=index($0,"<code>")+6
    if (Vars) {
        # extract var name
        sub(/<code><code>/,"<code>")
        sub(/<\/code><\/code>/,"</code>")
        Name = substr($0, start, index($0,"</code>")-start)
        Nested = "PROCINFO"==Name
    } else {
        # extract function name
        Name = substr($0, start, index($0,"(")-start)
        Nested = "typeof"==Name
    }
}
/^<pre class="example">/ { Code=1 }
/^<\/pre>/               { Code=0 }
Content                  { appendDocLine($0) }

/<\/dd>/ && Name && !Nested    { closeItem() }

function appendDocLine(l,   l1) {
    l1 = cleanupHtml(processCode(processUrls(indentCode(l))))
    #    print "l1="l1
    if (!l || l1)
        Doc = Doc "\n# " l1
}

function cleanupHtml(line) {
    gsub(/<span id=".+"><\/span>/,"",line)
    gsub(/<a href='.+' class='copiable-anchor'> &para;<\/a>/,"",line)
    gsub(/ id='[^']+'/,"",line)
    gsub(/<span><code>/,"<code>",line)
    gsub(/<\/code><\/span>/,"</code>",line)
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
        appendPartOfFileToDoc2(HtmlFolder "/Control-Letters.html")
        appendDocLine("<br>")
        appendPartOfFileToDoc2(HtmlFolder "/Format-Modifiers.html")
    } else if (Stmt=="getline") {
        appendPartOfFileToDoc(HtmlFolder "/Getline.html",
            "<p>The .+ command returns 1",
            "<p>If .+ indicates that the I/O")
        appendDocLine("<br>")
        appendPartOfFileToDoc(HtmlFolder "/Getline-Summary.html",
            "<table",
            "<div")
    } else if (Name=="strftime") {
        appendDocLine("<br>")
        appendDocLine("<h3>Format-Control Letters</h3>")
        appendPartOfFileToDoc(HtmlFolder "/Time-Functions.html",
            "<code>strftime\\(\\)</code> function allows you",
            "<p>Additionally, the alternative representations")
    } else if (Name=="system") {
        gsub(/<a href="[^"]+">Table [0-9]+\.[0-9]+<\/a>/,"table below",Doc)
        gsub(/Table [0-9]+\.[0-9]+:/,"Table:",Doc)
    }
    sub(/<\/div>$/,"",Doc)
    sub(/<table/,"<table width='100%'",Doc)
    print Doc
    Doc = ""
    if (Stmt)
        print "function stmt::" Stmt "() {}"
    else # TODO shell we redo Gawk-specific determination by '#'?
        print Vars ? (Name ~ /^(BINMODE|FIELDWIDTHS|FPAT|IGNORECASE|LINT|PREC|ROUNDMODE|TEXTDOMAIN|ARGIND|ERRNO|FUNCTAB|PROCINFO|RT|SYMTAB)$/ ?
        "gawk" : "awk") "::" Name " = \"\"" : "function " (Name ~ /^(asort|asorti|gensub|patsplit|strtonum|mktime|strftime|systime|and|compl|lshift|or|rshift|xor|isarray|typeof|bindtextdomain|dcgettext|dcngettext)$/ ?
        "gawk" : "awk") "::" Name "() {}"
}

function appendPartOfFileToDoc(fName,regexFromIncl,regexToExcl,   l,content) {
    while ((getline l < fName)>0) {
        if (content && l ~ regexToExcl) break
        if (!content && l ~ regexFromIncl) content=1
        if (content)
            appendDocLine(l)
    }
}

function appendPartOfFileToDoc2(fName,   l,content) {
    while ((getline l < fName)>0) {
        if ("<hr>"==l) {
            getline l < fName
            if ("<div class=\"header\">"==l) break
        }
        if (!content && l ~ /<h4/) {
            content=1
            #                print "here ", l
            gsub(/h4/,"h3",l)
            gsub(/([0-9]+\.)+[0-9]+ */,"",l) # remove section number
            #                print "here1", l
        }
        if (content)
            appendDocLine(l)
    }
    sub(/<\/div>$/,"",Doc)
}
