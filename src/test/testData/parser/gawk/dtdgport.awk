# dtdgport.awk
# Reads an XML document from standard input and
# prints a DTD for this document to standard output.
# http://saxon.sourceforge.net/dtdgen.html
# JK 2004-10-09
# JK 2006-03-05
# JK 2007-08-05 Converted for portability from the original dtd_generator.awk

# The program makes an internal list of all the elements
# and attributes that appear in your document, noting how
# they are nested, and noting which elements contain
# character data.

BEGIN {
  while (getXMLEVENT(ARGV[1])) {
    # Remember each element.
    if ( XMLEVENT == "STARTELEM" ) {
      # Remember the parent names of each child node.
      name[XMLDEPTH] = XMLSTARTELEM
      if (XMLDEPTH>1)
        child[name[XMLDEPTH-1], XMLSTARTELEM] ++
      # Count how often the element occurs.
      elem[XMLSTARTELEM] ++
      # Remember all the attributes with the element.
      for (a in XMLATTR)
        attr[XMLSTARTELEM,a] ++
    }
  }
}

END { print_elem(1, name[1]) }   # name[1] is the root

# Print one element (including sub-elements) but only once.
function print_elem(depth, element,   c, atn, chl, n, i, myChildren) {
  if (already_printed[element]++)
    return 
  indent=sprintf("%*s", 2*depth-2, "")
  myChildren=""
  for (c in child) {
    split(c, chl, SUBSEP)
    if (element == chl[1]) {
      if (myChildren=="")
        myChildren = chl[2]
      else
        myChildren = myChildren " | " chl[2]
    }
  }
  # If an element has no child nodes, declare it as such.
  if (myChildren=="")
    print indent "<!ELEMENT", element , "( #PCDATA ) >"
  else
    print indent "<!ELEMENT", element , "(", myChildren, ")* >"
  # After the element name itself, list its attributes.
  for (a in attr) {
    split(a, atn, SUBSEP)
    # Treat only those attributes that belong to the current element.
    if (element == atn[1]) {
      # If an attribute occured each time with its element, notice this. 
      if (attr[element, atn[2]] == elem[element])
        print indent "<!ATTLIST", element, atn[2], "CDATA #REQUIRED>"
      else
        print indent "<!ATTLIST", element, atn[2], "CDATA #IMPLIED>"
    }
  }
  # Now go through the child nodes of this elements and print them.
  gsub(/[\|]/, " ", myChildren)
  n=split(myChildren, chl)
  for(i=1; i<=n; i++) {
    print_elem(depth+1, chl[i])
    split(myChildren, chl)
  }
}

##
# getXMLEVENT( file ): # read next xml-data into XMLEVENT,XMLNAME,XMLATTR
#                      # referenced entities are not resolved
# Parameters:
#   file       -- path to xml file
# External variables:
#   XMLEVENT   -- type of item read, e.g. "STARTELEM"(tag), "ENDELEM"(end tag),
#                 "COMMENT"(comment), "CHARDATA"(data)
#   XMLNAME    -- value of item, e.g. tagname if type is "STARTELEM" or "ENDELEM"
#   XMLATTR    -- Map of attributes, only set if XMLEVENT=="STARTELEM"
#   XMLPATH    -- Path to current tag, e.g. /TopLevelTag/SubTag1/SubTag2
#   XMLROW     -- current line number in input file
#   XMLERROR   -- error text, set on parse error
# Returns:
#    1         on successful read: XMLEVENT, XMLNAME, XMLATTR are set accordingly
#    ""        at end of file or parse error, XMLERROR is set on error
# Private Data:
#   _XMLIO     -- buffer, XMLROW, XMLPATH for open files
##

