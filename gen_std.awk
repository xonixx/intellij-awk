BEGIN {
    Doc=""
}

/^<dt>/   {
    Name=substr($0, 11, index($0,"(")-11)
    if (Gawk=index($0,"#")>0)
        sub(/ +#/,"")
}
Content   { Doc = Doc "\n# " $0 }

/<\/dd>/ { closeItem() }

/^<\/dl>/ { Content=0 }
/^<dl/    { Content=1 }


function closeItem() {
    print Doc
    Doc = ""
    print "function " (Gawk ? "gawk" : "awk") "::" Name "() {}"
}