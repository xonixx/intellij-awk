BEGIN {
    split("", Asm); split("", LineNums)
    while (getline > 0) {
        if ((Instr = trim($0))!="") { Asm[AsmLen++] = Instr; LineNums[AsmLen] = NR }
    }

    split("",AlreadyTracked)
    split("",Stack); split("",PathStack)
    Depth = 0

    for (i=0; i<AsmLen; i++) {
        if (isComplex(Instr = Asm[i]))               { p("object"==Instr?"{}":"[]");
                                                       Stack[++Depth]=Instr;
                                                       if (inArr()) { PathStack[Depth]=0 } }
        else if (isSingle(Instr))                    { p(Instr);               incArrIdx() }
        else if (isEnd(Instr))                       { Depth--;                incArrIdx() }
        else if ("key" == Instr)                     { PathStack[Depth]=Asm[++i];          }
        else if ("number"==Instr || "string"==Instr) { p(Asm[++i]);            incArrIdx() }
        else { print "Error at " FILENAME ":" LineNums[i] ": " Instr; exit 1 }
    }
}

function isSingle(s) { return "true"==s || "false"==s || "null"==s }
function isComplex(s) { return "object"==s || "array"==s }
function inArr() { return "array"==Stack[Depth] }
function isEnd(s) { return "end_object"==s || "end_array"==s }
function incArrIdx() { if (inArr()) PathStack[Depth]++ }

function p(v,    row,i,is_arr,by_idx,segment,segment_unq) {
    row=""
    for(i=1; i<=Depth; i++) {
        segment = PathStack[i]
        segment_unq = stringUnquote(segment)
        by_idx = (is_arr="array"==Stack[i]) || segment_unq !~ /^[[:alpha:]$_][[:alnum:]$_]*$/
        row = row (i==0||is_arr?"":".") (is_arr ? "[]" : by_idx ? segment : segment_unq)
    }
    if (row in AlreadyTracked) return
    AlreadyTracked[row]
    if ("{}" == v || "[]" == v) return
    row = row " = " v
    print row
}

function stringUnquote(text,    len)
{
    len  = length(text);
    text = len == 2 ? "" : substr(text, 2, len-2)

    gsub(/\\\\/, "\\", text)
    gsub(/\\"/,  "\"", text)
    gsub(/\\b/,  "\b", text)
    gsub(/\\f/,  "\f", text)
    gsub(/\\n/,  "\n", text)
    gsub(/\\r/,  "\r", text)
    gsub(/\\t/,  "\t", text)

    return text
}

function trim(s) { sub(/^[ \t\r\n]+/, "", s); sub(/[ \t\r\n]+$/, "", s); return s; }