function getXMLEVENT( file            ,end,p,q,tag,att,accu,mline,mode,S0,ex,dtd) {
    XMLEVENT=XMLNAME=XMLERROR=XMLSTARTELEM=XMLENDELEM = ""
    split("", XMLATTR)
    S0    = _XMLIO[file,"S0"]
    XMLROW  = _XMLIO[file,"line"];
    XMLPATH = _XMLIO[file,"path"];
    XMLDEPTH=_XMLIO[file,"depth"]+0;
    dtd   = _XMLIO[file,"dtd"];
    while (!XMLEVENT) {
        if (S0 == "") {
            if (1 != (getline S0 < file))
                break;
             XMLROW ++;
             S0 = S0 RS;
        }
        if (mode == "") {
            mline = XMLROW
            accu=""
            p = substr(S0,1,1)
            if (p != "<" && !(dtd && p=="]"))
                mode="CHARDATA"
            else if (p == "]") {
                S0 = substr(S0,2)
                mode="ENDDOCT"
                end=">"
                dtd=0
            } else if ( substr(S0,1,4) == "<!--" ) {
                S0=substr(S0,5)
                mode="COMMENT"
                end="-->"
            } else if ( substr(S0,1,9) == "<!DOCTYPE" ) {
                S0 = substr(S0,10)
                mode = "STARTDOCT"
                end  = ">"
            } else if (substr(S0,1,9) == "<![CDATA[" ) {
                S0 = substr(S0,10)
                mode = "CDA"
                end = "]]>"
            } else if ( substr(S0,1,2) == "<!" ) {
                S0 = substr(S0,3)
                mode = "DEC"
                end = ">"
            } else if (substr(S0,1,2) == "<?") {
                S0 = substr(S0,3)
                mode = "PROCINST"
                end = "?>"
            } else if ( substr(S0,1,2)=="</" ) {
                S0 = substr(S0,3)
                mode = "ENDELEM"
                end = ">";
                tag = S0
                sub(/[ \n\r\t>].*$/,"",tag)
                S0 = substr(S0,length(tag)+1)
                ex = XMLPATH
                sub(/\/[^\/]*$/,"",XMLPATH)
                ex = substr(ex, length(XMLPATH)+2)
                if (tag != ex) {
                    XMLERROR = "unexpected close tag <" ex ">..</" tag ">"
                    break
                }
            } else {
                S0 = substr(S0,2)
                mode = "STARTELEM"
                tag = S0
                sub(/[ \n\r\t\/>].*$/,"",tag)
                S0 = substr(S0, length(tag)+1)
                if (tag !~ /^[A-Za-z:_][0-9A-Za-z:_.-]*$/ ) { # /^[[:alpha:]:_][[:alnum:]:_.-]*$/
                    XMLERROR = "invalid tag name '" tag "'"
                    break
                }
                XMLPATH = XMLPATH "/" tag;
            }
        } else if (mode == "CHARDATA") {                            # terminated by "<" or EOF
            p = index(S0, "<")
            if (dtd && (q=index(S0,"]")) && (!p || q<p) )
                p = q
            if (p) {
                XMLEVENT = "CHARDATA"
                XMLNAME = accu unescapeXML(substr(S0, 1, p-1))
                S0 = substr(S0, p)
                mode = ""
            } else {
                accu = accu unescapeXML(S0)
                S0 = ""
            }
        } else if ( mode == "STARTELEM" ) {
            sub(/^[ \n\r\t]*/,"",S0)
            if (S0 == "") 
                continue
            if (substr(S0, 1, 2) == "/>" ) {
                S0 = substr(S0, 3)
                mode = ""
                XMLEVENT = "STARTELEM"
                XMLNAME = XMLSTARTELEM = tag
                XMLDEPTH ++
                S0 = "</" tag ">" S0
            } else if (substr(S0, 1, 1) == ">" ) {
                S0 = substr(S0, 2)
                mode = ""
                XMLEVENT = "STARTELEM"
                XMLNAME = XMLSTARTELEM = tag
                XMLDEPTH ++
            } else {
                att = S0
                sub(/[= \n\r\t\/>].*$/,"",att)
                S0 = substr(S0, length(att) + 1)
                mode = "ATTR"
                if (att !~ /^[A-Za-z:_][0-9A-Za-z:_.-]*$/ ) { # /^[[:alpha:]:_][[:alnum:]:_.-]*$/
                    XMLERROR = "invalid attribute name '" att "'"
                    break
                }
            }
        } else if (mode == "ATTR") {
            sub(/^[ \n\r\t]*/, "", S0)
            if (S0 == "") 
                continue
            if (substr(S0,1,1) == "=" ) {
                S0 = substr(S0,2)
                mode = "EQ"
            } else {
                XMLATTR[att] = att
                mode = "STARTELEM"
            }
        } else if (mode == "EQ") {
            sub(/^[ \n\r\t]*/,"",S0)
            if (S0 == "") 
              continue
            end = substr(S0,1,1)
            if (end == "\"" || end == "'") {
                S0 = substr(S0,2)
                accu = ""
                mode = "VALUE"
            } else {
                accu = S0
                sub(/[ \n\r\t\/>].*$/,"", accu)
                S0 = substr(S0, length(accu)+1)
                XMLATTR[att] = unescapeXML(accu)
                mode = "STARTELEM"
            } 
        } else if (mode == "VALUE") {                          # terminated by end
            if (p = index(S0, end)) {
                XMLATTR[att] = accu unescapeXML(substr(S0,1,p-1))
                S0 = substr(S0, p+length(end))
                mode = "STARTELEM"
            } else {
                accu = accu unescapeXML(S0)
                S0=""
            }
        } else if (mode == "STARTDOCT") {                      # terminated by "[" or ">"
            if ((q = index(S0, "[")) && (!(p = index(S0,end)) || q<p )) {
                XMLEVENT = mode
                XMLNAME = accu substr(S0, 1, q-1)
                S0 = substr(S0, q+1)
                mode = ""
                dtd = 1
            } else if (p = index(S0,end)) {
                XMLEVENT = mode
                XMLNAME = accu substr(S0, 1, p-1)
                S0 = "]" substr(S0, p)
                mode = ""
                dtd = 1
            } else {
                accu = accu S0
                S0 = ""
            }
        } else if (p = index(S0,end)) {  # terminated by end
            XMLEVENT = mode
            XMLNAME = XMLENDELEM = ( mode=="ENDELEM" ? tag : accu substr(S0,1,p-1))
            if (mode=="ENDELEM") XMLDEPTH --
            S0 = substr(S0, p+length(end))
            mode = ""
        } else {
            accu = accu S0
            S0 = ""
        }
    }
    _XMLIO[file, "S0"]   = S0;
    _XMLIO[file, "line"] = XMLROW;
    _XMLIO[file, "path"] = XMLPATH; 
    _XMLIO[file, "depth"] = XMLDEPTH; 
    _XMLIO[file, "dtd"]  = dtd;
    if (mode == "CHARDATA") {
        mode = ""
        if (accu != "")
            XMLEVENT = "CHARDATA"
        XMLNAME = ""
        $0 = accu
    }
    if (XMLEVENT) {
        if (XMLEVENT == "STARTELEM") {
            # Copy attributes into $0.
            NF=0
            for (ex in XMLATTR) {
                NF ++
                $NF = ex
            }
        }
        return 1
    }
    close(file);
    delete _XMLIO[file, "S0"];
    delete _XMLIO[file, "line"];
    delete _XMLIO[file, "path"]; 
    delete _XMLIO[file, "depth"]; 
    delete _XMLIO[file, "dtd"];
    if (XMLERROR)
        XMLERROR = file ":" XMLROW": " XMLERROR 
    else if (mode) XMLERROR=file ":" mline ": " "unterminated " mode
    else if (XMLPATH) XMLERROR=file ":" XMLROW": "  "unclosed tag(s) " XMLPATH 
} # func. getXMLEVENT

# unescape data and attribute values, used by getXMLEVENT
function unescapeXML(text) {
    gsub( "&apos;", "'",  text )
    gsub( "&quot;", "\"", text )
    gsub( "&gt;",   ">",  text )
    gsub( "&lt;",   "<",  text )
    gsub( "&amp;",  "\\&",  text)
    return text
}

# close xml file
function closeXMLEVENT(file) {
    close(file);
    delete _XMLIO[file,"S0"]
    delete _XMLIO[file,"line"]
    delete _XMLIO[file,"path"];
    delete _XMLIO[file,"depth"];
    delete _XMLIO[file,"dtd"]
    delete _XMLIO[file,"open"]
    delete _XMLIO[file,"IND"]
}
