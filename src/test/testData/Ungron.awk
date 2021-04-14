BEGIN {
    Trace="Trace" in ENVIRON

    split("", JsonAsm); JsonAsmLen=0
    split("", GronAsm); GronAsmLen=0; split("", LineNums)

    while (getline > 0) {
        if ((Instr = trim($0))!="") { GronAsm[GronAsmLen++] = Instr; LineNums[GronAsmLen] = NR }
    }

    split("", AddrType)  # addr -> type
    split("", AddrValue) # addr -> value
    split("", AddrCount) # addr -> segment count
    split("", AddrKey)   # addr -> last segment name

    for (i=0; i<GronAsmLen; i++) {
        Instr = GronAsm[i];

        if("record" == Instr) {
            split("",Path)
            split("",Types)
            split("",Value) # [ type, value ]
        }
        else if (isSegmentType(Instr)) { arrPush(Types, Instr); arrPush(Path, GronAsm[++i]) }
        else if ("value" == Instr) {
            Instr = GronAsm[++i];
            split("",Value)
            Value[0] = Instr
            if (isValueHolder(Instr))
                Value[1] = GronAsm[++i]
        } else if ("end" == Instr) { processRecord() }
    }
    generateAsm()
    if (Trace) print "--- JSON asm ---"
    for (i=0; i<JsonAsmLen; i++)
        print JsonAsm[i]
}

function isComplex(s) { return "object"==s || "array"==s }
function isSegmentType(s) { return "field" ==s || "index" ==s }
function isValueHolder(s) { return "string"==s || "number"==s }
function processRecord(   l, addr, type, value, i) {
    if (Trace) print "=================="
    dbgA("Path",Path)
    dbgA("Types",Types)
    dbgA("Value",Value)
    l = arrLen(Path)
    addr=""
    for (i=0; i<l; i++) {
        # build addr
        addr = addr (i>0?",":"") (Types[i] == "index" ? sprintf("%010d",Path[i]) : Path[i]) # proper sorting for index values
        type = i<l-1 ? (Types[i+1] == "field" ? "object" : "array") : Value[0]
        value = i<l-1 ? "" : Value[1]
        if (addr in AddrType && type != AddrType[addr]) {
            die("Conflicting types for " addr ": " type " and " AddrType[addr])
        }
        AddrType[addr] = type
        AddrValue[addr] = value
        AddrCount[addr] = i+1
        AddrKey[addr] = Path[i]
    }
}
function generateAsm(   i,j,l, a,a_prev,aj, type, addrs) {
    dbg("AddrType",AddrType)
    dbg("AddrValue",AddrValue)
    dbg("AddrCount",AddrCount)
    dbg("AddrKey",AddrKey)

    split("",Stack)
    Ends["object"] = "end_object"
    Ends["array"]  = "end_array"

    for (a in AddrType) arrPush(addrs, a)
    quicksort(addrs, 0, (l=arrLen(addrs))-1)
    for (i=0; i<l; i++) {
        a = addrs[i]
        type = AddrType[a]
        if (i>0) {
            a_prev = addrs[i-1]
            for (j=0; j<AddrCount[a_prev] - AddrCount[a] + (isComplex(AddrType[a_prev])?1:0); j++)
                asm(Ends[arrPop(Stack)])
            # determine the type of current container (object/array) - for array should not issue "key"
            for (j=i; AddrCount[a]-AddrCount[aj=addrs[j]] != 1; j--) {} # descend to addr of prev segment
            if ("array" != AddrType[aj]) {
                asm("key")
                asm(AddrKey[a]) # last segment in addr
            }
        }
        asm(type)
        if (isComplex(type))
            arrPush(Stack, type)
        if (isValueHolder(type))
            asm(AddrValue[a])
        if (i==l-1) { # last
            for (j=0; j<AddrCount[a] - (isComplex(type)?0:1); j++)
                asm(Ends[arrPop(Stack)])
        }
    }
}
function asm(inst) { JsonAsm[JsonAsmLen++]=inst; return 1 }
function arrPush(arr, e) { arr[arr[-7]++] = e }
function arrPop(arr,   e) { e = arr[--arr[-7]]; if (arr[-7]<0) die("Can't pop"); delete arr[arr[-7]]; return e }
function arrLen(arr) { return 0 + arr[-7] }
function die(msg) { print msg; exit 1 }
function dbgA(name, arr,    i) {
    if (!Trace) return
    print "--- " name " ---";
    for (i=0; i<arrLen(arr); i++) print i " : " arr[i]
}
function dbg(name, arr,    i, j, k, maxlen, keys) {
    if (!Trace) return
    print "--- " name " ---";
    for (k in arr) { keys[i++] = k; if (maxlen < (j = length(k))) maxlen = j }
    quicksort(keys,0,i-1)
    for (j=0; j<i; j++) { k = keys[j]; printf "%-" maxlen "s : %s\n", k, arr[k] }
}
function quicksort(data, left, right,   i, last) {
    if (left >= right)
      return

    quicksort_swap(data, left, int((left + right) / 2))
    last = left
    for (i = left + 1; i <= right; i++)
      if (data[i] <= data[left])
        quicksort_swap(data, ++last, i)
    quicksort_swap(data, left, last)
    quicksort(data, left, last - 1)
    quicksort(data, last + 1, right)
}
function quicksort_swap(data, i, j,   temp) {
    temp = data[i]
    data[i] = data[j]
    data[j] = temp
}
function trim(s) { sub(/^[ \t\r\n]+/, "", s); sub(/[ \t\r\n]+$/, "", s); return s; }