
BEGIN {
    Doc=""
}

Content   { Doc = Doc "\n# " $0 }

/^<dt>/   { Name=substr($0, 11, index($0,"(")-11) }
/^<\/dd>/ { closeItem() }

/^<\/dl>/ { Content=0 }
/^<dl/    { Content=1 }


function closeItem() {
   print Doc
   Doc = ""
   print "function awk::" Name "() {}"
}