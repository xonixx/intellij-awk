BEGIN {
    Doc=""
}

/^<\/dl>/ && !Typeof { Content=0 }
/^<dl/    && !Typeof { Content=1; next }
/^<dt>/ && !Typeof  {
    Name = substr($0, 11, index($0,"(")-11)
    Typeof = "typeof"==Name
    if (Gawk = (index($0,"#")>0))
        sub(/ +#/,"")
}
Content             { Doc = Doc "\n# " $0 }

/<\/dd>/ && Name && !Typeof    { closeItem() }
NR==152 && Typeof              { closeItem() }

function closeItem() {
    print Doc
    Doc = ""
    print "function " (Gawk ? "gawk" : "awk") "::" Name "() {}"
}

# TODO sprintf format chars
# TODO strftime format chars
# TODO mark gawk-only functions
# TODO links in docs
# TODO remove <span id="index-sub_0028_0029-function-2"></span>
# TODO awk bitwise,type mark as gawk