BEGIN {
    Indent = ENVIRON["Indent"] + 0
    for (i=0; i<Indent; i++)
        IndentStr=IndentStr " "
    split("", Asm); split("", LineNums)
    while (getline > 0) {
        if ((Instr = trim($0))!="") { Asm[AsmLen++] = Instr; LineNums[AsmLen] = NR }
    }

    Open["object"]="{" ; Close["object"]="}" ; Opens["end_object"] = "object"
    Open["array"] ="[" ; Close["array"] ="]" ; Opens["end_array"]  = "array"
    split("",Stack)
    Depth = 0
    WasPrev = 0

    for (i=0; i<AsmLen; i++) {
        if (isComplex(Instr = Asm[i]))               { p1(Open[Instr] nlIndent(isEnd(Asm[i+1]), Depth+1))
                                                       Stack[++Depth]=Instr;                        WasPrev=0 }
        else if ("key"==Instr)                       { p1(Asm[++i] ":" (Indent==0?"":" "));         WasPrev=0 }
        else if ("number"==Instr || "string"==Instr) { p1(Asm[++i]);                                WasPrev=1 }
        else if (isSingle(Instr))                    { p1(Instr);                                   WasPrev=1 }
        else if (isEnd(Instr))                       { if (Stack[Depth] != Opens[Instr]) die("end mismatch", i)
                                                       p(nlIndent(isComplex(Asm[i-1]), Depth-1) Close[Stack[Depth--]])
                                                                                                    WasPrev=1 }
        else                                         { die("Wrong opcode", i) }
    }
    print ""
}

function isComplex(s) { return "object"==s || "array"==s }
function isSingle(s) { return "true"==s || "false"==s || "null"==s }
function isEnd(s) { return "end_object"==s || "end_array"==s }
function p(s) { printf "%s", s }
function p1(s) { p((WasPrev ? "," nlIndent(0, Depth) : "") s) }
function nlIndent(unless, d,   i, s) { if (unless || Indent==0) return ""; for (i=0; i<d; i++) s = s IndentStr; return "\n" s }
function die(msg, i) { print msg " at " FILENAME ":" LineNums[i] ": " Instr; exit 1 }
function trim(s) { sub(/^[ \t\r\n]+/, "", s); sub(/[ \t\r\n]+$/, "", s); return s; }