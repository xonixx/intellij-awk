
      
      



BEGIN{ _addlib("_BASE") } ##########################################################

func	_BASE(c,t,P, A) {
      switch ( c ) {
            case "_lib_CMDLN":
                        if ( match(t,/^((--([Vv])ersion)|(-([Vv])))[ \t]*/,A) )	{ t=substr(t,RLENGTH+1); _cmdln_version=A[3] A[5] }
                  else	if ( match(t,/^((-?\?)|(--help))[ \t]*/) )				{ t=substr(t,RLENGTH+1); _cmdln_help=1 }
                  else	if ( match(t,/^--[ \t]*/) )						return _endpass(substr(t,RLENGTH+1))
                  return t
      #___________________________________________________________

            case "_lib_APPLY":
                  if ( _cmdln_help )			{ match(_fbaccr(_LIBAPI,"_lib_HELP"),/^([^\x00]*)\x00([^\x01]*)\x01(.*)/,A)
                                                _out(A[2] A[1] A[3]); return _endpass(_basexit_fl=1) }
                  if ( _cmdln_version )		{ _out(	_ln(_PRODUCT_NAME " v" _PRODUCT_VERSION)										_ln(_PRODUCT_COPYRIGHT)										_ln()										(_cmdln_version=="v" ? "" : _lib_NAMEVER())); return _endpass(_basexit_fl=1) }
                  return
      #___________________________________________________________

            case "_lib_HELP":
                  return "\x00"				_ln(_PRODUCT_NAME " v" _PRODUCT_VERSION)				_ln(_PRODUCT_COPYRIGHT)				_ln()				_ln(" Usage:")				_ln()				_ln("    " _PRODUCT_FILENAME " [/key1 /key2...] [-- cmdline]")				_ln()				_ln(" keys:")				_ln() "\x01"				_ln("    -v -V --version                    - output product version and (if /V) all modules")				_ln("    ? -? --help                        - output this help page")				_ln("    --                                 - command line string edge")
      #___________________________________________________________

            case	"_lib_NAMEVER":
                  return 				_ln("_BASE 3.0")
      #___________________________________________________________

            case "_lib_BEGIN":
                  return
      #___________________________________________________________

            case "_lib_END":
                  return } }
#_____________________________________________________________________________
func	_addlib(f) { ###########################################################
      _addf(_LIBAPI,f) }
#_______________________________________________________________________
func	_lib_CMDLN(t) {
      return _pass(_LIBAPI["F"],"_lib_CMDLN",t) }
#_________________________________________________________________
func	_lib_APPLY() {
      return _ffaccr(_LIBAPI,"_lib_APPLY") }
#_________________________________________________________________
func	_lib_HELP() {
      return _fbaccr(_LIBAPI,"_lib_HELP") }
#_________________________________________________________________
func	_lib_NAMEVER() {
      return _fbaccr(_LIBAPI,"_lib_NAMEVER") }
#_________________________________________________________________
func	_lib_BEGIN(A) {
      return _ffaccr(_LIBAPI,"_lib_BEGIN","",A) }
#_________________________________________________________________
func	_lib_END(A) {
      return _ffaccr(_LIBAPI,"_lib_END","",A) }
#___________________________________________________________________________________
BEGIN { ############################################################################

      BINMODE="rw"
      SUBSEP="\x00"
      _NULARR[""]; delete _NULARR[""]
      _INITBASE() }
#_____________________________________________________________________________
END { ########################################################################

      _EXIT() }
      

BEGIN { _addlib("_sYS") } ################################################################
#_____________________________________________________________________________
func	_sYS(c,t,P, a,A) { #####################################################
      switch ( c ) {
      #___________________________________________________________
            case "_lib_CMDLN":				return t
      #_____________________________________________________
            case "_lib_APPLY":				return
      #_____________________________________________________
            case "_lib_HELP":					return
      #_____________________________________________________
            case	"_lib_NAMEVER":				return
      #_____________________________________________________
            case "_lib_BEGIN":				return
      #_____________________________________________________
            case "_lib_END":					return } }

BEGIN { _addlib("_rEG") } ################################################################
#_____________________________________________________________________________
func	_rEG(c,t,P, a,A) { #####################################################
      switch ( c ) {
      #___________________________________________________________
            case "_lib_CMDLN":				return t
      #_____________________________________________________
            case "_lib_APPLY":				return
      #_____________________________________________________
            case "_lib_HELP":					return
      #_____________________________________________________
            case	"_lib_NAMEVER":				return 										_ln("_reg 0.001")
      #_____________________________________________________
            case "_lib_BEGIN":				return
      #_____________________________________________________
            case "_lib_END":					return } }
      
      
      


BEGIN { _addlib("_INSTRUC") } ######################################################

func	_INSTRUC(c,t,P) {
      switch ( c ) {
            case "_lib_CMDLN":
                  return t
      #___________________________________________________________

            case "_lib_APPLY":
                  return
      #___________________________________________________________

            case "_lib_HELP":
                  return
      #___________________________________________________________

            case	"_lib_NAMEVER":
                  return				_ln("_INSTRUC 1.0")
      #___________________________________________________________

            case "_lib_BEGIN":
                  return
      #___________________________________________________________

            case "_lib_END":
                  return } }
#___________________________________________________________________________________
BEGIN{ #############################################################################

      _delay_perfmsdelay		=11500 }
      
      
      
      


BEGIN { _addlib("_ARR") } ##########################################################

func	_ARR(c,t,P) {
      switch ( c ) {
            case "_lib_CMDLN":
                  return t
      #___________________________________________________________

            case "_lib_APPLY":
                  return
      #___________________________________________________________

            case "_lib_HELP":
                  return
      #___________________________________________________________

            case	"_lib_NAMEVER":
                  return				_ln("_ARR 1.0")
      #___________________________________________________________

            case "_lib_BEGIN":
                  return
      #___________________________________________________________

            case "_lib_END":
                  return } }
#___________________________________________________________________________________
BEGIN{ } ###########################################################################

      
      
      


BEGIN { _addlib("_EXTFN") } ########################################################

func	_EXTFN(c,t,P) {
      switch ( c ) {
            case "_lib_CMDLN":
                  return t
      #___________________________________________________________

            case "_lib_APPLY":
                  return
      #___________________________________________________________

            case "_lib_HELP":
                  return
      #___________________________________________________________

            case	"_lib_NAMEVER":
                  return				_ln("_EXTFN 1.0")
      #___________________________________________________________

            case "_lib_BEGIN":
                  return
      #___________________________________________________________

            case "_lib_END":
                  return } }
#___________________________________________________________________________________
BEGIN{ #############################################################################

      delete _XCHR; delete _ASC; delete _CHR; t=""
      for ( i=0; i<256; i++ )		{ _ASC[a=_CHR[i]=sprintf("%c",i)]=i; _QASC[a]=sprintf("%.3o",i)
                                    _XCHR[_CHR[i]]=sprintf("%c", (i<128 ? i+128 : i-128)) }
#_____________________________________________________________________________

      for ( i=0; i<256; i++ ) {
            _QSTRQ[_CHR[i]]="\\" sprintf("%.3o",i) }
#_______________________________________________________________________

      for ( i=0; i<32; i++ ) {
            _QSTR[_CHR[i]]=_QSTRQ[_CHR[i]] }
      for ( ; i<128; i++ ) {
            _QSTR[_CHR[i]]=_CHR[i] }
      for ( ; i<256; i++ ) {
            _QSTR[_CHR[i]]=_QSTRQ[_CHR[i]] }
      _QSTR["\\"]="\\\\"	#; _QSTR["\""]="\\\""
#_____________________________________________________________________________

      _CHR["CR"]			="\015"
      _CHR["EOL"]			="\015\012"
      _CHR["EOF"]			="\032"
      
      _QSTR[_CHR["EOL"]]	="\\015\\012"
#_______________________________________________________________________

      _CHR["MONTH"][_CHR["MONTH"]["Jan"]="01"]="Jan"
      _CHR["MONTH"][_CHR["MONTH"]["Feb"]="02"]="Feb"
      _CHR["MONTH"][_CHR["MONTH"]["Mar"]="03"]="Mar"
      _CHR["MONTH"][_CHR["MONTH"]["Apr"]="04"]="Apr"
      _CHR["MONTH"][_CHR["MONTH"]["May"]="05"]="May"
      _CHR["MONTH"][_CHR["MONTH"]["Jun"]="06"]="Jun"
      _CHR["MONTH"][_CHR["MONTH"]["Jul"]="07"]="Jul"
      _CHR["MONTH"][_CHR["MONTH"]["Aug"]="08"]="Aug"
      _CHR["MONTH"][_CHR["MONTH"]["Sep"]="09"]="Sep"
      _CHR["MONTH"][_CHR["MONTH"]["Oct"]="10"]="Oct"
      _CHR["MONTH"][_CHR["MONTH"]["Nov"]="11"]="Nov"
      _CHR["MONTH"][_CHR["MONTH"]["Dec"]="12"]="Dec"
#_____________________________________________________________________________

      _TAB_STEP_DEFAULT		=8
#_____________________________________________________________________________

      for ( i=0; i<32; i++ )	_REXPSTR[_CHR[i]]=_QSTRQ[_CHR[i]]
      for ( ; i<256; i++ )	_REXPSTR[_CHR[i]]=_CHR[i]
      _gensubfn("\\^$.()|{,}[-]?+*",".","_rexpstr_i0") }
#_____________________________________________________________________________
func	_rexpstr_i0(t,A,p0) {
      return _REXPSTR[t]="\\" t }
      
      
      
      


BEGIN { _addlib("_SYSIO") } #########################################################

func	_SYSIO(c,t,P) {
      switch ( c ) {
            case "_lib_CMDLN":
                  return t
      #___________________________________________________________

            case "_lib_APPLY":
                  return
      #___________________________________________________________

            case "_lib_HELP":
                  return
      #___________________________________________________________

            case	"_lib_NAMEVER":
                  return				_ln("_SYSIO 1.0")
      #___________________________________________________________

            case "_lib_BEGIN":
                  return
      #___________________________________________________________

            case "_lib_END":
                  return } }
#___________________________________________________________________________________
BEGIN{ #############################################################################

      _SYS_STDCON		="CON"
      _CON_WIDTH=match(_cmd("MODE "_SYS_STDCON" 2>NUL"),/Columns:[ \t]*([0-9]+)/,A) ? strtonum(A[1]) : 80 }

      
      
      


BEGIN { _addlib("_FILEIO") } #######################################################

func	_FILEIO(c,t,P, A) {
      switch ( c ) {
            case "_lib_CMDLN":
                  if ( match(t,/^[ \t]*-[Tt]([\+-])[ \t]*/,A) )	{ t=substr(t,RLENGTH+1)
                                                            if ( A[1]=="+" )	_fileio_notdeltmpflag=1
                                                                        else	_fileio_notdeltmpflag="" }
                  return t
      #___________________________________________________________

            case "_lib_APPLY":
                  if ( _fileio_notdeltmpflag ) {
                        _info("Temporary objects deletion DISABLED (inherited)")
                        }
                  return
      #___________________________________________________________

            case "_lib_HELP":
                  return	_ln("    -[Tt][+-]                          - inherited: +enable\\-disable temporary files\\dirs deletion")				_ln()
      #___________________________________________________________

            case	"_lib_NAMEVER":
                  return				_ln("_FILEIO 2.1")
      #___________________________________________________________

            case "_lib_BEGIN":
                  P["ENVIRON"]["CD"]						=ENVIRON["CD"]
                  P["_FILEIO_RD"]							=_FILEIO_RD
                  P["_FILEIO_R"]							=_FILEIO_R
                  P["_FILEIO_D"]							=_FILEIO_D
                  if ( !("_FILEIO_TMPRD" in P) ) {
                        P["_FILEIO_TMPRD"]					=_getmpdir(_filen(P["SOURCE"]) "." ++_egawk_subcntr _CHR["SUBDIR"]) }
                  return
      #___________________________________________________________

            case "_lib_END":
                  return } }
#___________________________________________________________________________________
BEGIN{ #############################################################################

      if ( _SYS_STDOUT=="" )		_SYS_STDOUT="/dev/stdout"
      if ( _SYS_STDERR=="" )		_SYS_STDERR="/dev/stderr"
      _CHR["SUBDIR"]="\\"
      if ( _gawk_scriptlevel<1 ) {
            match(b=_cmd("echo %CD% 2>NUL"),/[^\x00-\x1F]*/)
            ENVIRON["CD"]=_FILEIO_RD=_filerd(substr(b,RSTART,RLENGTH) _CHR["SUBDIR"]); _FILEIO_R=_filer(_FILEIO_RD); _FILEIO_D=_filed(_FILEIO_RD)
            _setmpath(_filerd(_FILEIO_RD "_tmp" _CHR["SUBDIR"])) } }

      
      
      


BEGIN { _addlib("_tOBJ") } #########################################################

func	_tOBJ(c,t,P) {
      switch ( c ) {
      #___________________________________________________________
            case "_lib_CMDLN":
                  return t
      #___________________________________________________________
            case "_lib_APPLY":
                  return
      #___________________________________________________________
            case "_lib_HELP":
                  return
      #___________________________________________________________
            case	"_lib_NAMEVER":
                  return				_ln("_tOBJ 3.0")
      #___________________________________________________________
            case "_lib_BEGIN":
                  return
      #___________________________________________________________
            case "_lib_END":
                  return
      #___________________________________________________________
            case "_lib_CLEANUP":
                  return	_tOBJ_CLEANUP() } }
#_______________________________________________________________________
func	_tOBJ_CLEANUP( p) { ##############################################
      for ( p in UIDSDEL ) {
            delete _ptr[p]
            delete _tPREV[p];	delete _tPARENT[p];		delete _tNEXT[p]
            delete _tFCHLD[p];	delete _tQCHLD[p];		delete _tLCHLD[p]
            delete _TMP0[p];	delete _TMP1[p]
            delete _tLINK[p];	delete _tCLASS[p] } }
#___________________________________________________________________________________
BEGIN{ #############################################################################
      _tInBy	="\x8A._tInBy"
      _tgenuid_init()
      _UIDS[""]; delete _UIDS[""]; _UIDSDEL[""]; delete _UIDSDEL[""]
      _tPREV[""]; _tPARENT[""]; _tNEXT[""]; _tFCHLD[""]; _tQCHLD[""]; _tLCHLD[""]
      _tLINK[""]; _tCLASS[""]
      _tSTR[""]; _tDLINK[""]
      _[""]; delete _[""]; _ptr[""]; delete _ptr[""]
      _TMP0[""]; delete _TMP0[""]; _TMP1[""]; delete _TMP1[""] }

      
      


BEGIN{ _addlib("_ERRLOG") } ########################################################

func	_ERRLOG(c,t,P, a,b,A) {
      switch ( c ) {
            case "_lib_CMDLN":
                  if ( match(t,/^[ \t]*-L:([TtVvIiWwEeFf]*)[ \t]*/,A) )		{ t=substr(t,RLENGTH+1); _errlog_errflkey=_errlog_errflkey A[1] }
                  return t
      #_______________________________________________________________________

            case "_lib_APPLY":
                  if ( _errlog_errflkey ) {
                        split(_errlog_errflkey,A,"")
                        for ( a=1; a in A; a++ ) {
                              if ( A[a]==toupper(A[a]) ) b=1; else b=""
                              switch ( toupper(A[a]) ) {
                                    case "T":
                                          _ERRLOG_TF=b; break
                                    case "V":
                                          _ERRLOG_VF=b; break
                                    case "I":
                                          _ERRLOG_IF=b; break
                                    case "W":
                                          _ERRLOG_WF=b; break
                                    case "E":
                                          _ERRLOG_EF=b; break
                                    case "F":
                                          _ERRLOG_FF=b; break } }
                        if ( _ERRLOG_IF ) {
                              _info("Log-message types inherited acc/deny: "						"TRACE "	(_ERRLOG_TF ? "ON" : "OFF") "/"						"VERBOSE "	(_ERRLOG_VF ? "ON" : "OFF") "/"						"INFO "	(_ERRLOG_IF ? "ON" : "OFF") "/"						"WARNING "	(_ERRLOG_WF ? "ON" : "OFF") "/"						"ERROR "	(_ERRLOG_EF ? "ON" : "OFF") "/"						"FATAL "	(_ERRLOG_FF ? "ON" : "OFF") ) } }
                  return
      #_______________________________________________________________________

            case "_lib_HELP":
                  return	_ln("    -L:TtVvIiWwEeFf                    - enable(upcase: TVIWEF) or disable(lowcase: tviwef) allowable type of")				_ln("                                         log messages. Trace/Verbose/Informational/Warning/Error/Fatal.")				_ln()
      #_______________________________________________________________________

            case	"_lib_NAMEVER":
                  return				_ln("_ERRLOG 1.0")
      #_______________________________________________________________________

            case "_lib_BEGIN":
                  P["_ERRLOG_TF"]				=_ERRLOG_TF
                  P["_ERRLOG_VF"]				=_ERRLOG_VF
                  P["_ERRLOG_IF"]				=_ERRLOG_IF
                  P["_ERRLOG_WF"]				=_ERRLOG_WF
                  P["_ERRLOG_EF"]				=_ERRLOG_EF
                  P["_ERRLOG_FF"]				=_ERRLOG_FF
                  P["_errlog_file"]				="/dev/stderr"
                  return } }
#___________________________________________________________________________________
BEGIN{ #############################################################################

      if ( _gawk_scriptlevel<1 ) {
            _ERRLOG_TF				=1
            _ERRLOG_VF				=1
            _ERRLOG_IF				=1
            _ERRLOG_WF				=1
            _ERRLOG_EF				=1
            _ERRLOG_FF				=1
            _wrfile(_errlog_file=_getmpfile("OUTPUT.LOG"),"") } }

      
      
      


BEGIN { _addlib("_SHORTCUT") } #####################################################

func	_SHORTCUT(c,t,P) {
      switch ( c ) {
            case "_lib_CMDLN":
                  return t
      #___________________________________________________________

            case "_lib_APPLY":
                  return
      #___________________________________________________________

            case "_lib_HELP":
                  return
      #___________________________________________________________

            case	"_lib_NAMEVER":
                  return				_ln("_shortcut 1.0")
      #___________________________________________________________

            case "_lib_BEGIN":
                  return
      #___________________________________________________________

            case "_lib_END":
                  return } }
#___________________________________________________________________________________
BEGIN { _shortcut_init() } #########################################################



BEGIN { _addlib("_eXTFN") } ########################################################

func	_eXTFN(c,t,P) {
      switch ( c ) {
            case "_lib_CMDLN":
                  return t
      #___________________________________________________________

            case "_lib_APPLY":
                  return
      #___________________________________________________________

            case "_lib_HELP":
                  return
      #___________________________________________________________

            case	"_lib_NAMEVER":
                  return				_ln("_extfn 1.0")
      #___________________________________________________________

            case "_lib_BEGIN":
                  return
      #___________________________________________________________

            case "_lib_END":
                  return } }
#___________________________________________________________________________________
BEGIN { _extfn_init() } ############################################################


BEGIN { _addlib("_sHARE") } ##############################################################
#_____________________________________________________________________________
func	_sHARE(c,t,P, a,A) { ###################################################
      switch ( c ) {
      #___________________________________________________________
            case "_lib_CMDLN":				return t
      #_____________________________________________________
            case "_lib_APPLY":				return
      #_____________________________________________________
            case "_lib_HELP":					return
      #_____________________________________________________
            case	"_lib_NAMEVER":				return	_ln("_share 1.000")
      #_____________________________________________________
            case "_lib_BEGIN":				return
      #_____________________________________________________
            case "_lib_END":					return } }

BEGIN { _addlib("_FILEVER") } ############################################################
#_____________________________________________________________________________
func	_FILEVER(c,t,P, a,A) { #################################################
      switch ( c ) {
      #___________________________________________________________
            case "_lib_CMDLN":				return t
      #_____________________________________________________
            case "_lib_APPLY":				return
      #_____________________________________________________
            case "_lib_HELP":					return
      #_____________________________________________________
            case	"_lib_NAMEVER":				return
      #_____________________________________________________
            case "_lib_BEGIN":				return
      #_____________________________________________________
            case "_lib_END":					return } }


BEGIN { _addlib("_DS") ###############################################################################

      _PRODUCT_NAME		="Deployment Solution Control"
      _PRODUCT_VERSION		="1.0"
      _PRODUCT_COPYRIGHT	="Copyright (C) 2013 by CosumoGEN"
      _PRODUCT_FILENAME		="_main.ewk"
}#____________________________________________________________________________
func	_DS(c,t,P, a,A) { ######################################################
      switch ( c ) {
      #___________________________________________________________
            case "_lib_CMDLN":				return t
      #_____________________________________________________
            case "_lib_APPLY":				return
      #_____________________________________________________
            case "_lib_HELP":			return	_ln()									_ln(	" Usage: " _PRODUCT_NAME " [/key1 /key2...] sourcefile [cmdline]")									_ln()
      #_____________________________________________________
            case	"_lib_NAMEVER":				return
      #_____________________________________________________
            case "_lib_BEGIN":				return
      #_____________________________________________________
            case "_lib_END":					return } }

func	_INIT(f) { } #############################################################################



func	_pmap(m,s1,s2,s3,s4,s5,s6,s7,s8) {
      if ( match(m,/^([^\(]+)\(([^\)]*)\)$/,_QMAP) )	{ _qparamf1=_QMAP[1]; _QMAP[0]="r" (_qparamc1=split(_QMAP[2],_QMAP,""))
                                                      _qparamf0="_p" _QMAP[_qparamc1--]
                                                      return @_qparamf0(s1,s2,s3,s4,s5,s6,s7,s8) } }
      
func	_p1(s1,s2,s3,s4,s5,s6,s7,s8,p1,p2,p3,p4,p5,p6,p7,p8) {
      _qparamf0="_p" _QMAP[_qparamc1--]
      return @_qparamf0(s1,s2,s3,s4,s5,s6,s7,s8,s1,p1,p2,p3,p4,p5,p6,p7) }

func	_p2(s1,s2,s3,s4,s5,s6,s7,s8,p1,p2,p3,p4,p5,p6,p7,p8) {
      _qparamf0="_p" _QMAP[_qparamc1--]
      return @_qparamf0(s1,s2,s3,s4,s5,s6,s7,s8,s2,p1,p2,p3,p4,p5,p6,p7) }

func	_p3(s1,s2,s3,s4,s5,s6,s7,s8,p1,p2,p3,p4,p5,p6,p7,p8) {
      _qparamf0="_p" _QMAP[_qparamc1--]
      return @_qparamf0(s1,s2,s3,s4,s5,s6,s7,s8,s3,p1,p2,p3,p4,p5,p6,p7) }

func	_p4(s1,s2,s3,s4,s5,s6,s7,s8,p1,p2,p3,p4,p5,p6,p7,p8) {
      _qparamf0="_p" _QMAP[_qparamc1--]
      return @_qparamf0(s1,s2,s3,s4,s5,s6,s7,s8,s4,p1,p2,p3,p4,p5,p6,p7) }

func	_p5(s1,s2,s3,s4,s5,s6,s7,s8,p1,p2,p3,p4,p5,p6,p7,p8) {
      _qparamf0="_p" _QMAP[_qparamc1--]
      return @_qparamf0(s1,s2,s3,s4,s5,s6,s7,s8,s5,p1,p2,p3,p4,p5,p6,p7) }

func	_p6(s1,s2,s3,s4,s5,s6,s7,s8,p1,p2,p3,p4,p5,p6,p7,p8) {
      _qparamf0="_p" _QMAP[_qparamc1--]
      return @_qparamf0(s1,s2,s3,s4,s5,s6,s7,s8,s6,p1,p2,p3,p4,p5,p6,p7) }

func	_p7(s1,s2,s3,s4,s5,s6,s7,s8,p1,p2,p3,p4,p5,p6,p7,p8) {
      _qparamf0="_p" _QMAP[_qparamc1--]
      return @_qparamf0(s1,s2,s3,s4,s5,s6,s7,s8,s7,p1,p2,p3,p4,p5,p6,p7) }

func	_p8(s1,s2,s3,s4,s5,s6,s7,s8,p1,p2,p3,p4,p5,p6,p7,p8) {
      _qparamf0="_p" _QMAP[_qparamc1--]
      return @_qparamf0(s1,s2,s3,s4,s5,s6,s7,s8,s8,p1,p2,p3,p4,p5,p6,p7) }

func	_pr8(s1,s2,s3,s4,s5,s6,s7,s8,p1,p2,p3,p4,p5,p6,p7,p8) {

      return @_qparamf1(p1,p2,p3,p4,p5,p6,p7,p8) }

func	_pr7(s1,s2,s3,s4,s5,s6,s7,s8,p1,p2,p3,p4,p5,p6,p7,p8) {

      return @_qparamf1(p1,p2,p3,p4,p5,p6,p7) }

func	_pr6(s1,s2,s3,s4,s5,s6,s7,s8,p1,p2,p3,p4,p5,p6,p7,p8) {

      return @_qparamf1(p1,p2,p3,p4,p5,p6) }

func	_pr5(s1,s2,s3,s4,s5,s6,s7,s8,p1,p2,p3,p4,p5,p6,p7,p8) {

      return @_qparamf1(p1,p2,p3,p4,p5) }

func	_pr4(s1,s2,s3,s4,s5,s6,s7,s8,p1,p2,p3,p4,p5,p6,p7,p8) {

      return @_qparamf1(p1,p2,p3,p4) }

func	_pr3(s1,s2,s3,s4,s5,s6,s7,s8,p1,p2,p3,p4,p5,p6,p7,p8) {

      return @_qparamf1(p1,p2,p3) }

func	_pr2(s1,s2,s3,s4,s5,s6,s7,s8,p1,p2,p3,p4,p5,p6,p7,p8) {

      return @_qparamf1(p1,p2) }

func	_pr1(s1,s2,s3,s4,s5,s6,s7,s8,p1,p2,p3,p4,p5,p6,p7,p8) {

      return @_qparamf1(p1) }

func	_pr0(s1,s2,s3,s4,s5,s6,s7,s8,p1,p2,p3,p4,p5,p6,p7,p8) {

      return @_qparamf1() }











func	hujf(a,b,c)	{ _conl("hujf(" a "," b "," c ")") }


                                                                        

func	_qparam(qm,p0,p1,p2,p3,p4,p5,p6,p7) {

            if ( qm==qm+0 && qm>0 )		_qparamim=substr("        ",1,qm)
            else	if ( qm!="" )		_qparamim=qm
                                    else	_qparamim="        "
            _qparamask=""; return _qparam_i0(p0,p1,p2,p3,p4,p5,p6,p7) }

func	_qparam_i0(p0,p1,p2,p3,p4,p5,p6,p7)	{ _qparama0=substr(_qparamim,1,1); _qparamim=substr(_qparamim,2)
                                          switch ( _qparama0 )	{ case "":		gsub(/ +$/,"",_qparamask); return length(_qparamask)
                                                                  default:		if ( isarray(p0) )			_qparama0="A"
                                                                                    else	if ( p0=="" && p0==0 )		_qparama0=" "
                                                                                    else	if ( _isptr(p0) )			_qparama0="P"
                                                                                                                  else	_qparama0="S"
                                                                  case	".":		_qparamask=_qparamask _qparama0
                                                                                    return _qparam_i0(p1,p2,p3,p4,p5,p6,p7) } }
func	tts(p,uidel,psfx,cnt,chr,p5,p6,p7, im) {
      im="     "
      im=".. .."
      _conl("ret:   " _qparam(im,p,uidel,psfx,cnt,chr,p5,p6,p7) "'")
      _conl("mask: `" _qparamask "'") }

func	_uidcyc(p, i) {
      _dumpuidgen(p)
      for ( i=1; i<(64*8*6-1); i++ )	_conl(i ":" _var(_getuid(p)))
      _dumpuidgen(p) }



func	_dumpuidgen(p, pd,pc,ps) {
      _conline("#" (++cntdm) ": " p "'"); _conl()
      if ( p in _tuidel )	{ _conl("DEL:   " _var(pd=_tuidel[p]))
                              _conl(_dumparr(_tUIDEL[pd]) _ln()) }
      _conl("PFX: " _tUIDPFX[p] "'"); _conl("SFX: " _tUIDSFX[p] "'")
      
      _conl("COUNT: " (p in _tuidcnt ? (pc=_tuidcnt[p]) "'" : _th0("-",pc=-2)))
      _con("CHARS: "); if ( p in _tuidchr )	{ _conl((ps=_tuidchr[p]) "'")
                                                _conl("HCHR: " (pc==-2 ? "-" : _tUIDCNTH[pc] "'")); _conl(_dumparr(_tUIDCHRH[ps]) _ln())
                                                _conl("LCHR: " (pc==-2 ? "-" : _tUIDCNTL[pc] "'")); _conl(_dumparr(_tUIDCHRL[ps]) _ln()) }
                                          else	_conl("-") }



# prefix	-
# prichr	- aware character `{', `^',`]'
# sechr	- aware character `.' as the first char of sechr, and character `}'
# suffix	- aware character `]'
# cntptr	- aware character `]'

func	_tr(n,cs, H) {
      #_tuidinitcs[p]=cs
      #2 uidel, 5 pfx, 7 hichr,11(10) lochr,14 suffix
      _rconline(n ": " cs); _rconl()
      if ( match(cs,/^((([^\xB4:\[\|\]]*\xB4.)*[^\xB4:\[\|\]]*):)?((([^\xB4\[\|\]]*\xB4.)*[^\xB4\[\|\]]*)\[)?(([^\xB4\|\]]*\xB4.)*[^\xB4\|\]]*)?(\|(\.)?(([^\xB4\]]*\xB4.)*[^\xB4\]]*))?(\](.*))?$/,H) ) {
            _rconl("delptr: " _une(H[2]) "'")
            _rconl("pfxstr: " _une(H[5]) "'")
            _rconl("hichr:  " _une(H[7]) "'")
            _rconl("lochr:  " _une(H[10] ? H[7] "' and " H[11] "'" : H[11] "'"))
            _rconl("sfxstr: " _une(H[14]) "'") }
      else	_rconl("NOT MATCH!")
      _rconl() }

func	_une(t) {	return gensub(/\xB4(.)/,"\\1","G",t) }
func	_rconl(t) {		_rprt=_rprt _ln(t) }
func	_rconline(t)	{ _rprt=_rprt _ln((t=" " t " ") _getchrln("_",_CON_WIDTH-length(t)-1)) }












func	_splitpath_test() {
      _conl(); _conl("########################################################################################"); _conl()
      _fpp("  ")
      _fpp(" fi le . ex t ")
      _fpp(" di r0 / / ")
      _fpp(" di r0 / / fi le . ex t ")
      _fpp(" / ")
      _fpp(" / fi le . ex t ")
      _fpp(" / di r0 / /  ")
      _fpp(" / di r0 / / fi le . ex t ")
      _conl(); _conl("########################################################################################"); _conl()
      _fpp(" c : ")
      _fpp(" c : fi le . ex t ")
      _fpp(" c : di r0 / / ")
      _fpp(" c : di r0 / / fi le . ex t ")
      _fpp(" c : / / ")
      _fpp(" c : / / fi le . ex t ")
      _fpp(" c : / / di r0 / /  ")
      _fpp(" c : / / di r0 / / fi le . ex t ")
      _conl(); _conl("########################################################################################"); _conl()
      _fpp(" / /  ")
      _fpp(" / / ho st . hs t ")
      _fpp(" / / ho st / /  ")
      _fpp(" / / ho st / / fi le . ex t ")
      _fpp(" / / ho st / / di r0 / / ")
      _fpp(" / / ho st / / di r0 / / fi le . ex t ")
      _conl(); _conl("########################################################################################"); _conl()
      _fpp(" / / ho st / / c : ")
      _fpp(" / / ho st / / c : fi le . ex t ")
      _fpp(" / / ho st / / c : di r0 / / ")
      _fpp(" / / ho st / / c : di r0 / / fi le . ex t ")
      _fpp(" / / ho st / / c : / / ")
      _fpp(" / / ho st / / c : / / fi le . ex t ")
      _fpp(" / / ho st / / c : / / di r0 / / ")
      _fpp(" / / ho st / / c : / / di r0 / / fi le . ex t ")
      _conl(); _conl("########################################################################################"); _conl()
      _fpp(" http : / / / ")
      _fpp(" http : / / / si te . ex t ")
      _fpp(" http : / / / si te / /  ")
      _fpp(" http : / / / si te / / fi le . ex t ")
      _fpp(" http : / / / si te / / di r0 / / ")
      _fpp(" http : / / / si te / / di r0 / / fi le . ex t ")
      _conl(); _conl("########################################################################################"); _conl()
      _fpp(" ftp : / / / : po rt ")
      _fpp(" ftp : / / / si te . ex t : po rt ")
      _fpp(" ftp : / / / si te : po rt / /  ")
      _fpp(" ftp : / / / si te : po rt / / fi le . ex t ")
      _fpp(" ftp : / / / si te : po rt / / di r0 / / ")
      _fpp(" ftp : / / / si te : po rt / / di r0 / / fi le . ex t ")
      _conl(); _conl("##  //.  ######################################################################################"); _conl()
      _fpp(" / / . ")
      _fpp(" / / . / / ")
      _fpp(" / / . / / com 56 ")
      _fpp(" / / . / / com 56 / / ")
      _fpp(" / / . / / c : ")
      _fpp(" / / . / / c : / / ")
      _fpp(" / / . / / c :  com 56 ")
      _fpp(" / / . / / c :  com 56 / / ")
      _fpp(" / / . / / c : / / com 56 ")
      _fpp(" / / . / / c : / / com 56 / / ")
      _conl(); _conl("##  //?  ######################################################################################"); _conl()
      _fpp(" / / ? ")
      _fpp(" / / ? / / ")
      _fpp(" / / ? / / com 56 ")
      _fpp(" / / ? / / com 56 / / ")
      _fpp(" / / ? / / c : ")
      _fpp(" / / ? / / c : / / ")
      _fpp(" / / ? / / c :  com 56 ")
      _fpp(" / / ? / / c :  com 56 / / ")
      _fpp(" / / ? / / c : / / com 56 ")
      _fpp(" / / ? / / c : / / com 56 / / ")
      _conl(); _conl("########################################################################################"); _conl()
      _fpp(" / /  /  ")
      _fpp(" / /  / . hs t ")
      _fpp(" / /  / / fi le . ex t ")
      _fpp(" / /  / / di r0 / / ")
      _fpp(" / /  / / di r0 / / di r1 / fi le . ex t ")
      _fpp(" / /  / / c : ")
      _fpp(" / /  / / c : fi le . ex t ")
      _fpp(" / /  / / c : di r0 / / ")
      _fpp(" / /  / / c : di r0 / / fi le . ex t ")
      _fpp(" / /  / / c : / / ")
      _fpp(" / /  / / c : / / fi le . ex t ")
      _fpp(" / /  / / c : / / di r0 / / ")
      _fpp(" / /  / / c : / / di r0 / / fi le . ex t ")
      _conl(); _conl("########################################################################################"); _conl()


      return }
# this is somnitelno: that   / / . / / com 56 / / - is the DEV...; what is DEV ??? this already PROBLEM
#_____________________________________________________________________________
func	_patharr0(D,q, i,h,A,B) { ##############################################
      delete D; if ( 0<q=split(gensub(/\\/,"/","G",gensub(/ *([:$\\\/]) */,"\\1","G",gensub(/(^[ \t]+)|([ \t]+$)/,"","G",q))),A,/\/+/,B) ) {
            if ( 2>h=length(B[1]) )		{ D["type"]="FILE"; A[1]=_patharr0_i0(A[1],D,"drive"); return _patharr0_i1(D,A,1,q) }
            i=gensub(/ *([\.\?]) */,"\\1","G",A[2]); IGNORECASE=1; match(A[1],/^((https?)|(ftp)):$/); IGNORECASE=0
                  if ( RLENGTH>0 )		{ D["type"]=toupper(substr(A[1],1,RLENGTH-1)); _patharr0_i0(i,D,"site","port") }
            else	if ( A[1]=="" )		{ D["type"]="UNC"; if ( h>2 )		{ D["host"]; A[2]=_patharr0_i0(A[2],D,"drive","","FILE"); return _patharr0_i1(D,A,2,q) }
                                          if ( i=="" )				return 1
                                          D["host"]=i; A[3]=_patharr0_i0(A[3],D,"drive","","FILE") }
                                    else	{ D["type"]="FILE"; A[1]=_patharr0_i0(A[1],D,"drive"); return _patharr0_i1(D,A,1,q) } return _patharr0_i1(D,A,3,q) } }
      #_____________________________________________________
      func	_patharr0_i0(t,D,l,r,d, i) { if ( i=index(t,":") )	{ if ( d )				D["type"]=d
                                                                  if ( i>1 )				D[l]=substr(t,1,i-1)
                                                                  if ( (t=substr(t,i+1)) && r )	D[r]=t; return t }
                                                            else	if ( t && r )			D[l]=t; return t }
      #_____________________________________________________
      func	_patharr0_i1(D,A,i,q, t,c)	{ if ( D["type"]=="UNC" )	{ if ( t=A[i++] )		D[0]=(D["share"]=D[++c]=t) "/"; else return 1 }
                                          while ( i<q )	D[0]=D[0] (D[++c]=A[i++]) "/"
                                          if ( i==q )		{ if ( match(t=A[i],/\.[^\.]*$/) )	{ if ( RSTART>1 )		D["name"]=substr(t,1,RSTART-1); D["ext"]=substr(t,RSTART,RLENGTH) }
                                                                                          else	if ( t!="" )		D["name"]=t } return 1 }


func	_fpp(q, D,S) {
      _conl(); _conline(q); _conl();
      q=_patharr0(S,q)
      #_arregpath(D,S)
      #_conl(_dumparr(D))
      _conl( _dumparr(S)); _conl()
      
      return q }


func	_rpp(q, D,S) {
      _conl(); _conline(q); _conl();

      _regpath0(D,q)
      #_conl(_dumparr(D))

      _conl(_ln("DEST:") _dumparr(D)); _conl()
      return q }
      
func	_split_regpath() {
      _rpp(" / /  / /   ")
      _rpp(" / /  / / huj  ")
      _rpp(" / /  / / huj /  ")
      _rpp(" / /  / / huj / pizda.TSR  ")
      _rpp(" / /  / / hklm  ")
      _rpp(" / /  / / hklm /  ")
      _rpp(" / /  / / hklm / huj ")
      _rpp(" / /  / / hklm / huj / ")
      _rpp(" / /  / / hklm / huj / 	pizda.TSR  ")
      _conl(); _conl("########################################################################################"); _conl()
      _rpp(" / /  / / hklm / software / altiris /  fi le . ex t ")
      _rpp(" / / . / / hkcr / software / altiris /  fi le . ex t ")
      _rpp(" / / ? / / hKcU / software / altiris /  fi le . ex t ")
      _rpp(" / / lOcAlHoSt / / hKu / software / altiris /  fi le . ex t ")
      _rpp(" / / ho st / / hKcc / software / altiris /  fi le . ex t ")
      _rpp(" / / ho st / / hKPd / software / altiris /  fi le . ex t ")
      _conl(); _conl("########################################################################################"); _conl()
      
      
      
      }
# test with the different path types
#	_conl(_ln("SRC:") _dumparr(S)); _conl();

func	_ini(p,cs, dptr,pfx,sfx,hstr,lstr) {
      return _inituid(p,cs, dptr,pfx,sfx,hstr,lstr,A) }
      
#_______________________________________________________________________
func	_inituid(p,cs, dptr,pfx,sfx,hstr,lstr,A) { ################### 1 #
      if ( cs==0 && cs=="" )										{ cs=p; p=_getuid() }

      _conl(); _conl(); _conl(cs)

      if ( match(cs,/^(([^:]*):)?(([^'\xB4]*\xB4.)*[^'\xB4]*)[']/,A) )			{ pfx=A[3]; dptr=A[2] }
      if ( match(cs=substr(cs,1+RLENGTH),/'(([^'\xB4]*\xB4.)*[^'\xB4]*)$/,A) )	{ sfx=A[1]; cs=substr(cs,1,RSTART-1) }
      if ( match(cs,/^(([`\^])(.*))/,A) )								{ if ( A[2]=="`" )	{ hstr=A[3] "~"; lstr="" } else { lstr=A[3] "+"; hstr="" } }
      else	if ( match(cs,/^(([^'\xB4\|]*\xB4.)*[^'\xB4\|]*)(\|(.*))?/,A) )		{ hstr=A[1]; lstr=A[4] }
      else	{ ERRNO="_inituid(): bad parameters"; return }

      _conl(dptr ":" pfx "'" hstr "|" lstr "'" sfx)

      return _cfguid(p,dptr,pfx,sfx,hstr,lstr) }

#			dptr			- morg ptr; in case if object deleted then _CLASSPTR[ptr] will be deleted(object is death), but
#							_tUIDEL[_CLASSPTR[ptr]] will be created that object can be resurrected from morg
#							dptr can be any string containing any characters except `:'. It's not verified
#			pfx,sfx		- uid prefix str, and uid suffix str; this strings specifies string that can be inserted before/after
#							uid generated by uid generator:
#
#								class uid:			pfx uidgen sfx
#
#							Both can be any string(including ""), and can contains any character with B4-escaping feature.
#							Note: that this strings cannot contains "'" character: it's should be escaped by B4-escaper.
#			hstr,lstr		- this values configure uid-generator itself. ther is a 3 combinations regarding its:
#
#								hstr			lstr			function
#
#								`ptr			*			- specify pointer to external uid-generator
#														All uids and chars will be generated by external uid-generator
#								*			^ptr			- class will have it's own uid generator using external character set
#								str			str			- class will have it's own uid generator with it's own character set
#														character set inmplemented in hstr(high-charset) and in lstr(low-charset) in 2 ways:
#							1)	"AB"			"AB01"			- this mean that high-charset contain chars: `A' and `B'
#																low-charset contains chars: `A', `B', `0', `1'
#
#							2)	"Az,By"		"Ax,Bw,0v,1u"		- this mean that high-charset contain chars: `Az' and `By'
#																low-charset contains chars:  `Ax', `Bw', `0v', `1u'
#															Note: both: hstr and lstr cannot contain char `,' directly, but it's can uses
#																	B4-escaper to escape any char including `,'



# !!!! in case of using `,' in hstr/lstr - the escaped `,' will leads to interpretate hstr and lstr as divided by `,'
# if parameters error then i should be more specific about what error in parameters detected
# document _inituid(): parameters; document cs: uid initialization string format
# test with escape char
# adv hstr and lstr splitting?
# chk if hstr len==0 ?
# return _tclass & report error?
# _tapi thru function

# additional syntax checking ???
# implement syntax and uid srv in docs
# add _dumpuid() ????
# make performance measurement
# protection against badchar list
# additional feature to specify _getuid() to not resurrect uid; and informative that uid was ressurected or not
# build _defclass fn

# _tuidinitcs ????
# _tuidchrh[p]
# _tuidchrl[p]
# _tuidchr[p]
# _tuidcnt[p]
# _tUIDPFX[p]
# _tUIDSFX[p]
# _tUIDEL
# _tUIDCNTH
# _tUIDCNTL
# _tUIDCHRL
# _tUIDCHRH

# create default class basic `new' and `del' functions



func	_tstini() {
                  _ini("uidel:pfx'hstr|lstr'sfx")
                  _ini("uidel:pfx'hstr|lstr'")
                  _ini("uidel:'hstr|lstr'sfx")
                  _ini("uidel:'hstr|lstr'")
                  _ini("uidel:pfx'hstr'sfx")
                  _ini("uidel:pfx'hstr'")
                  _ini("uidel:'hstr'sfx")
                  _ini("uidel:'hstr'")
      _conl(); _conl("########################################################################################"); _conl()
                  _ini("pfx'hstr|lstr'sfx")
                  _ini("pfx'hstr|lstr'")
                  _ini("'hstr|lstr'sfx")
                  _ini("'hstr|lstr'")
                  _ini("pfx'hstr'sfx")
                  _ini("pfx'hstr'")
                  _ini("'hstr'sfx")
                  _ini("'hstr'")
      _conl(); _conl("########################################################################################"); _conl()
                  _ini("uidel:pfx'`cntptr'sfx")
                  _ini("uidel:pfx'`cntptr'")
                  _ini("uidel:'`cntptr'sfx")
                  _ini("uidel:'`cntptr'")
      _conl(); _conl("########################################################################################"); _conl()
                  _ini("pfx'`cntptr'sfx")
                  _ini("pfx'`cntptr'")
                  _ini("'`cntptr'sfx")
                  _ini("'`cntptr'")
      _conl(); _conl("########################################################################################"); _conl()
                  _ini("uidel:pfx'^chrptr'sfx")
                  _ini("uidel:pfx'^chrptr'")
                  _ini("uidel:'^chrptr'sfx")
                  _ini("uidel:'^chrptr'")
      _conl(); _conl("########################################################################################"); _conl()
                  _ini("pfx'^chrptr'sfx")
                  _ini("pfx'^chrptr'")
                  _ini("'^chrptr'sfx")
                  _ini("'^chrptr'")
      _conl(); _conl("########################################################################################"); _conl()


                  }
                  
func	_rtn(v,A) {
      _conl(); _conline(_val(v) " : " _val(A)); _conl()
      
      _rtn2(v,A)
      
      _conl() }

func	_rtn2(v,A, r,t) {

      r=isarray(A) ? _typa(v,A) : _typ(v)
      
      if ( "`">_t0 && _t0 )	_conl("ggggg")
      
      t=(r ? "TRUE" : "FALSE") " / " (r>0 ? r ">0" : r "!>0") " / " (r+0>0 ? r "+0>0" : r "+0!>0") " / " (r+0!=r ? r "+0!=" r : r "+0==" r)		" / " (r && "`">r ? "'`'>" r " && " r : "!('`'>" r " && " r")")

            _conl("`" r "' : " t)
      
      return r }




func	_typ(p) {
      return _t0=isarray(p) ? "#" : p==0 ? p=="" ? 0 : p in _CLASSPTR ? "`" : p ? 3 : 4 : p in _CLASSPTR ? "`" : p+0==p ? 5 : p ? 3 : 2 }

func	_typa(p,A) {

      return _t0=isarray(p) ? "#" : p==0 ? p=="" ? 0 : p in A ? "`" : p ? 3 : 4 : p in A ? "`" : p+0==p ? 5 : p ? 3 : 2 }

#			#		- p is array
#			`		- p is ptr detected in array _CLASSPTR(for _typ); or p is ptr detected in array A(for _typa)
#			0		- p is undefined

#			2		- p is string==""
#			3		- p is string!=""
#			4		- p is number 0
#			5		- p is any number except 0(positive and negative)

# str:			_typ(p)+0		!_typ(p)+0
# str/ptr			_typ(p)>0		_typ(p)<1
# str/arr			"`">_typ(p0) && _t0
# str/ptr/arr		_typ(p)		!_typ(p)
# ptr				_typ(p)=="`"	_typ(p)<"`"  ?
# ptr/arr			_typ(p)+0!=_t0
# arr				_typ(p)=="#"	_typ(p)>"#"  ?

func	zorr(A,i, r) {
      if ( i in A )		_conl("`" i "' in A"); else	_conl("`" i "' not in A")
      r=A[i]=="" && A[i]==0
      _conl("A[" i "] status is " r)
      return
      
      a=a+-a
      _conl("``````````````" a "''''''''''''''''") }





















func	test_splitstr(A) {

      AA0[-1]="huj"; AA0["A"]="pizda"; AA0[1]="zhopa"
      delete AB0[AB0[""]=""]
      AC0[-1]="HUJ"; AC0["A"]="PIZDA"; AC0[1]="ZHOPA"
      
      _SPLITSTRB0["1"]
      
      
      wonl=""
      _tstv(0,A,0,"_tstv")
      _conl(wonl)
      _wrfile("wonl.out",wonl)
      }



func	_tstv(p,A,r,f) {

      if ( f=="" )	f="tst_splitstr"

      @f(_NOP,A,p)
      @f(AA0,A,p)
      @f(AB0,A,p)
      @f(AC0,A,p)
      @f("",A,p)
      @f("a",A,p)
      @f("´a",A,p)
      @f("´",A,p)
      @f("a´´´,ba´´´,",A,p)
      @f("´,",A,p)

      @f(",",A,p)
      @f("´a,",A,p)
      @f("ab,",A,p)
      @f("ab,´",A,p)
      @f("´a´,,ba",A,p)
      @f(",a,,b´,c,,´a,,´,,,",A,p)

      }

func	_wonl(t) {
      wonl=wonl _ln(t) }

func	_wonline(t) {
      wonl=wonl _ln(substr(" _ " t " _____________________________________________________________________________________________________________________________________",1,126)) }

func	tst_splitstr(t,A,R, r) {
      delete A; A["not cleared"]
      _wonl()
      _wonline("_splitstr(" (isarray(t) ? "ARR" (length(t)>0 ? "#" (t[1]!="zhopa" ? "U" : "l") : "") : _val0(t)) ",A" (isarray(R) ? ",        ARR" (length(R)>0 ? "#" (R[1]!="zhopa" ? "U" : "l") : "") : ",        " _val0(R)) "):")

      _wonl( _val0(r=_splitstr(t,A,R)))
      _wonl("arrary A:"); _wonl(_dumparr(A))
      return r }


      #_____________________________________________________________________________
      func	_val(v,t)	{ if ( isarray(v) )	return _dumparr(v) _ln(t)
                        if ( v==0 && v=="" )	return _ln("- (ERRNO=" ERRNO ")") _ln(t)
                                                return _ln(v "'") _ln(t) }

      #_____________________________________________________________________________
      func	_val0(v)	{ if ( isarray(v) )	return _dumparr(v)
                        if ( v==0 && v=="" )	return "-"
                                                return "\"" v "\"" }

# add to _dumparr: checking that if element is undefined


















#_______________________________________________________________________
func	_cfguid(p,optr,pfx,sfx,hstrcnt,lstrchr) { #################### 0 #
      delete _UIDOBL[p]
      if ( _isptr(optr) )		{ if ( optr==p )		{ delete _UIDOBLV[p]; delete _UIDOBLV[_UIDOBLV[_UIDOBL[p]=p][""]=p][""] }
                                                      else	if ( optr in _UIDOBL )		_UIDOBL[p]=_UIDOBL[optr] }
      _UIDPFX[p]=_istr(pfx) ? pfx : ""; _UIDSFX[p]=_istr(sfx) ? sfx : ""
      if ( _isptr(hstrcnt) )		{ if ( hstrcnt!=p )	{ _UIDCHR[p]=_UIDCHR[_UIDCNT[p]=_UIDCNT[hstrcnt]]; return p } hstrcnt=_NOP }
      _UIDCNTL[_UIDCNT[p]=p]=_cfguidchr(p,hstrcnt,lstrchr); return p }
      #_____________________________________________________
      func	_cfguidchr(p,h,l, H,L) {
            if ( _isptr(l) )				{ if ( l!=p )	return _UIDCHR[p]=_UIDCHR[l]; _UIDCHR[p]=p; l=_NOP }
            _UIDCHR[p]=p
            _splitstr(H,h,_UIDCHRH[_classys]); _splitstr(L,l,H)
            delete _UIDCHRH[_UIDCHRH[p][""]=p][""]; delete _UIDCHRL[_UIDCHRL[p][""]=p][""]
            _cfguidh(p,H,L); return _cfguidl(p,L,L) }
            #_______________________________________________
            func	_cfguidh(p,H,L, hi,h,li)	{ for ( hi=1; hi in H; hi++ )		{ h=H[hi]
                                                                                    for ( li=1; li in L; li++ )	_UIDCHRH[p][h L[li]] } }
            func	_cfguidl(p,H,L, hi,h,hl,li)	{ for ( hi=1; hi in H; hi++ )		{ h=H[hi]
                                                                                    for ( li=1; li in L; li++ )	hl=_UIDCHRL[p][hl]=h L[li] }
                                                return hl }

# problem configuring uid by array charset: i can' understand what format of the array: possibly - remove array support
# after removal of array format detection: there is unfinished conflicts: it is possible to totally remove array uid-gen initialization

      #_____________________________________________________
      BEGIN	{ _inituidefault() }
            func	_inituidefault( h,l,H,L) {
                  _classys		=""

                  delete _UIDOBLV[_UIDOBLV[_UIDOBL[_classys]=_classys][""]=_classys][""]
                  _UIDPFX[_classys]; _UIDSFX[_classys]
                  _UIDCNT[_classys]=_UIDCHR[_classys]=_CLASSPTR[_classys]=_classys

                  h	="AB"
                  l	=h "01"
                                                
                  _splitstr(H,h); _splitstr(L,l);
                  delete _UIDCHRH[_UIDCHRH[_classys][""]=_classys][""]; delete _UIDCHRL[_UIDCHRL[_classys][""]=_classys][""]
                  _UIDCNTH[_classys]; _cfguidh(_classys,H,L); _UIDCNTL[_classys]=_cfguidl(_classys,L,L)
                                                
                  _CLASSFN[_classys]["del"]		="_tobjDEL"
                  _CLASSFN[_classys]["new"]		="_tobjNEW"
                  _drawuid(_classys)
                  _initspecialuid() }
                  #_________________________________________
                  func	_initspecialuid() {
                        _NOINDEX	=_getuid()
                        _LEN		=_getuid()
                        _PTR		=_getuid()
                        _NAME		=_getuid()
                        _TYPE		=_getuid()
                        _FORMAT	=_getuid()

                        }
#_______________________________________________________________________
func	_getuid(p) { ################################################# 1 #
      if ( p in _UIDOBL )	{ for ( _tptr in _UIDOBLV[_getuida0=_UIDOBL[p]] )	{ delete _UIDOBLV[_getuida0][_tptr]; _CLASSPTR[_tptr]=p; return _tptr } }
      _CLASSPTR[_tptr=_UIDPFX[p] _getuid_i0(_UIDCNT[p],_UIDCHRL[_tptr=_UIDCHR[p]],_UIDCHRH[_tptr]) _UIDSFX[p]]=p
      return _tptr }
      #_____________________________________________________
      func	_getuid_i0(p,UL,UH)	{ if ( ""==_tptr=UL[_UIDCNTL[p]] )	{ for ( _tptr in UH )	{ delete UH[_tptr]; return (_UIDCNTH[p]=_tptr) (_UIDCNTL[p]=UL[""]) }
                                                                        _fatal("out of UID") }
                                    return _UIDCNTH[p] (_UIDCNTL[p]=_tptr) }
#_______________________________________________________________________
func	_deluid(p) { ################################################# 1 #
      if ( p in _CLASSPTR )	{ _deluida0=_CLASSPTR[p]
                              if ( _deluida0 in _UIDOBL )	_UIDOBLV[_UIDOBL[_deluida0]][p] }
      delete _CLASSPTR[p]; return _deluida0 }
            
func	test_uid( p,i) {
      #test_cfg()
      #return

      _fclass=_cfguid(p=_getuid(_classys),p,"pfx","sfx","abc")
      #_fclass=_cfguid(p=_getuid(_classys),_NOP,_NOP,_NOP,"",_classys)
      _conl("_fclass uid: " _getuid(_fclass)); _drawuid(_fclass)
      _conl("_classys uid: " _getuid(_classys))_drawuid(_classys)
      for ( i=1; i<81; i++ )		_conl(i ": " _getuid(_fclass))
      _drawuid(_fclass)
      }


func	test_cfg( p,z,AA0,a) {
      AA0[1]
      
      _fclass=_cfguid(p=_getuid(_classys),_NOP,_NOP,_NOP,_NOP,_classys); _conl(); _conline(); _conl(); _drawuid(p)
      _fclass=_cfguid(p=_getuid(_classys),AA0,AA0,AA0,AA0,_classys); _conl(); _conline(); _conl(); _drawuid(p)
      a=_getuid(z=_fclass=_cfguid(p=_getuid(_classys),p,"<",">","ab","cd")); _conl("### " a "########"); _conline(); _conl(); _drawuid(p)
      a=_getuid(_fclass=_cfguid(p=_getuid(_classys),z,0,0,_NOP,z)); _conl("### " a "########"); _conline(); _conl(); _drawuid(p)
      a=_getuid(_fclass=_cfguid(p=_getuid(_classys),z,"^","$",z,_classys)); _conl("### " a "########"); _conline(); _conl(); _drawuid(p)
      _fclass=_cfguid(p=_getuid(_classys),"oblptr","pfx","sfx","abcd"); _conl(); _conline(); _conl(); _drawuid(p)
      
      
      _conl("```````````````````" z "'''''''''" ( _isptr(z) ? " ptr" : " not ptr"))
      _drawuid(z)
      }














func _drawuid(p, cn,ch,o) {
      _conl("uid: " p)
      _conl("\toblptr: " (p in _UIDOBL ? _UIDOBL[p] "'" : "-"))
            if ( p in _UIDOBL )	{ if ( !_isptr(o=_UIDOBL[p]) )	_conl(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> oblptr not pointer")
                                    if ( !isarray(_UIDOBLV[o]) )	_conl(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> no OBLV array at ptr") }

      _conl("\tprefix:   " (p in _UIDPFX ? _UIDPFX[p] "'" : "-"))
      _conl("\tsuffix:   " (p in _UIDSFX ? _UIDSFX[p] "'" : "-"))
      _conl("\tcounters: " (cn=p in _UIDCNT ? _UIDCNT[p] "'" : "-"))
      if ( cn!="-" )	{ _conl("\t\tcntrL:   " _UIDCNTL[_UIDCNT[p]] "'")
                        _conl("\t\tcntrH:   " _UIDCNTH[_UIDCNT[p]] "'") }
      _conl("\tcharset:  " (ch=p in _UIDCHR ? _UIDCHR[p] "'" : "-"))
      if ( ch!="-" )	{ _conl("chrH:    "); _conl(_dumparr(_UIDCHRH[_UIDCHR[p]])); _conl()
                        _conl("chrL:    "); _conl(_dumparr(_UIDCHRL[_UIDCHR[p]])); _conl() }


      }
























#_______________________________________________________________________
func	_splitstr(A,t,r) { ########################################### 1 #
      if ( _istr(t) )	{ if ( _splitstr_i0(A,t)>0 )		return _splitstrp0
                        if ( _istr(r) )				return _splitstr_i0(A,r) }
                  else	{ if ( it=="A" )				if ( length(t)>0 )	{ _movarr(A,t); return 0-length(A) }; _istr(r) }
      if ( it=="A" )							if ( length(r)>0 )	{ _movarr(A,r); return 0-length(A) } }
      #_____________________________________________________
      func	_splitstr_i0(A,t, C) {
            if ( 2>_splitstrq0=patsplit(t,_SPLITSTRA0,/([^,\xB4]*\xB4.)*[^,\xB4]*/) )	_splitstrq0=split(gensub(/\xB4(.)/,"\\1","G",t),_SPLITSTRA0,"")
            delete A; _splitstri0=_splitstrp0=0
            while ( _splitstri0++<_splitstrq0 ) {
                  if ( (t=gensub(/\xB4(.)/,"\\1","G",_SPLITSTRA0[_splitstri0])) in C || t=="" )		continue
                  C[A[++_splitstrp0]=t] }
            return _splitstrp0 }

# there is problem with string's format: i can;t easilly merge 2 charsets: comma-divided and every-char-divided strings

#_______________________________________________________________________
func	_isptr(p) { ################################################## 1 #
      if ( isarray(p) )					{ is=_NOP; it="A"; return 0 }
      is=p; if ( p==0 && p=="" )			{ it="-"; return 0 }
      if ( p in _CLASSPTR )				return it="P"
      it="S"; return 0 }
#_______________________________________________________________________
func	_istr(p) { ################################################### 1 #
      if ( isarray(p) )					{ is=_NOP; it="A"; return 0 }
      is=p; if ( p==0 && p=="" )			{ it="-"; return 0 }
      return it=p=="" ? "s" : "S" }

#______________________________________________________________________________________________
func	_START( t,i,A) { #########################################################################
      _torexp_init()
      test_uid()
      return
      _conl(patsplit("a,b,c",A,/[^,]/,B))
      test_splitstr(); return


      A[""]; _CLASSPTR["ptr"]; ALTARR["ptra"]
      _conl(_dumparr(SYMTAB))
      BB[1]=_NOP
      zorr(1,2,3,4,5,6)
      zorr(BB,1)
      
      
      _rtn()
      _rtn("")
      _rtn(0); _rtn("0")
      _rtn(1); _rtn("1")
      _rtn(-1); _rtn("-1")
      _rtn("huj")
      _rtn("ptr")
      _rtn("ptra",ALTARR)
      _rtn(ALTARR)
      _rtn(ALTARR,ALTARR)


      return
      _tstini()
      
      return

      _splitpath_test()
#	_split_regpath()
      return

      hh="CPU"
      _conl("go1!")
      _conl(_var(_sharepath(hh,"gdfsgdsgsd sdgsdighjui teretiewrotrewut 345345345 rtjtireutireu huj")))
      _conl("go2!")
      _conl(_var(_sharelist(AAA,hh),_dumparr(AAA)))
      _conline()
      A[1]="h"
      A[3]="j"
      t="pizda"
      if ( match(t,/^pi(Z)da/,A) )	_conl("match")
                              else	_conl("not match")
      _conl(_dumparr(A))
      return







      _pathSMA="C:\\Program Files\\Altiris\\Altiris Agent\\"
      
      
      DSPlugInPath		=_pathSMA "Agents\\Deployment\\Agent\\"
      DSAutoPath			=_pathSMA
      
      if ( !_sysinfo(_SYS,_hostname) )		_fatal("_sysinfo: unknown error")
      _REG[""]; delete _REG[""]
      _servoutput=_CHR["EOL"] _cmd("sc query state= all")

      _dsbasepath="\\\\CPU\\CPU\\DEV\\PROJECT\\_DS\\"
      _rdreg(_REG,"HKEY_LOCAL_MACHINE\\SOFTWARE\\Altiris")
      _wrfile("rego.txt",_dumparr(_REG)); _conl("fF")
      #_______________________________________________________________________

      c=_getreg_i1(DDD,"HKEY_LOCAL_MACHINE\\SOFTWARE\\Altiris\\Altiris Agent\\Plugin Objects\\„~.*”Install path",_REG)
#_________________________________________________________________________________________
      pp=_n("NAME","NS")
      #pp=_n()
      #___________________________________________________________________________________
            p=_defsolution(pp,"DS Plug-in","HKEY_LOCAL_MACHINE\\SOFTWARE\\Altiris\\Altiris Agent\\Plugin Objects\\Agents\\")
                  ClientConfiguration		=_defdll(p,"Client Configuration","ClientConfiguration")
                  ClientImagingPrep			=_defdll(p,"Client Inaging Preparation","ClientImagingPrep")
                  ClientImaging			=_defdll(p,"Client Imaging","ClientImaging")
                  ClientPCT				=_defdll(p,"Client PCT","ClientPCT")
                  ClientRebootTo			=_defdll(p,"Client Reboot To","ClientRebootTo")
                  DeploymentAgent			=_defdll(p,"Deployment Agent","Deployment Agent")
                  DeploymentSolutionBaseAgent	=_defdll(p,"Deployment Solution Base Agent","Deployment Solution Base Agent")
                  
                  ClientBCDEdit			=_defile(p,"Client BCD Edit","ClientBCDEdit.dll")
                  ClientCopyFile			=_defile(p,"Client Copy File","ClientCopyFile.dll")
                  ClientPreImage			=_defile(p,"Client Pre Image","ClientPreImage.dll")
                  ClientRebootTo			=_defile(p,"Client Reboot To","ClientRebootTo.dll")
                                                 _defile(p,"ConfigService.exe","ConfigService.exe","")
                                                 _defile(p,"config.dll","config.dll","")

                                                 _defsrv(p,"DS Plug-in Service","Altiris Deployment Solution - System Configuration")
                                                 _defreg(p,"Deployment Agent Path","HKEY_LOCAL_MACHINE\\SOFTWARE\\Altiris\\Deployment\\AgentInstallPath.STR")
                                                 _defile(p,"Altiris_DeploymentSolutionAgent_7_1_x86.msi",										_SYS["OSArchitecture"]=="64-bit" ? 											"C:\\Program Files\\Altiris\\Altiris Agent\\Agents\\SoftwareManagement\\Software Delivery\\{9D76E4CA-377A-472D-A82E-EDAD77E7E4ED}\\cache\\Altiris_DeploymentSolutionAgent_7_1_x64.msi"										:	"C:\\Program Files\\Altiris\\Altiris Agent\\Agents\\SoftwareManagement\\Software Delivery\\{4B747D25-612F-48FC-B6B5-9916D1BB755C}\\cache\\Altiris_DeploymentSolutionAgent_7_1_x86.msi","")
                                                 _defdir(p,"Deployment Folder",a=gensub(/[^\\]*$/,"",1,_rdsafe(_REG,"HKEY_LOCAL_MACHINE\\SOFTWARE\\Altiris\\Deployment\\AgentInstallPath.STR","C:\\Program Files\\Altiris\\Altiris Agent\\Agents\\Deployment\\Agent\\")))

       #___________________________________________________________________________________
            p=_defsolution(pp,"DS Auto","HKEY_LOCAL_MACHINE\\SOFTWARE\\Altiris\\Altiris Agent\\Plugin Objects\\Agents\\")
                                                 _defdir(p,"C:\\Boot\\Altiris\\iso\\boot\\fonts\\","C:\\Boot\\Altiris\\iso\\boot\\fonts\\")
                                                 _defdir(p,"C:\\Boot\\Altiris\\iso\\sources\\","C:\\Boot\\Altiris\\iso\\sources\\")
                                                 
                                                 _defile(p,"C:\\Boot\\Altiris\\iso\\autoinst.exe","C:\\Boot\\Altiris\\iso\\autoinst.exe","")
                                                 _defile(p,"C:\\Boot\\Altiris\\iso\\autoinst.ini","C:\\Boot\\Altiris\\iso\\autoinst.ini","")
                                                 _defile(p,"C:\\Boot\\Altiris\\iso\\autoutil.exe","C:\\Boot\\Altiris\\iso\\autoutil.exe","")
                                                 _defile(p,"C:\\Boot\\Altiris\\iso\\autoutil.ini","C:\\Boot\\Altiris\\iso\\autoutil.ini","")
                                                 _defile(p,"C:\\Boot\\Altiris\\iso\\bcdedit.exe","C:\\Boot\\Altiris\\iso\\bcdedit.exe","")
                                                 _defile(p,"C:\\Boot\\Altiris\\iso\\bootmgr","C:\\Boot\\Altiris\\iso\\bootmgr","")
                                                 _defile(p,"C:\\Boot\\Altiris\\iso\\bootsect.exe","C:\\Boot\\Altiris\\iso\\bootsect.exe","")
                                                 
                                                 _defreg(p,"Deployment Automation reg.File","HKEY_LOCAL_MACHINE\\SOFTWARE\\Altiris\\AutoUtil\\File.XSZ","autoutil.exe")
                                                 _defreg(p,"Deployment Automation reg.Path","HKEY_LOCAL_MACHINE\\SOFTWARE\\Altiris\\AutoUtil\\Path.XSZ","%systemdrive%\\boot\\altiris\\iso")
#_________________________________________________________________________________________

      _check(pp)
#_________________________________________________________________________________________
      
      _conl(_report(pp)); _wrfile("report.txt",_report(pp))
}#______________________________________________________________________________________________
func	_END() { #################################################################################

}#______________________________________________________________________________________________
func	_EXIT() { ################################################################################

}#____________________________________________________________________________________________________
func	_check(p) { ####################################################################################
      _dll_check(p)
      _file_check(p)
      _serv_check(p)
      _reg_check(p) }
#_________________________________________________________________________________________
func	_report(p) { #######################################################################
      _report_t0=_reportparnt=""; _report_i0(p); _tframe("_report_i0",p)
      return _report_t0 }
            
      func	_report_i0(p,p0,p1,p2) { if ( p in _tPARENT ) {
                                          if ( _reportparnt!=_reportparnt=_tPARENT[p] ) {
                                                _report_t0=_report_t0	_ln()												_ln((z="_ " _[_tPARENT[p]]["NAME"] " ") _getchrln("_",_CON_WIDTH-length(z)-2))												_ln(_getchrln("#",_CON_WIDTH-2))												_ln() } }
            if ( "ERROR" in _[p] )	{ _report_t0=_report_t0 _reporterr(p,_[p]["ERROR"])}
            if ( "REPORT" in _[p] )	{ _report_t0=_report_t0 _ln(_[p]["REPORT"]) } }
#___________________________________________________________________________________
func	_creport(p,t,f, z) {
      _[p]["REPORT"]=_[p]["REPORT"] _ln(t (f=="" ? "" : ": " f)) }
#___________________________________________________________________________________
func	_reporterr(p,t3, pp,t,t2) {
      t=""; pp=p
      do { "NAME" in _[pp] ? t=_[pp]["NAME"] ": " t : "" } while ( pp=_rPARENT(pp) )
      if ( match(t3,/\x00/) )		return substr(t3,1,RSTART-1) t substr(t3,RSTART+1)
      return t t3 }
#___________________________________________________________________________________
func	_dllerr(p,t,f)	{ if ( t!~/\x00/ )	t="ERROR: \x00" t
                        _errfl=1; _[p]["ERROR"]=_[p]["ERROR"] _ln(t (f=="" ? "" : ": " f)) }


#_______________________________________________________________________________________________
func	_defsolution(pp,n,rn, p) { ###############################################################
      _[p=_wLCHLD(pp,_n("TYPE","solution"))]["NAME"]=n
      _[p]["REGPATH"]=rn
      _[p]["ERRHOST"]=pp
      return p }
#_________________________________________________________________________________________
func	_defreg(pp,n,f,v, p) { #############################################################
      _[p=_wLCHLD(pp,_n("TYPE","defreg"))]["NAME"]=n
      _[p]["REGPATH"]=f; if ( !(v==0 && v=="") )	_[p]["VALUE"]=v }
      #_______________________________________________________________________
      func	_reg_check(p) { _tframe("_reg_check_i0",p,p) }
            #_______________________________________________
            func	_reg_check_i0(p,pp,p1,p2) {
                  if ( _[p]["TYPE"]=="defreg" ) {
                        if ( _[p]["REGPATH"] in _REG ) {
                              if ( "VALUE" in _[p] )	{ if ( _[p]["VALUE"]==_REG[_[p]["REGPATH"]] )			_creport(p,substr("OK:    REGENTRY MATCH(==" _[p]["VALUE"] "): " _[p]["REGPATH"],1,126))
                                                                                                            else	_dllerr(p,substr("REGENTRY NOT MATCH(!=" _[p]["VALUE"] "): " _[p]["REGPATH"],1,126)) }
                                                      else	if ( _VAR[_[p]["REGPATH"]]==_REG[_[p]["REGPATH"]] )	_creport(p,substr("OK:    REGPATH MATCH(==" _VAR[_[p]["REGPATH"]] "): " _[p]["REGPATH"],1,126))
                                                                                                            else	_dllerr(p,substr("REGPATH NOT MATCH(!=" _VAR[_[p]["REGPATH"]] "): "  _[p]["REGPATH"],1,126)) }
                        else	{ _dllerr(p,substr("REGPATH NOT FOUND: " _[p]["REGPATH"],1,126)) } } }
#_________________________________________________________________________________________
func	_defdir(pp,n,f,v, p) { #############################################################
      _[p=_wLCHLD(pp,_n("TYPE","defdir"))]["NAME"]=n
      _[p]["DIR"]=f
      return p }
#_________________________________________________________________________________________
func	_defile(pp,n,f,v, p) { #############################################################
      _[p=_wLCHLD(pp,_n("TYPE","defile"))]["NAME"]=n
      _[p]["FILE"]=f; if ( !(v==0 && v=="") )		_[p]["RQVERSION"]=v
      return p }
      #_______________________________________________________________________
      func	_file_check(p)	{ if ( 1 || "AGENT" in _[p] )	{ _tframe("_file_check_i0",p,p) } }
            #_______________________________________________
            func	_file_check_i0(p,pp,p1,p2, f,v) {
                  if ( _[p]["TYPE"]=="defile" )	{
                        f=_[p]["FILE"]
                        f=(match(f,/^.:/) ? "" : _[_[pp]["AGENT"]][".Install Path"] "\\") _[p]["FILE"]; if ( "RQVERSION" in _[p] )	v=_[p]["RQVERSION"]; else	v=_[pp][".Product Version"]
                        ERRNO=""; if ( _th1(_[p]["DATA"]=_rdfile(f),ERRNO) )		{ delete _[p]["DATA"]; return _dllerr(p,"read file: " ERRNO,f) }
                        if ( v!="" && v!=(_[p]["VERSION"]=_getfilever(f)) )		return _dllerr(p," file version mismatch: ==`" _[p]["VERSION"] "'; !=`" v "'",f)
                        _creport(p,substr("OK:    FILE DETECTED" (v=="" ? "" : "(" v ")") ": " f,1,122)) }
                  else	if ( _[p]["TYPE"]=="defdir" )		{ if ( _filexist(f=_[p]["DIR"]) )	_creport(p,substr("OK:    DIR DETECTED: " f,1,112))
                                                                                          else	_dllerr(p,"directory " f " is not detected") } }
#_________________________________________________________________________________________
func	_defsrv(pp,n,f,v, p) { #############################################################
      _[p=_wLCHLD(pp,_n("TYPE","defsrv"))]["NAME"]=n
      _[p]["SERVNAME"]=f
      return p }
      #_______________________________________________________________________
      func	_serv_check(p) { _tframe("_serv_check_i0",p,p) }
            #_______________________________________________
            func	_serv_check_i0(p,p0,p1,p2,p3, i,q,c) {
                  if ( _[p]["TYPE"]=="defsrv" ) {
                        i=IGNORECASE; IGNORECASE=1
                        if ( match(_servoutput,roi="\\012DISPLAY_NAME: " _torexp(_[p]["SERVNAME"])) )		{ _creport(p,"OK:    SERVICE DETECTED: " substr(_[p]["SERVNAME"],1,112)) }
                                                                                                                  else	{ _dllerr(p,"service " _[p]["SERVNAME"] " not detected") } }
                        IGNORECASE=i }
#_________________________________________________________________________________________
func	_defdll(pp,n,rn, p) { ##############################################################
      _[p=_wLCHLD(pp,_n("TYPE","defdll"))]["NAME"]=n
      _[p]["REGPATH"]=_[pp]["REGPATH"] rn
      _[p]["ERRHOST"]=pp
      return p }
      #_______________________________________________________________________
      func	_dll_check(pp)	{ _dllchktv=""; _missfl=1
                              _tframe("_dll_check_i0",pp,_REG,pp) 					#also check that all dll have same version; also check that all dlls have success and then report that DS plug-in version n - installed
                              if ( 1 || "AGENT" in _[pp] ) {
                                    if ( _dllchktv!=_[pp][".Product Version"] )	_dllerr(_[pp]["AGENT"],"agent version (" _[pp][".Product Version"] ") do not match all lib versions: " _dllchktv "'") }
                              else { if ( !_missfl )						_creport(pp,"agent not detected in registry")
                                                                              else	{ _dllerr(pp,"agent not detected in registry but some registry entries exist:")
                                                                                    _tframe("_dll_check_i1",pp,pp) } } }
            #_______________________________________________
            func	_dll_check_i1(p,pp,p1,p2,p3, i) {
                  if ( _[p]["TYPE"]=="defdll" ) {
                        for ( i in _[p] )		{ if ( i~/^\./ )		_dllerr(pp,"          " _[p]["REGPATH"] "\\" substr(i,2)) } } }
            #_______________________________________________
            func	_dll_check_i0(p,R,pp,p2, i,i2,r,f,v,rs,d,tv,tf) {
                  if ( _[p]["TYPE"]=="defdll" )	{
                        r=toupper(_[p]["REGPATH"]); rs=0; tf=0; tv=""
                        for ( i in R )	{
                                          if ( toupper(substr(i,1,length(r)))==r )	{ if ( (_chka0=substr(i,1+length(r),1))=="" || _chka0=="\\" ) {
                                                                                                rs=1; _missfl=1; _[p]["." substr(gensub(/\....$/,"",1,i),i2=2+length(r),length(i)-i2+1)]=R[i]
                                                                                                if ( chka0!="" )		rs=1 } } }				#{ rs=_missfl=1; _[p]["." gensub(/^([^\\]+\\)+(.*)\..../,"\\2","G",i)]=R[i] } }
                        if ( rs )	{ if ( (i=".Install Path") in _[p] && (i=".Product Version") in _[p] )	{ _[p]["STATUS"]="PRESENT"
                                                                                                            f=_[p][".Install Path"]; v=_[p][".Product Version"]
                                                                                                            if ( !(".Module" in _[p]) )	{ _[pp][".Product Version"]=v; _VAR["HKEY_LOCAL_MACHINE\\SOFTWARE\\Altiris\\Deployment\\AgentInstallPath.STR"]=f; _[pp]["AGENT"]=p; _creport("OK:  DLL DETECTED(" v "): " substr(_[p]["NAME"],1,112)) }
                                                                                                            else	{ if ( _dllchktv=="" )	_dllchktv=v
                                                                                                                                    else	if ( v!=_dllchktv )			return _dllerr(p,"different versions detected: " _dllchktv "!=" v "'")
                                                                                                                  ERRNO=""; if ( _th1(_[p]["DATA"]=_rdfile(f),ERRNO) )		{ delete _[p]["DATA"]; return _dllerr(p,"read lib: " ERRNO,f) }
                                                                                                                  if ( v!=(_[p]["VERSION"]=_getfilever(f)) )			return _dllerr(p,"library file version mismatch: ==`" _[p]["VERSION"] "'; !=`" v "'",f)
                                                                                                                  _creport(p,"OK:    LIBRARY DETECTED(" v "): " substr(f,1,100)) } }
                                                                                                      else	{ tf=1; _dllerr(p,"registry corrupt: `" i "' not present") } }
                                                                                                      else	_[p]["STATUS"]="MISSED" } }
#_____________________________________________________________________________________________________
######################################################################################################
























































func	_rdsafe(A,i,d)	{ if ( i in A )	return A[i]; return d }















      #_____________________________________________________________________________
      func	_var(v,t)	{ if ( isarray(v) )	return _dumparr(v) _ln(t)
                        if ( v==0 && v=="" )	return _ln("- (ERRNO=" ERRNO ")") _ln(t)
                                                return _ln(v "'") _ln(t) }
      #_____________________________________________________________________________
      func	_dumpval(v,n) {
            _dumpstr=_dumpstr (v=_ln((n==0 && n=="" ? "RET" : n) ": " (v==0 && v=="" ? "-" : v "'")))
            return v }


func	_torexp(r)	{ return _subseqon(_TOREXPB0,gensub(/(^[ \t]+)|(([ \t]*(\\)+)+[ \t]*)|([ \t]+$)/,"\\4","G",_subseqoff(r,_TOREXPB0)),_TOREXPFN) }


      #_______________________________________________
      func	_torexp_init()	{ _TOREXPFN[""]		="_strtorexp"
                                _TOREXPFN["~"]		="_torexp_rexp"
                                _TOREXPFN["="]		="_strtorexp"
                                _TOREXPFN[">"]		="_torexp_cmdstr"
                                _TOREXPFN["#"]		="_torexp_fmask"
                                _TOREXPFN["\""]		="_torexp_dqstr"
                                _TOREXPFN["'"]		="_torexp_sqstr"
                                }

func	_subseqoff(r,B)	{ patsplit(r,B,/\x84[^\x94]*\x94/); return gensub(/\x84[^\x94]*\x94/,"\x84","G",r) }

func	_subseqon(B,r,F, f,s,e,q,i,A) {
      q=split(r,A,/\x84/); r=""; f=F[""]
      for ( i=1; i<q; i++ )	{ s=substr(e=B[i],2,1)
                              #_conl("curr r==`" r "': A[" i "]=`" A[i] "'")
                              #s=s in F ? _th0(F[s],_conl("handler `" F[s] "' for `" s "' ost=`" substr(e,3,length(e)-3) "'")) : _th0(F[""],_conl("default handler for `" s "'"))
                              s=s in F ? F[s] : F[""]
                              #_conl("`" f "'")
                              r=r @f(A[i]) @s(substr(e,3,length(e)-3)) }
      return r @f(A[i]) }
      #_______________________________________________
      func	_torexp_rexp(t)	{ return t }
      #_______________________________________________
      func	_strtorexp(t)	{ gsub(/[\\\.\?\*\+\-\(\)\{\}\[\]\^\$\/\|]/,"\\\\&",t)
                              t=split(t,_TOREXP_STRA,/[\x00-\x1F]/,_TOREXP_STRB); _torexp_strt0=""
                              for ( _torexp_stri0=1; _torexp_stri0<t; _torexp_stri0++ )		_torexp_strt0=_torexp_strt0 _TOREXP_STRA[_torexp_stri0] "\\" _QASC[_TOREXP_STRB[_torexp_stri0]]
                              return _torexp_strt0 _TOREXP_STRA[_torexp_stri0] }

      func	_torexp_cmdstr(t)	{ return _strtorexp(gensub(/\^(.)/,"\\1","G",t)) }
      
      func	_torexp_fmask(t)	{ return gensub(/\\\*/,".*","G",gensub(/\\\?/,".?","G",_strtorexp(t))) }


func	_getfilever(f) { #############################################################
      split(_cmd(_fileverpath " \"" f "\""),_GETFILEVERA0,/[ \t]+/)
      if ( _GETFILEVERA0[5] )		return _GETFILEVERA0[5] }
      #_____________________________________________________
      BEGIN	{ _initfilever() }
            func	_initfilever()	{ _fileverpath		="\\\\CPU\\eGAWK\\LIB\\_filever\\_filever.exe" }

#_________________________________________________________________________________________
##########################################################################################




















func	_sharelist(D,h, q,c,l,A,B) { #################################################
      delete D; c=_sharextool " \\\\" (h=="" ? h=ENVIRON["COMPUTERNAME"] : h) " 2>&1"
      if ( match(c=_cmd(c),/\x0AShare[^\x0A]*Remark/) ) {
            gsub(/(^[^-]*\x0D?\x0A-+\x0D?\x0A[ \t]*)|(\x0D?\x0AThe command completed successfully.*$)/,"",c)
            l=RLENGTH-7; split(c,A,/([ \t]*\x0D?\x0A)+[ \t]*/)
            for ( c in A )			if ( match(A[c],/((([^ \t:]+[ \t]+)*[^ \t:]+)[ \t]+)([A-Za-z])[ \t]*:/,B) && ++q )				D[B[2]]=A[c]~/\.\.\.$/ ? _sharepath(h,B[2]) : gensub(/[ \t\\\/]*$/,"\\\\",1,substr(A[c],1+B[1,"length"],l-B[1,"length"]))
            return q }
      return _rmtsharerr(h,c) }
#_____________________________________________________________________________
func	_sharepath(h,s, A) { ###################################################
      s=_sharextool " \\\\" (h=="" ? h=ENVIRON["COMPUTERNAME"] : h) "\\\"" s "\" 2>&1"
      if ( match(s=_cmd(s),/\x0APath[ \t]+([^\x0D\x0A]+)/,_SHAREPATHA0) )	return gensub(/[ \t\\\/]*$/,"\\\\",1,_SHAREPATHA0[1])
      return _rmtsharerr(h,s) }
      #___________________________________________________________
      func	_rmtsharerr(h,t)	{ gsub(/[\x0D\x0A]+/,"",t)
                              if ( t~/^The command failed: 53/)	ERRNO="host not found: \\\\" h
                                                            else	ERRNO=t ": \\\\" h }
      #_____________________________________________________
      BEGIN	{ _initshare() }
            func	_initshare()	{ _sharextool		="\\\\CPU\\eGAWK\\LIB\\_share\\_share.exe" }
#_________________________________________________________________________________________
##########################################################################################








func	_extfn_init() { ##############################################################

      _formatstrs_init(); _formatstrd_init(); _formatrexp_init()

      _unformatstr_init()
      
      _mac_init()

}#__________________________________________________________________________________
####################################################################################




#___________________________________________________________________________________
func	_formatstrs(t) { _formatstrq0=split(t,_FORMATSTRA,/['\x00-\x1F\x80-\xFF]/,_FORMATSTRB); _formatstrs0=""
                    for ( t=1; t<_formatstrq0; t++ )		_formatstrs0=_formatstrs0 _FORMATSTRA[t] _FORMATSTRSESC[_FORMATSTRB[t]]
                    return _formatstrs0 _FORMATSTRA[t] }
      #___________________________________________________________
      func	_formatstrs_init() { _defescarr(_FORMATSTRSESC,"[\\x00-\\x1F\\x80-\\xFF]",_QASC)
                               _defescarr(_FORMATSTRSESC,"[\\\\']","\\")
                               _FORMATSTRSESC["\t"]="\\t" }
#_____________________________________________________________________________
func	_formatstrd(t) { _formatstrq0=split(t,_FORMATSTRA,/["\x00-\x1F\x80-\xFF]/,_FORMATSTRB); _formatstrs0=""
                     for ( t=1; t<_formatstrq0; t++ )		_formatstrs0=_formatstrs0 _FORMATSTRA[t] _FORMATSTRDESC[_FORMATSTRB[t]]
                     return _formatstrs0 _FORMATSTRA[t] }
      #___________________________________________________________
      func	_formatstrd_init() { _defescarr(_FORMATSTRDESC,"[\\x00-\\x1F\\x80-\\xFF]",_QASC)
                               _defescarr(_FORMATSTRDESC,"[\\\\\"]","\\")
                               _FORMATSTRDESC["\t"]="\\t" }
#_____________________________________________________________________________
func	_formatrexp(t) { _formatstrq0=split(t,_FORMATSTRA,/[\/\x00-\x1F\x80-\xFF]/,_FORMATSTRB); _formatstrs0=""
                     for ( t=1; t<_formatstrq0; t++ )		_formatstrs0=_formatstrs0 _FORMATSTRA[t] _FORMATREXPESC[_FORMATSTRB[t]]
                     return _formatstrs0 _FORMATSTRA[t] }
      #___________________________________________________________
      func	_formatrexp_init() { _defescarr(_FORMATREXPESC,"[\\x00-\\x1F\\x80-\\xFF]",_QASC)
                               _defescarr(_FORMATREXPESC,"\\/","\\")
                               _FORMATREXPESC["\t"]="\\t" }
#___________________________________________________________
func	_defescarr(D,r,S, i,c,t) { if ( isarray(S) )	{ for ( i=0; i<256; i++ )	{ if ( (c=_CHR[i])~r )	{ D[c]="\\" S[c]; t=t c }
                                                                                                      else	if ( D[c]=="" )	D[c]=c } }
                                                else	{ for ( i=0; i<256; i++ )	{ if ( (c=_CHR[i])~r )	{ D[c]=S c; if ( S!="" )	t=t c }
                                                                                                      else	if ( D[c]=="" )	D[c]=c } } return t }


#___________________________________________________________________________________
func	_unformatstr(t)	{ _formatstrq0=split(t,_FORMATSTRA,/(\\[0-9]{1,3})|(\\x[[:xdigit:]]+)|(\\.)/,_FORMATSTRB); _formatstrs0=""
                        for ( t=1; t<_formatstrq0; t++ )	_formatstrs0=_formatstrs0 _FORMATSTRA[t]											(_FORMATSTRB[t] in _QESCHR ?	_QESCHR[_FORMATSTRB[t]]															:	_QESCHR[toupper(substr(_FORMATSTRB[t],length(_FORMATSTRB[t])-1))])
                        return _formatstrs0 _FORMATSTRA[t] }
      #___________________________________________________________
      func	_unformatstr_init( i)	{ for ( i=0; i<256; i++ )	_QESCHR["\\" _CHR[i]]			=_CHR[i]
                                    for ( i=0; i<256; i++ ) {	_QESCHR[sprintf("%.2X",i)]		=_CHR[i]
                                                                  _QESCHR["\\" sprintf("%.3o",i)]	=_CHR[i]
                                                if ( i<8 )		_QESCHR["\\" sprintf("%.1o",i)]	=_CHR[i]
                                                if ( i<64 )		_QESCHR["\\" sprintf("%.2o",i)]	=_CHR[i]
                                                if ( i<16 )		_QESCHR["\\x" sprintf("%.1X",i)]=_QESCHR["\\x" sprintf("%.1x",i)]	=_CHR[i] }
                                    i="a" 7 "b" 8 "f" 12 "n" 10 "r" 13 "t" 9 "v" 11
                                    patsplit(i,_FORMATSTRA,/[^0-9]/,_FORMATSTRB)
                                    for ( i in _FORMATSTRA )	_QESCHR["\\" _FORMATSTRA[i]]=_CHR[_FORMATSTRB[i]+0] }



#___________________________________________________________________________________
func	_unformatrexp(t)	{ _formatstrq0=split(t,_FORMATSTRA,/(\\[0-9]{1,3})|(\\x[[:xdigit:]]+)|(\\.)/,_FORMATSTRB); _formatstrs0=""
                        for ( t=1; t<_formatstrq0; t++ )	_formatstrs0=_formatstrs0 _FORMATSTRA[t]											(_FORMATSTRB[t] in _QESCHR ?	_QESCREXP[_FORMATSTRB[t]]															:	_QESCREXP[toupper(substr(_FORMATSTRB[t],length(_FORMATSTRB[t])-1))])
                        return _formatstrs0 _FORMATSTRA[t] }
      #___________________________________________________________
      func	_unformatrexp_init( i,a) { _formatstrs0="\\^$.[]|()*+?{}-sSwW<>yB`'"; delete _FORMATSTRB
                                       for ( i=0; i<256; i++ )	_QESCREXP["\\" _CHR[i]]			=index(_formatstrs0,_CHR[i]) ? "\\" _CHR[i] : _CHR[i]
                                       for ( i=0; i<256; i++ )	{ a=index(_formatstrs0,_CHR[i]) ? "\\" : ""
                                                                  _QESCREXP[sprintf("%.2X",i)]		=a _CHR[i]
                                                                  _QESCREXP["\\" sprintf("%.3o",i)]	=a _CHR[i]
                                                                  if ( i<8 )	_QESCREXP["\\" sprintf("%.1o",i)]	=a _CHR[i]
                                                                  if ( i<64 )	_QESCREXP["\\" sprintf("%.2o",i)]	=a _CHR[i]
                                                                  if ( i<16 )	_QESCREXP["\\x" sprintf("%.1X",i)]=_QESCREXP["\\x" sprintf("%.1x",i)]=a _CHR[i] }
                                       patsplit("a" 7 "b" 8 "f" 12 "n" 10 "r" 13 "t" 9 "v" 11,_FORMATSTRA,/[^0-9]/,_FORMATSTRB)
                                       for ( i in _FORMATSTRA )	_QESCREXP["\\" _FORMATSTRA[i]]=_CHR[_FORMATSTRB[i]+0] }
#
#	/rexpstr/	->	datastr
#	(\x00\t\+)*	->	28 00 09 5B 2B 29
#
# unesc all non-rexp characters: replace unesc of rexp-characters but do not remove it: \* -> \*, \x2A -> \*, \052 -> \*, \\ -> \#


































func	_mpudefaulthnd(F,D,C,p1,p2,p3)	{ _mpuretsub(D,_mpucc0) }





func	_mpupfxsubret(F,D,C,p1,p2,p3) 	{ return 1 }

func	_mpusfxsubret(F,D,C,p1,p2,p3) 	{ return -1 }

func	_mpuretsub(D,t)	{ _mpuacc=D[_mpuptr++]; _accmpu(D,t); return 1 }


      func	_mac_init() {	_MACPFX["\x84"]			="_macpfx84"
                              _MACPFX[""]				="_mpupfxsubret"

                              
                              _MACPFX84SFX["\x84"]		="_macpfx84"
                              _MACPFX84SFX["\x94"]		="_macsfx94"
                              _MACPFX84SFX[""]			="_mpusfxsubret"


                              _VLDMAXSTRING	=1000000

                              }
      

func	_macpfx84(F,D,C,p1,p2,p3)	{ return _mpusub(_MACPFX84SFX,D,C,D[_mpuptr++],p1,p2,p3) }


      


func	_macsfx94(F,D,C,p1,p2,p3)	{ return _mpuretsub(D,_handle8494(_mpuacc)) }

func	_handle8494(t) {	return gensub(/(.)/,".\\1","G",t) }


func	_mpu(t,F,p1,p2,p3, D,C) {
      if ( patsplit(t,C,/[\x84\x93\x94]/,D)>0 )	{ _conline("CODE"); _conl(); _conl(_dumparr(C))
                                                _conline("DATA"); _conl(); _conl(_dumparr(D))
                                                
                                                _mpuptr=0; _mpucc0=""; _mpusub(F,D,C,D[_mpuptr++],p1,p2,p3)
                                                return _mpuacc }
      return t }

func	_mpusub(F,D,C,d,p1,p2,p3, q) {
      q=D[_ARRLEN]
      if ( _VLDMAXSTRING<length(d) )	{ D[--D[_ARRLEN]]=d; _mpuacc="" }
                                    else	_mpuacc=d
      d=_mpucc0
      _conl("_mpusub enter: in `" _mpuacc "' / _mpuptr=" _mpuptr "'")
      do { if ( (_mpucc0=C[_mpuptr]) in F )	{ if ( isarray(F[_mpucc0]) )	_mpufn0=F[_mpucc0]
                                                _conl("FN: `" _mpucc0 "' > CALL: `" (_mpufn0) "' : _mpuacc=" _mpuacc "'") }
                                          else	_mpufn0="_mpudefaulthnd" } while ( !_accmpu(D,_mpuacc,@_mpufn0(F,D,C,p1,p2,p3)) )
      if ( _mpufn0==-1 )	{ _conl("WARNING: unclosed expression: `" d _mpuacc"'")
                              _mpuacc=d _mpuacc }
      _retarrm(D,q,"",_mpufn0==-1 ? _th0(d,_mpusubwrng("WARNING: unclosed expression",d _mpuacc)) : "")
      # collect: _mpuacc=_retarr(D) _mpuacc
      _conl("mpusub exit: _mpuacc: `" _mpuacc "'") }






func	_accmpu(A,a,n) 	{ if ( n )		return _mpufn0=n
                        if ( _mpuacc )	{ if ( _VLDMAXSTRING<length(_mpuacc)+length(a) ) {
                                                            if ( a )	{ if ( _VLDMAXSTRING<length(_mpuacc) )	{ A[--A[_ARRLEN]]=a; A[--A[_ARRLEN]]=_mpuacc }
                                                                                                            else	A[--A[_ARRLEN]]=a _mpuacc }
                                                            else	A[--A[_ARRLEN]]=_mpuacc
                                                            _mpuacc="" }
                                                      else	_mpuacc=a _mpuacc }
                                    else	_mpuacc=a }




func	_acc(A,a,t) { if ( t )	{ if ( _VLDMAXSTRING<length(t)+length(a) ) {
                                    if ( a )	{ if ( _VLDMAXSTRING<length(t) )	{ A[--A[_ARRPTR]]=a; A[--A[_ARRPTR]]=t }
                                                                              else	A[--A[_ARRPTR]]=a t }
                                    else	A[++A[_ARRLEN]]=t
                                    return "" }
                              return a t }
                              return a }












































      
func	_shortcut(D,S) { #############################################################
      if ( isarray(D) )			{ if ( isarray(S) )										{ _addarrmask(D,S,_SHORTCUTWSTRUC) }				# array,array2*		- copy from array2 to array shorcut-specific elements
                                    else	if ( S==0 && S=="" )								{ _addarrmask(D,_SHORTCUTDEFAULT,_SHORTCUTWSTRUC) }		# array*			- define shortcut-specific elements in array by default values
                                    else	if ( _isnotfileptr(S) )								{ _addarrmask(D,_[S],_SHORTCUTWSTRUC) }				# array,ptr*		- copy from array _[ptr] to array shorcut-specific elements
                                    else	if ( _rd_shortcut(D,S) )								return }									# array,filepath*		- define in array shortcut-specific elements by reading its from shortcut file filepath(load shortcut)
      else	if ( D==0 && D=="" )													return _NOP									# -*				- no action(return -)
      else	if ( _isnotfileptr(D) )	{ if ( isarray(S) )										{ _addarrmask(_[D],S,_SHORTCUTWSTRUC) }				# ptr,array*		- copy from array to array _[ptr] shorcut-specific elements
                                    else	if ( S==0 && S=="" )								{ _addarrmask(_[D],_SHORTCUTDEFAULT,_SHORTCUTWSTRUC) }	# ptr*			- define shortcut-specifc elements in array _[ptr] by default values
                                    else	if ( _isnotfileptr(S) )								{ _addarrmask(_[D],_[S],_SHORTCUTWSTRUC) }			# ptr,ptr2*			- copy from array _[ptr2] to array _[ptr] shorcut-specific elements
                                    else	if ( _rd_shortcut(_[D],S) )							return }									# ptr,filepath*		- define in array _[ptr] shortcut-specific elements by reading its from shortcut file filepath(load shortcut)
                              else	{ if ( isarray(S) && _wr_shortcut(D,S) )						return										# filepath,array*		- [over]write shorcut file filepath; shortcut parameters will be defined by shortcut-specific elements in array(save shortcut)
                                    else	if ( S==0 && S=="" && _wr_shortcut(D,_SHORTCUTDEFAULT) )		return										# filepath*			- [over]write shorcut file filepath; shortcut parameters will be defined by default values
                                    else	if ( _isnotfileptr(S) && _wr_shortcut(D,_[S]) )				return										# filepath,ptr*		- [over]write shorcut file filepath; shortcut parameters will be defined by shortcut-specific elements in array _[ptr](save shortcut)
                                    else	if ( _rd_shortcut(_SHRTCUTA1,S) || _wr_shortcut(D,_SHRTCUTA1) )	return }									# filepath,filepath2*	- [over]write shorcut file filepath; shortcut parameters will be defined from shortcut file filepath2(copy shortcut)
      return 1 }
      #___________________________________________________________
      func	_wr_shortcut(f,S)	{ if ( (_shrtcutf0=_filepath(f)) ) {
                                    ERRNO=""; _shrtcuta0=_shortcut_fpath " /A:C /F:\"" _shrtcutf0 "\" 2>&1"
                                    for ( f in _SHORTCUTWSTRUC )	if ( f in S )		_shrtcuta0=_shrtcuta0 " " _SHORTCUTWSTRUC[f] "\"" gensub(/(\\?)$/,"\\1\\1",1,S[f]) "\""
                                    if ( _shortcut_nerr(_cmd(_shrtcuta0),_shrtcutf0) )	return }
                              return ERRNO ? ERRNO="write shortcut: " ERRNO : _NOP }
      #___________________________________________________________
      func	_rd_shortcut(D,f)	{ if ( (_shrtcutf0=_filepath(f)) && _shortcut_nerr(_shrtcuta0=_cmd(_shortcut_fpath " /A:Q /F:\"" _shrtcutf0 "\" 2>&1"),_shrtcutf0) ) {
                                    ERRNO=""; split(_shrtcuta0,_SHRTCUTA0,/\x0D?\x0A/)
                                    for ( _shrtcuta0 in _SHRTCUTA0 )							for ( f in _SHORTCUTRSTRUC )								if ( match(_SHRTCUTA0[_shrtcuta0],"^" f) )									D[_SHORTCUTRSTRUC[f]]=substr(_SHRTCUTA0[_shrtcuta0],1+RLENGTH) }
                              return ERRNO ? ERRNO="read shortcut: " ERRNO : _NOP }
            #_____________________________________________________
            func	_shortcut_nerr(t,s, A)	{ if ( match(t,/\x0ASystem error (-?[0-9]+)[^\x0D\x0A]*[\x0D\x0A]+([^\x0D\x0A]+)/,A) ) {
                                                ERRNO=(A[1] in _SHORTCUTERR ?	_SHORTCUTERR[A[1]]													: A[2] in _SHORTCUTERR ?	_SHORTCUTERR[A[2]]																	: tolower(gensub(/^(The )?(((.*)\.$)|(.*[^\.]$))/,"\\4\\5","G",A[2])) "(" A[1] ")")									(s ? ": `" s "'" : "") }
                                          else	return 1 }
      #________________________________________________
      func	_shortcut_init( A,B,q) {
                  _SHORTCUTERR[2]												="file not found"
                  _SHORTCUTERR[3]												="no such filepath"
                  _SHORTCUTERR["The system cannot find the file specified."]					="no such filepath"
                  _SHORTCUTERR[5]												="file is folder"
                  _SHORTCUTERR["Access is denied."]									="file is folder"
                  _SHORTCUTERR[123]												="filepath syntax error"
                  _SHORTCUTERR["The filename, directory name, or volume label syntax is incorrect."]	="filepath syntax error"
            q=	"target			/T:				TargetPath=					target?			;			_target							TargetPathExpanded=							;			parameters			/P:				Arguments=					paraneters?			;			_parameters							ArgumentsExpanded=							;			startdir			/W:				WorkingDirectory=				startdir?			;			_startdir							WorkingDirectoryExpanded=						;			runstyle			/R:				RunStyle=					1				;			icon,index			/I:				IconLocation=				icon,index?			;			xicon,index							IconLocationExpanded=							;			shortcut key		/H:				HotKey=					0				;			description			/D:				Description=				_env4: default shortcut	"
                  split(q,_SHRTCUTA0,/[ \t]*;[ \t]*/)
                  for ( q in _SHRTCUTA0 )	if ( match(_SHRTCUTA0[q],/^([^\t]+)\t+([^\t]+)(\t+([^\t]+)(\t+([^\t]+))?)?/,B) ) {
                                                if ( B[3]=="" )	_SHORTCUTRSTRUC[B[2]]=B[1]
                                                            else	if ( B[5]=="" )	{ _SHORTCUTWSTRUC[_SHORTCUTRSTRUC[B[4]]=B[1]]=B[2]; delete _SHORTCUTDEFAULT[B[1]] }
                                                                              else	{ _SHORTCUTWSTRUC[_SHORTCUTRSTRUC[B[4]]=B[1]]=B[2]; _SHORTCUTDEFAULT[B[1]]=B[6] } }
                                    else	_fatal("_shortcut.init: _shortcut_struc: syntax error: `" _SHRTCUTA0[q] "'")
                  _SHRTCUTA1[""]; delete _SHRTCUTA1[""]
                  _shortcut_fpath="\\\\localhost\\eGAWK\\LIB\\_shortcut\\_shortcut.exe" }
#_______________________________________________________________________
########################################################################































END{ ###############################################################################

      if ( _gawk_scriptlevel<1 ) {
            close(_errlog_file)
            p=_Zimport(_rdfile(_errlog_file),_N())
            if ( (t=_get_errout(p))!="" )	_expout(t,"/dev/stderr") } }
#___________________________________________________________________________________
####################################################################################

#_____________________________________________________________________________
func	_expout(t,d, a,b) { ####################################################
      a=BINMODE; b=ORS; BINMODE="rw"; ORS=""
      print t > (d ? d : (d=_errlog_file)); fflush(d)
      BINMODE=a; ORS=b }
#_______________________________________________________________________
func	_fatal(t,d, A) { #################################################
      if ( _ERRLOG_FF ) {
            A["TYPE"]="FATAL"; A["TEXT"]=t
            _log(A,d) }
      if ( !d )	exit }
#_______________________________________________________________________
func	_error(t,d, A) { #################################################
      if ( _ERRLOG_EF ) {
            A["TYPE"]="ERROR"; A["TEXT"]=t
            _log(A,d) } }
#_______________________________________________________________________
func	_warning(t,d, A) { ###############################################
      if ( _ERRLOG_WF ) {
            A["TYPE"]="WARNING"; A["TEXT"]=t
            _log(A,d) } }
#_______________________________________________________________________
func	_info(t,d, A) { ##################################################
      if ( _ERRLOG_IF ) {
            A["TYPE"]="INFO"; A["TEXT"]=t
            _log(A,d) } }
#_______________________________________________________________________
func	_verb(t,d, A) { ##################################################
      if ( _ERRLOG_VF ) {
            A["TYPE"]="VERB"; A["TEXT"]=t
            _log(A,d) } }
#_______________________________________________________________________
func	_trace(t,d, A) { #################################################
      if ( _ERRLOG_TF ) {
            A["TYPE"]="TRACE"; A["TEXT"]=t
            _log(A,d) } }
#_________________________________________________________________
func	_log(A,p, a,B) { ###########################################
      if ( isarray(A) ) {
            A["TIME"]=_getime(); A["DATE"]=_getdate()
            if ( p ) {
                  _tLOG[p=_wLCHLD(p,_N())][""]; delete _tLOG[p][""]
                  _movarr(_tLOG[p],A)
                  return p }
            _expout("_ERRLOG: " _Zexparr(A) "\x0A") }
      else {
            B["TEXT"]=A; B["TYPE"]=""
            return _log(B,p) } }
#_______________________________________________________________________
func	_yexport(p) { #####################################################
      return _tframe("_yexport_i0",p) }
#_______________________________________________________________________
func	_yexport_i0(p,p0,p1,p2) {
      if ( p in _tLOG )	return "_ERRLOG: " _Zexparr(_tLOG[p]) "\x0A"
      if ( p in _tSTR ) {
            p=_tSTR[p]; gsub(/\x1B/,"\x1B\x3B",p); gsub(/\x0A/,"\x1B\x3A",p)
            return p "\x0A" } }
#_____________________________________________________________________________
func	_Zimport(t,p,A, c,i,n,B) { ##############################################
      if ( p ) {
            c=split(t,B,/\x0A/)
            for ( i=1; i<=c; i++ ) {
                  if ( (t=B[i])=="" )	continue
                  gsub(/\x1B\x3A/,"\x0A",t)
                  if ( match(t,/^_ERRLOG: /) ) {
                        _tLOG[n=_wLCHLD(p,_N())][""]; delete _tLOG[n][""]
                        _Zimparr(_tLOG[n],substr(t,10)) }
                  else	if ( (t=_pass(_IMPORT,t,p,A))!="" ) {
                        gsub(/\x1B\x3B/,"\x1B",t); _wLCHLD(p,_N(_tSTR,t)) } }
            return p }
      else	_expout(t) }
#_____________________________________________________________________________
func	_export_data(t,i, A) { #################################################
      A["DATA"]=t; A["ID"]=i
      _expout("_DATA: " _Zexparr(A) "\x0A") }
#_________________________________________________________________
BEGIN { _inspass(_IMPORT,"_import_data") }

func	_import_data(t,p,p2, a) {
      if ( match(t,/^_DATA: /) ) {
            _tDATA[a=_wLCHLD(p,_N())][""]; delete _tDATA[a][""]
            _Zimparr(_tDATA[a],substr(t,8))
                                                _conl("DATA: `" _tDATA[a]["ID"] "':`" _tDATA[a]["DATA"] "'")
            return "" }
      return t }

#_____________________________________________________________________________
func	_get_errout(p) { #######################################################
      return _tframe("_get_errout_i0",p) }
#_______________________________________________________________________
func	_get_errout_i0(p, t,n,a) {
      return p in _tLOG ? (_get_errout_i1(p) _get_errout_i3(p)) : "" }
#_________________________________________________________________
func	_get_errout_i1(p, t,n,a) {
      if ( p in _tLOG ) {
            n=""
            if ( _tLOG[p]["TYPE"] ) {
                  n=_tLOG[p]["TYPE"] ": " _get_errout_i2(p)
                  if ( match(_tLOG[p]["TEXT"],/\x1F/) ) {
                        t=n; gsub(/[^\t]/," ",t)
                        return _ln(n substr(_tLOG[p]["TEXT"],1,RSTART-1)) _ln(t substr(_tLOG[p]["TEXT"],RSTART+1)) } }
                  return _ln(n _tLOG[p]["TEXT"]) } }
#_______________________________________________________________________
func	_get_errout_i2(p) {
      return "FILE" in _tLOG[p] ? (_tLOG[p]["FILE"] ("LINE" in _tLOG[p] ? ("(" _tLOG[p]["LINE"] ")") : "") ": ") : "" }
#_______________________________________________________________________
func	_get_errout_i3(p, t,ts,cl,cp,cr,a,b) {
      if ( "LSTR" in _tLOG[p] ) {
            t=_tLOG[p]["FULLSTR"]; ts=_tLOG[p]["TS"]; cp="^"
            if ( "CSTR" in _tLOG[p] ) {
                  cr=_tLOG[p]["CSTR"]
                  cl=_tLOG[p]["CLSTR"]
                  if ( "CPSTR" in _tLOG[p] )	cp=_tLOG[p]["CPSTR"] }
            cr=substr(cr,length(cl)+length(cp)+1)
            return _ln(_tabtospc(t,ts)) _ln(_getchrln(" ",a=length(_tabtospc(_tLOG[p]["LSTR"],ts))) _getchrln("-",b=length(_tabtospc(cl,ts,a))) _getchrln("^",b=length(_tabtospc(cp,ts,a=a+b))) _getchrln("-",length(_tabtospc(cr,ts,a+b)))) } }
#_____________________________________________________________________________
func	_get_logout(p) { #######################################################
      return _tframe("_get_logout_i0",p) }
#_______________________________________________________________________
func	_get_logout_i0(p, t,n,a) {
      if ( p in _tLOG ) {
            n=	("DATE" in _tLOG[p] ?	(_tLOG[p]["DATE"] " ") : "")			("TIME" in _tLOG[p] ?	(_tLOG[p]["TIME"] " ") : "")
            if ( _tLOG[p]["TYPE"] ) {
                  n=n	_tLOG[p]["TYPE"] ": "				("FILE" in _tLOG[p] ? (					_tLOG[p]["FILE"]					("LINE" in _tLOG[p] ?	("(" _tLOG[p]["LINE"] ")") : "")					": ") : "")
                  if ( match(_tLOG[p]["TEXT"],/\x1F/) ) {
                        t=n; gsub(/[^\t]/," ",t)
                        return _ln(n substr(_tLOG[p]["TEXT"],1,RSTART-1)) _ln(t substr(_tLOG[p]["TEXT"],RSTART+1)) } }
                  return _ln(n _tLOG[p]["TEXT"]) } }
#___________________________________________________________________________________


####################################################################################


#_____________________________________________________________________________
func	_N(F,v, p) { ###########################################################
      for ( p in _UIDS ) { delete _UIDS[p]; return _nN_i0(p,F,v) }
      return _nN_i0(_tgenuid(),F,v) }
#_______________________________________________________________________
func	_n(F,v, p) { #####################################################
      for ( p in _UIDSDEL )	{ delete _UIDSDEL[p]
                              delete _ptr[p]
                              delete _tPREV[p];	delete _tPARENT[p];		delete _tNEXT[p]
                              delete _tFCHLD[p];	delete _tQCHLD[p];		delete _tLCHLD[p]
                              delete _TMP0[p];	delete _TMP1[p]
                              delete _tLINK[p];	delete _tCLASS[p]
                              return _nN_i0(p,F,v) }
      for ( p in _UIDS )		{ delete _UIDS[p]; return _nN_i0(p,F,v) }
      return _nN_i0(_tgenuid(),F,v) }
#_____________________________________________________
func	_nN_i0(p,F,v) {
      _[p][""]; delete _[p][""]; _ptr[p][""]; delete _ptr[p][""]
      _TMP0[p][_ARRLEN]=_TMP1[p][_ARRLEN]=0
      if ( isarray(F) )			{ delete F[p]
                                          if ( isarray(v) )			{ F[p][""]; delete F[p][""]; _copyarr(F[p],v) }
                                          else	if ( !(v==0 && v=="") )		F[p]=v }
      else	{ if ( !(F==0 && F=="") )	{ if ( isarray(v) )			{ _[p][F][""]; delete _[p][F][""]; _copyarr(_[p][F],v) }
                                          else	if ( v==0 && v=="" )		_mpu(F,p)
                                                                        else	_[p][F]=v } }
      return p }
#_____________________________________________________
#	F	v	action
#-----------------------------------------------------
#	-	*	no additional action
#	A	B	delete A[p] and define A[p] as array; copy array B to array A[p]
#	A	-	delete A[p]
#	A	"*"	delete A[p]; A[p]="*"
#	"*"	B	define _[p]["*"] as array; copy array B to array _[p]["*"]
#	"*"	-	run _mpu program "*" for `p
#	"*0"	"*1"	_[p]["*0"]="*1"
#___________________________________________________________
func	_tgenuid( c)	{ for ( _uidcntr in _UIDARR1 ) { delete _UIDARR1[_uidcntr]; for ( c in _UIDARR0 )	_UIDS[_uidcntr c]; delete _UIDS[_uidcntr c]; return _uidcntr c }
                        return _fatal("_tUID: Out of UID range") }
#_____________________________________________________
func	_tgenuid_init( a,b,A) {
      _ptrlength		=4
      a=	"\x92\x93\x94\x95\x96\x97\x98\x99\x9A"							"\xA0\xA1\xA2\xA3\xA4\xA5\xA6\xA7"								"\xB0\xB1\xB2\xB3\xB4\xB5\xB6\xB7\xB8\xB9\xBA\xBB\xBC\xBD\xBE\xBF"		"\xC0\xC1\xC2\xC3\xC4\xC5\xC6\xC7\xC8\xC9\xCA\xCB\xCC\xCD\xCE\xCF"		"\xD0\xD1\xD2\xD3\xD4\xD5\xD6\xD7\xD8\xD9\xDA\xDB\xDC\xDD\xDE\xDF"
      split(a,A,""); for (a in A) for (b in A) _UIDARR0[A[a] A[b]] _UIDARR1[A[a] A[b]]; _uidcntr=A[a] A[b] }

#_____________________________________________________________________________
func	_tdel(p, i)	{ ##########################################################
      if ( p in _ ) {
            _texclude(p)
            for ( i in _ptr[p] )	{ if ( isarray(_ptr[p][i]) )	_tdel_i1(_ptr[p][i])
                                                            else	if ( (i=_ptr[p][i]) )	_tdel(i) }
            if ( p in _tFCHLD )	{ i=_tFCHLD[p]; do { i=(i in _tNEXT ? _tNEXT[i] : "") _tdel_i0(i) } while ( i ) }
            delete _[p]; _UIDSDEL[p] } }
#_____________________________________________________
func	_tdel_i0(p, i) {
      for ( i in _ptr[p] )	{ if ( isarray(_ptr[p][i]) )	_tdel_i1(_ptr[p][i])
                                                      else	if ( (i=_ptr[p][i]) )	_tdel(i) }
      if ( p in _tFCHLD )	{ i=_tFCHLD[p]; do { i=(i in _tNEXT ? _tNEXT[i] : "") _tdel_i0(i) } while ( i ) }
      delete _[p]; _UIDSDEL[p] }
#_____________________________________________________
func	_tdel_i1(A, i) {
      for ( i in A )		{ if ( isarray(A[i]) )		_tdel_i1(A[i])
                                                      else	if ( (i=A[i]) )	_tdel(i) } }
#_____________________________________________________________________________
func	_texclude(p, v,pp) { ###################################################				# TEST!!!
      if ( p in _ ) {
            if ( p in _tPARENT ) {
                  pp=_tPARENT[p]; delete _tPARENT[p]
                  if ( p in _tPREV ) {
                        if ( p in _tNEXT )	{ _tPREV[_tNEXT[v]=_tNEXT[p]]=v=_tPREV[p]; delete _tNEXT[p] }
                                          else	delete _tNEXT[_tLCHLD[pp]=_tPREV[p]]
                        delete _tPREV[p] }
                  else {
                        if ( p in _tNEXT )	{ delete _tPREV[_tFCHLD[pp]=_tNEXT[p]]; delete _tNEXT[p] }
                                          else	{ delete _tFCHLD[pp]; delete _tLCHLD[pp]; delete _tQCHLD[pp]; return p } }
                  --_tQCHLD[pp] }
            else {
                  if ( p in _tPREV ) {
                        if ( p in _tNEXT )	{ _tPREV[_tNEXT[v]=_tNEXT[p]]=v=_tPREV[p]; delete _tNEXT[p] }
                                          else	delete _tNEXT[_tPREV[p]]
                        delete _tPREV[p] }
                  else	if ( p in _tNEXT )	{ delete _tPREV[_tNEXT[p]]; delete _tNEXT[p] } }
            return p } }
#_______________________________________________________________________
func	_rFBRO(p) { ######################################################
      if ( p ) {
            if ( p in _tPARENT ) {
                  return _tFCHLD[_tPARENT[p]] }
            while ( p in _tPREV ) {
                  p=_tPREV[p] }
            return p }
      return p }
#_________________________________________________________________
func	_wFBRO(p,v ,a) { ###########################################
      if ( p ) {
            if ( v ) {
                  for ( a=p; a in _tPARENT; ) {
                        if ( (a=_tPARENT[a])==v ) {
                              return v } }			######################## v is parentesis of p
                  if ( p in _tPARENT ) {
                        p=_tPARENT[p]
                        if ( v in _tNEXT ) {
                              if ( v in _tPREV ) {
                                    _tPREV[_tNEXT[a]=_tNEXT[v]]=a=_tPREV[v]; delete _tPREV[v]
                                    if ( v in _tPARENT ) {
                                          if ( p==(a=_tPARENT[v]) ) {
                                                return _tFCHLD[p]=_tPREV[_tNEXT[v]=_tFCHLD[p]]=v }
                                          --_tQCHLD[a] } }
                              else {
                                    if ( v in _tPARENT ) {
                                          if ( p==(a=_tPARENT[v]) ) { return v }
                                          delete _tPREV[_tFCHLD[a]=_tNEXT[v]]; --_tQCHLD[a] }
                                    else {
                                          delete _tPREV[_tNEXT[v]] } }
                              ++_tQCHLD[p]; return _tFCHLD[p]=_tPREV[_tNEXT[v]=_tFCHLD[_tPARENT[v]=p]]=v }
                        else {
                              if ( v in _tPREV ) {
                                    if ( v in _tPARENT ) {
                                          delete _tNEXT[_tLCHLD[a=_tPARENT[v]]=_tPREV[v]]
                                          if ( p==a ) {
                                                delete _tPREV[v]
                                                return _tFCHLD[p]=_tPREV[_tNEXT[v]=_tFCHLD[p]]=v }
                                          --_tQCHLD[a] }
                                    else {
                                          delete _tNEXT[_tPREV[v]] }
                                    delete _tPREV[v] }
                              else {
                                    if ( v in _tPARENT ) {
                                          if ( p==(a=_tPARENT[v]) ) { return v }
                                          delete _tFCHLD[a]; delete _tLCHLD[a]; delete _tQCHLD[a] } }
                              ++_tQCHLD[p]; return _tFCHLD[p]=_tPREV[_tNEXT[v]=_tFCHLD[_tPARENT[v]=p]]=v } }
                  else {
                        while ( p in _tPREV ) {
                              p=_tPREV[p] }
                        if ( v in _tPREV ) {
                              if ( v in _tPARENT ) {
                                    --_tQCHLD[a=_tPARENT[v]]; delete _tPARENT[v]
                                    if ( v in _tNEXT ) {
                                          _tNEXT[_tPREV[a]=_tPREV[v]]=a=_tNEXT[v] }
                                    else {
                                          delete _tNEXT[_tLCHLD[a]=_tPREV[v]] } }
                              else {
                                    if ( v in _tNEXT ) {
                                          _tNEXT[_tPREV[a]=_tPREV[v]]=a=_tNEXT[v] }
                                    else {
                                          delete _tNEXT[_tPREV[v]] } }
                              delete _tPREV[v] }
                        else {
                              if ( p==v ) { return v }
                              if ( v in _tPARENT ) {
                                    if ( v in _tNEXT ) {
                                          delete _tPREV[_tFCHLD[a=_tPARENT[v]]=_tNEXT[v]]; --_tQCHLD[a] }
                                    else {
                                          delete _tLCHLD[a=_tPARENT[v]]; delete _tFCHLD[a]; delete _tQCHLD[a] }
                                    delete _tPARENT[v] }
                              else {
                                    if ( v in _tNEXT ) {
                                          delete _tPREV[_tNEXT[v]] } } }
                        return _tPREV[_tNEXT[v]=p]=v } }
            else {
                  if ( v==0 ) {
                        return v }					######################## p=ptr, v=0
                  return v } }					######################## p=ptr, v=""
      else {
            if ( p==0 )		return v				######################## p=0
            if ( v )		return _texclude(v)		######################## p="", v=ptr	- exclude v
            return v } }						######################## p=""
#_______________________________________________________________________
func	_rPREV(p) { ######################################################
      if ( (p) && (p in _tPREV) ) {
            return _tPREV[p] }
      return "" }
#_________________________________________________________________
func	_wPREV(p,v, a,b) { #########################################
      if ( p ) {
            if ( v ) {
                  if ( p==v ) { return v }			######################## p=v=ptr
                  for ( a=p; a in _tPARENT; ) {
                        if ( (a=_tPARENT[a])==v ) {
                              return v } }			######################## v is parentesis of p
                  if ( v in _tNEXT ) {
                        if ( p==(a=_tNEXT[v]) ) { return v }
                        if ( v in _tPREV ) {
                              _tNEXT[_tPREV[a]=_tPREV[v]]=a
                              if ( v in _tPARENT ) {
                                    --_tQCHLD[_tPARENT[v]] } }
                        else {
                              delete _tPREV[a]
                              if ( v in _tPARENT ) {
                                    _tFCHLD[b=_tPARENT[v]]=a
                                    --_tQCHLD[b] } } }
                  else {
                        if ( v in _tPREV ) {
                              if ( v in _tPARENT ) {
                                    delete _tNEXT[_tLCHLD[a=_tPARENT[v]]=_tPREV[v]]
                                    --_tQCHLD[a] }
                              else {
                                    delete _tNEXT[_tPREV[v]] } }
                        else {
                              if ( v in _tPARENT ) {
                                    delete _tLCHLD[a=_tPARENT[v]]; delete _tFCHLD[a]; delete _tQCHLD[a] } } }
                  if ( p in _tPREV ) {
                        _tNEXT[_tPREV[v]=_tPREV[p]]=v
                        if ( p in _tPARENT ) {
                              ++_tQCHLD[_tPARENT[v]=_tPARENT[p]] }
                        else {
                              delete _tPARENT[v] } }
                  else {
                        delete _tPREV[v]
                        if ( p in _tPARENT ) {
                              ++_tQCHLD[_tPARENT[_tFCHLD[a]=v]=a=_tPARENT[p]] }
                        else {
                              delete _tPARENT[v] } }
                  return _tPREV[_tNEXT[v]=p]=v }
            else {
                  if ( v==0 ) {
                        return v }					######################## p=ptr, v=0
                  return v } }					######################## p=ptr, v=""
      else {
            if ( p==0 )		return v				######################## p=0
            if ( v )		return _texclude(v)		######################## p="", v=ptr	- exclude v
            return v } }						######################## p=""
#_______________________________________________________________________
func	_rPARENT(p) { ####################################################
      if ( (p) && (p in _tPARENT) ) {
            return _tPARENT[p] }
      return "" }
#_________________________________________________________________
func	_wPARENT(p,v) { ############################################
      return v }
#_______________________________________________________________________
func	_rFCHLD(p) { #####################################################
      if ( (p) && (p in _tFCHLD) ) {
            return _tFCHLD[p] }
      return "" }
#_________________________________________________________________
func	_wFCHLD(p,v, a) { ##########################################
      if ( p ) {
            if ( v ) {
                  if ( p==v ) { return v }			######################## p=v=ptr
                  for ( a=p; a in _tPARENT; ) {
                        if ( (a=_tPARENT[a])==v ) {
                              return v } }			######################## v is parentesis of p
                  if ( v in _tNEXT ) {
                        if ( v in _tPREV ) {
                              _tPREV[_tNEXT[a]=_tNEXT[v]]=a=_tPREV[v]; delete _tPREV[v]
                              if ( v in _tPARENT ) {
                                    if ( p==(a=_tPARENT[v]) ) {
                                          return _tFCHLD[p]=_tPREV[_tNEXT[v]=_tFCHLD[p]]=v }
                                    --_tQCHLD[a] } }
                        else {
                              if ( v in _tPARENT ) {
                                    if ( p==(a=_tPARENT[v]) ) { return v }
                                    delete _tPREV[_tFCHLD[a]=_tNEXT[v]]; --_tQCHLD[a] }
                              else {
                                    delete _tPREV[_tNEXT[v]] } }
                        if ( p in _tFCHLD ) {
                              ++_tQCHLD[p]; return _tFCHLD[p]=_tPREV[_tNEXT[v]=_tFCHLD[_tPARENT[v]=p]]=v }
                        delete _tNEXT[v] }
                  else {
                        if ( v in _tPREV ) {
                              if ( v in _tPARENT ) {
                                    delete _tNEXT[_tLCHLD[a=_tPARENT[v]]=_tPREV[v]]
                                    if ( p==a ) {
                                          delete _tPREV[v]
                                          return _tFCHLD[p]=_tPREV[_tNEXT[v]=_tFCHLD[p]]=v }
                                    --_tQCHLD[a] }
                              else {
                                    delete _tNEXT[_tPREV[v]] }
                              delete _tPREV[v] }
                        else {
                              if ( v in _tPARENT ) {
                                    if ( p==(a=_tPARENT[v]) ) { return v }
                                    delete _tFCHLD[a]; delete _tLCHLD[a]; delete _tQCHLD[a] } }
                        if ( p in _tFCHLD ) {
                              ++_tQCHLD[p]; return _tFCHLD[p]=_tPREV[_tNEXT[v]=_tFCHLD[_tPARENT[v]=p]]=v } }
                  _tQCHLD[p]=1; return _tFCHLD[_tPARENT[v]=p]=_tLCHLD[p]=v }
            else {
                  if ( v==0 ) {
                        if ( p in _tFCHLD ) {			######################## p=ptr, v=0 > delete all chld
                              v=_tFCHLD[p]
                              delete _tFCHLD[p]; delete _tLCHLD[p]; delete _tQCHLD[p]
                              do{
                                    delete _tPARENT[v] } while ( (v in _tNEXT) && (v=_tNEXT[v]) ) } }
                  return v } }					######################## p=ptr, v="" > ignore action
      else {
            if ( p==0 )		return v				######################## p=0
            return v } }						######################## p=""
#_______________________________________________________________________
func	_rLCHLD(p) { #####################################################
      if ( (p) && (p in _tLCHLD) ) {
            return _tLCHLD[p] }
      return "" }
#_________________________________________________________________
func	_wLCHLD(p,v, a) { ##########################################
      if ( p ) {
            if ( v ) {
                  if ( p==v ) { return v }			######################## p=v=ptr
                  for ( a=p; a in _tPARENT; ) {
                        if ( (a=_tPARENT[a])==v ) {
                              return v } }			######################## v is parentesis of p
                  if ( v in _tPREV ) {
                        if ( v in _tNEXT ) {
                              _tNEXT[_tPREV[a]=_tPREV[v]]=a=_tNEXT[v]; delete _tNEXT[v]
                              if ( v in _tPARENT ) {
                                    if ( p==(a=_tPARENT[v]) ) {
                                          return _tLCHLD[p]=_tNEXT[_tPREV[v]=_tLCHLD[p]]=v }
                                    --_tQCHLD[a] } }
                        else {
                              if ( v in _tPARENT ) {
                                    if ( p==(a=_tPARENT[v]) ) { return v }
                                    delete _tNEXT[_tLCHLD[a]=_tPREV[v]]; --_tQCHLD[a] }
                              else {
                                    delete _tNEXT[_tPREV[v]] } }
                        if ( p in _tLCHLD ) {
                              ++_tQCHLD[p]; return _tLCHLD[p]=_tNEXT[_tPREV[v]=_tLCHLD[_tPARENT[v]=p]]=v }
                        delete _tPREV[v] }
                  else {
                        if ( v in _tNEXT ) {
                              if ( v in _tPARENT ) {
                                    delete _tPREV[_tFCHLD[a=_tPARENT[v]]=_tNEXT[v]]
                                    if ( p==a ) {
                                          delete _tNEXT[v]
                                          return _tLCHLD[p]=_tNEXT[_tPREV[v]=_tLCHLD[p]]=v }
                                    --_tQCHLD[a] }
                              else {
                                    delete _tPREV[_tNEXT[v]] }
                              delete _tNEXT[v] }
                        else {
                              if ( v in _tPARENT ) {
                                    if ( p==(a=_tPARENT[v]) ) { return v }
                                    delete _tLCHLD[a]; delete _tFCHLD[a]; delete _tQCHLD[a] } }
                        if ( p in _tLCHLD ) {
                              ++_tQCHLD[p]; return _tLCHLD[p]=_tNEXT[_tPREV[v]=_tLCHLD[_tPARENT[v]=p]]=v } }
                  _tQCHLD[p]=1; return _tLCHLD[_tPARENT[v]=p]=_tFCHLD[p]=v }
            else {
                  if ( v==0 ) {
                        if ( p in _tFCHLD ) {				######################## p=ptr, v=0 > delete all chld
                              v=_tFCHLD[p]
                              delete _tFCHLD[p]; delete _tLCHLD[p]; delete _tQCHLD[p]
                              do{
                                    delete _tPARENT[v] } while ( (v in _tNEXT) && (v=_tNEXT[v]) ) } }
                  return v } }						######################## p=ptr, v="" > ignore action
      else {
            if ( p==0 )		return v				######################## p=0
            return v } }						######################## p=""
#_______________________________________________________________________
func	_rQCHLD(p) { #####################################################
      if ( (p) && (p in _tQCHLD) ) {
            return _tQCHLD[p] }
      return "" }
#_________________________________________________________________
func	_wQCHLD(p,v) { #############################################
      if ( p ) {
            if ( v ) { }						######################## p=ptr, v=ptr
            else {
                  if ( v==0 ) {
                        if ( p in _tFCHLD ) {			######################## p=ptr, v=0 > delete all chld
                              v=_tFCHLD[p]
                              delete _tFCHLD[p]; delete _tLCHLD[p]; delete _tQCHLD[p]
                              do{
                                    delete _tPARENT[v] } while ( (v in _tNEXT) && (v=_tNEXT[v]) ) } }
                  return v } }					######################## p=ptr, v="" > ignore action
      else {
            if ( p==0 ) {
                  return v }						######################## p=0
            return v } }						######################## p=""
#_______________________________________________________________________
func	_rNEXT(p) { ######################################################
      if ( (p) && (p in _tNEXT) ) {
            return _tNEXT[p] }
      return "" }
#_________________________________________________________________
func	_wNEXT(p,v, a,b) { #########################################
      if ( p ) {
            if ( v ) {
                  if ( p==v ) { return v }			######################## p=v=ptr
                  for ( a=p; a in _tPARENT; ) {
                        if ( (a=_tPARENT[a])==v ) {
                              return v } }			######################## v is parentesis of p
                  if ( v in _tPREV ) {
                        if ( p==(a=_tPREV[v]) ) { return v }
                        if ( v in _tNEXT ) {
                              _tPREV[_tNEXT[a]=_tNEXT[v]]=a
                              if ( v in _tPARENT ) {
                                    --_tQCHLD[_tPARENT[v]] } }
                        else {
                              delete _tNEXT[a]
                              if ( v in _tPARENT ) {
                                    _tLCHLD[b=_tPARENT[v]]=a
                                    --_tQCHLD[b] } } }
                  else {
                        if ( v in _tNEXT ) {
                              if ( v in _tPARENT ) {
                                    delete _tPREV[_tFCHLD[a=_tPARENT[v]]=_tNEXT[v]]
                                    --_tQCHLD[a] }
                              else {
                                    delete _tPREV[_tNEXT[v]] } }
                        else {
                              if ( v in _tPARENT ) {
                                    delete _tFCHLD[a=_tPARENT[v]]; delete _tLCHLD[a]; delete _tQCHLD[a] } } }
                  if ( p in _tNEXT ) {
                        _tPREV[_tNEXT[v]=_tNEXT[p]]=v
                        if ( p in _tPARENT ) {
                              ++_tQCHLD[_tPARENT[v]=_tPARENT[p]] }
                        else {
                              delete _tPARENT[v] } }
                  else {
                        delete _tNEXT[v]
                        if ( p in _tPARENT ) {
                              ++_tQCHLD[_tPARENT[_tLCHLD[a]=v]=a=_tPARENT[p]] }
                        else {
                              delete _tPARENT[v] } }
                  return _tNEXT[_tPREV[v]=p]=v }
            else {
                  if ( v==0 ) {
                        return v }					######################## p=ptr, v=0
                  return v } }					######################## p=ptr, v=""
      else {
            if ( p==0 )		return v				######################## p=0
            if ( v )		return _texclude(v)		######################## p="", v=ptr	- exclude v
            return v } }						######################## p="", !v
#_______________________________________________________________________
func	_rLBRO(p) { ######################################################
      if ( p ) {
            if ( p in _tPARENT ) {
                  return _tLCHLD[_tPARENT[p]] }
            while ( p in _tNEXT ) {
                  p=_tNEXT[p] }
            return p }
      return p }
#_________________________________________________________________
func	_wLBRO(p,v ,a) { ###########################################
      if ( p ) {
            if ( v ) {
                  for ( a=p; a in _tPARENT; ) {
                        if ( (a=_tPARENT[a])==v ) {
                              return v } }			######################## v is parentesis of p
                  if ( p in _tPARENT ) {
                        p=_tPARENT[p]
                        if ( v in _tPREV ) {
                              if ( v in _tNEXT ) {
                                    _tNEXT[_tPREV[a]=_tPREV[v]]=a=_tNEXT[v]; delete _tNEXT[v]
                                    if ( v in _tPARENT ) {
                                          if ( p==(a=_tPARENT[v]) ) {
                                                return _tLCHLD[p]=_tNEXT[_tPREV[v]=_tLCHLD[p]]=v }
                                          --_tQCHLD[a] } }
                              else {
                                    if ( v in _tPARENT ) {
                                          if ( p==(a=_tPARENT[v]) ) { return v }
                                          delete _tNEXT[_tLCHLD[a]=_tPREV[v]]; --_tQCHLD[a] }
                                    else {
                                          delete _tNEXT[_tPREV[v]] } }
                              ++_tQCHLD[p]; return _tLCHLD[p]=_tNEXT[_tPREV[v]=_tLCHLD[_tPARENT[v]=p]]=v }
                        else {
                              if ( v in _tNEXT ) {
                                    if ( v in _tPARENT ) {
                                          delete _tPREV[_tFCHLD[a=_tPARENT[v]]=_tNEXT[v]]
                                          if ( p==a ) {
                                                delete _tNEXT[v]
                                                return _tLCHLD[p]=_tNEXT[_tPREV[v]=_tLCHLD[p]]=v }
                                          --_tQCHLD[a] }
                                    else {
                                          delete _tPREV[_tNEXT[v]] }
                                    delete _tNEXT[v] }
                              else {
                                    if ( v in _tPARENT ) {
                                          if ( p==(a=_tPARENT[v]) ) { return v }
                                          delete _tLCHLD[a]; delete _tFCHLD[a]; delete _tQCHLD[a] } }
                              ++_tQCHLD[p]; return _tLCHLD[p]=_tNEXT[_tPREV[v]=_tLCHLD[_tPARENT[v]=p]]=v } }
                  else {
                        while ( p in _tNEXT ) {
                              p=_tNEXT[p] }
                        if ( v in _tNEXT ) {
                              if ( v in _tPARENT ) {
                                    --_tQCHLD[a=_tPARENT[v]]; delete _tPARENT[v]
                                    if ( v in _tPREV ) {
                                          _tPREV[_tNEXT[a]=_tNEXT[v]]=a=_tPREV[v] }
                                    else {
                                          delete _tPREV[_tFCHLD[a]=_tNEXT[v]] } }
                              else {
                                    if ( v in _tPREV ) {
                                          _tPREV[_tNEXT[a]=_tNEXT[v]]=a=_tPREV[v] }
                                    else {
                                          delete _tPREV[_tNEXT[v]] } }
                              delete _tNEXT[v] }
                        else {
                              if ( p==v ) { return v }
                              if ( v in _tPARENT ) {
                                    if ( v in _tPREV ) {
                                          delete _tNEXT[_tLCHLD[a=_tPARENT[v]]=_tPREV[v]]; --_tQCHLD[a] }
                                    else {
                                          delete _tFCHLD[a=_tPARENT[v]]; delete _tLCHLD[a]; delete _tQCHLD[a] }
                                    delete _tPARENT[v] }
                              else {
                                    if ( v in _tPREV ) {
                                          delete _tNEXT[_tPREV[v]] } } }
                        return _tNEXT[_tPREV[v]=p]=v } }
            else {
                  if ( v==0 ) {
                        return v }					######################## p=ptr, v=0
                  return v } }					######################## p=ptr, v=""
      else {
            if ( p==0 )		return v				######################## p=0
            if ( v )		return _texclude(v)		######################## p="", v=ptr	- exclude v
            return v } }						######################## p=""
#_______________________________________________________________________
func	_rQBRO(p, c,p1) { ################################################
      if ( p ) {
            if ( p in _tPARENT ) {
                  return _tQCHLD[_tPARENT[p]] }
            c=1; p1=p
            while ( p1 in _tPREV ) {
                  c++; p1=_tPREV[p1] }
            while ( p in _tNEXT ) {
                  c++; p=_tNEXT[p] }
            return c }
      return p }
#_________________________________________________________________
func	_wQBRO(p,v) { ##############################################
      return v }
#_______________________________________________________________________
func	_rLINK(p) { ######################################################
      return p in _tLINK ? _tLINK[p] : "" }
#_________________________________________________________________
func	_wLINK(p,v) { ##############################################
      return _tLINK[p]=v }
#_____________________________________________________________________________
func	_tpush(p,aA, a) { ######################################################
      if ( isarray(aA) ) {
            delete _tSTACK[p][a=++_tSTACK[p][0]]; _tSTACK[p][a][""]; delete _tSTACK[p][a][""]
            _movarr(_tSTACK[p][a],aA); return }
      delete _tSTACK[p][a=++_tSTACK[p][0]]; return _tSTACK[p][a]=aA }
#_________________________________________________________________
func	_tpop(p,aA, a) { ###########################################
      if ( (a=_tSTACK[p][0])>0 ) {
            _tSTACK[p][0]--
            if ( isarray(_tSTACK[p][a]) ) {
                  delete aA; _movarr(aA,_tSTACK[p][a]); return }
            return _tSTACK[p][a] }
      _fatal("^" p ": Out of tSTACK") }
#_________________________________________________________________
func	_tsetsp(p,v) { #############################################
      return _tSTACK[p][0]=v }
#_________________________________________________________________
func	_tgetsp(p) { ###############################################
      return _tSTACK[p][0] }
#_______________________________________________________________________
########################################################################


func	_W(p,A,v) {
      if ( isarray(v) ) {
            if ( p ) {
                  delete A[p]; A[p][""]; delete A[p][""]
                  _movarr(A[p],v) }
            return p }
      if ( p ) {
            delete A[p]; return A[p]=v }
      return v }



# _tDLINK progressive development: concrete _tDLINK function\processing algo; all frame's families support
#_____________________________________________________________________________
func	_tframe(fF,p,p0,p1,p2) { ###############################################
      delete _t_ENDF[++_t_ENDF[0]]
      p=_isptr(p) ? isarray(fF) ? _tframe_i1(fF,p,p0,p1,p2) : _tframe_i0(fF,p,p0,p1,p2) : ""
      --_t_ENDF[0]
      return p }
#___________________________________________________________
func	_tframe_i0(f,p,p0,p1,p2, a) {
      while ( p in _tLINK )	p=_tLINK[p]
      return p in _tFCHLD ?	_tmframe_i0(f,_tFCHLD[p],p0,p1,p2) :					(p in _tDLINK ? @f(_tDLINK[p],p0,p1,p2) : @f(p,p0,p1,p2)) }
#___________________________________________________________
func	_tframe_i1(F,p,p0,p1,p2, a) {
      while ( p in _tLINK )	p=_tLINK[p]
      return p in _tFCHLD ?	("." in F ? _th1(a=F["."],@a(p,p0,p1,p2)) : "") _tmframe_i1(F,_tFCHLD[p],p0,p1,p2)				:	(">" in F ? _th1(a=F[">"],p in _tDLINK ? @a(_tDLINK[p],p0,p1,p2) : @a(p,p0,p1,p2)) : "") }
#_________________________________________________________________
func	_tmframe(f,p,p0,p1,p2) { ###################################
      delete _t_ENDF[++_t_ENDF[0]]
      f=p ? _tmframe_i0(f,p,p0,p1,p2) : ""
      --_t_ENDF[0]
      return f }
#___________________________________________________________
func	_tmframe_i0(f,p,p0,p1,p2, t) {
      while ( (p) && (!(_t_ENDF[0] in _t_ENDF)) ) {
            t=t _tframe_i0(f,p,p0,p1,p2, p=p in _tNEXT ? _tNEXT[p] : "") }
      return t }
#___________________________________________________________
func	_tmframe_i1(F,p,p0,p1,p2, t) {
      while ( (p) && (!(_t_ENDF[0] in _t_ENDF)) ) {
            t=t _tframe_i1(F,p,p0,p1,p2, p=p in _tNEXT ? _tNEXT[p] : "") }
      return t }
#_________________________________________________________________
func	_trunframe(f,p,p0,p1,p2) { #################################
      return _tframe(f ? f : "_trunframe_i0",p,p0,p1,p2) }
#_________________________________________________________________
func	_trunframe_i0(p,p0,p1,p2, f) {
      if ( p in _tFN ) {
            f=_tFN[p]
            return @f(p,p0,p1,p2) } }
#_____________________________________________________________________________
func	_tbframe(f,p,p0,p1) { ##################################################
      delete _t_ENDF[++_t_ENDF[0]]
      f=p ? _tbframe_i0(f,p,p0,p1) : ""
      --_t_ENDF[0]
      return f }
#___________________________________________________________
func	_tbframe_i0(f,p,p0,p1, a) {
      while ( p in _tLINK )	p=_tLINK[p]
      return p in _tLCHLD ? _tmbframe(f,_tLCHLD[p],p0,p1) : @f(p,p0,p1) }
#_________________________________________________________________
func	_tmbframe(f,p,p0,p1, t) { ##################################
      while ( (p) && (!(_t_ENDF[0] in _t_ENDF)) ) {
            t=t _tbframe_i0(f,p,p0,p1, p=p in _tPREV ? _tPREV[p] : "") }
      return t }
#_________________________________________________________________
func	_tbrunframe(f,p,p0,p1) { ###################################
      return _tbframe(f ? f : "_trunframe_i0",p,p0,p1) }
#_______________________________________________________________________
func	_tframex(f,p,p0,p1) { ############################################
      delete _t_ENDF[++_t_ENDF[0]]
      f=p ? _tframex_i0(f,p,p0,p1) : ""
      --_t_ENDF[0]
      return f }
#___________________________________________________________
func	_tframex_i0(f,p,p0,p1) {
      while ( p in _tLINK ) p=_tLINK[p]
      return p in _tFCHLD ? _tmframex(f,_tFCHLD[p],p0,p1) : @f(p,p0,p1) }
#_________________________________________________________________
func	_tmframex(f,p,p0,p1, t) { ##################################
      while ( (p) && (!(_t_ENDF[0] in _t_ENDF)) ) {
            t=t _tframex_i0(f,p,p0,p1); p=p in _tNEXT ? _tNEXT[p] : "" }
      return t }
#_________________________________________________________________
func	_trunframex(f,p,p0,p1) { ###################################
      return _tframex(f ? f : "_trunframe_i0",p,p0,p1) }
#_______________________________________________________________________
func	_tbframex(f,p,p0,p1) { ###########################################
      delete _t_ENDF[++_t_ENDF[0]]
      f=p ? _tbframex_i0(f,p,p0,p1) : ""
      --_t_ENDF[0]
      return f }
#___________________________________________________________
func	_tbframex_i0(f,p,p0,p1) {
      while ( p in _tLINK ) p=_tLINK[p]
      return p in _tLCHLD ? _tmbframex(f,_tLCHLD[p],p0,p1) : @f(p,p0,p1) }
#_________________________________________________________________
func	_tmbframex(f,p,p0,p1, t) { #################################
      while ( (p) && (!(_t_ENDF[0] in _t_ENDF)) ) {
            t=t _tbframex_i0(f,p,p0,p1); p=p in _tPREV ? _tPREV[p] : "" }
      return t }
#_________________________________________________________________
func	_tbrunframex(f,p,p0,p1) { ##################################
      return _tbframex(f ? f : "_trunframe_i0",p,p0,p1) }
#_____________________________________________________________________________
func	_tpass(f,p,p0,p1) { ####################################################
      delete _t_ENDF[++_t_ENDF[0]]
      f=p ? _tpass_i0(f,p,p0,p1) : ""
      --_t_ENDF[0]
      return f }
#___________________________________________________________
func	_tpass_i0(f,p,p0,p1, a) {
      while ( p in _tLINK ) p=_tLINK[p]
      return p in _tFCHLD ? _tmpass(f,_tFCHLD[p],p0,p1) : @f(p,p0,p1) }
#_________________________________________________________________
func	_tmpass(f,p,p0,p1) { #######################################
      while ( (p) && (!(_t_ENDF[0] in _t_ENDF)) ) {
            p0=_tbpass_i0(f,p,p0,p1, p=p in _tNEXT ? _tNEXT[p] : "") }
      return p0 }
#_________________________________________________________________
func	_trunpass(f,p,p0,p1) { #####################################
      return _tpass(f ? f : "_trunframe_i0",p,p0,p1) }
#_____________________________________________________________________________
func	_tpassx(f,p,p0,p1) { ###################################################
      delete _t_ENDF[++_t_ENDF[0]]
      f=p ? _tpassx_i0(f,p,p0,p1) : ""
      --_t_ENDF[0]
      return f }
#___________________________________________________________
func	_tpassx_i0(f,p,p0,p1) {
      while ( p in _tLINK ) p=_tLINK[p]
      return p in _tFCHLD ? _tmpassx(f,_tFCHLD[p],p0,p1) : @f(p,p0,p1) }
#_________________________________________________________________
func	_tmpassx(f,p,p0,p1) { ######################################
      while ( (p) && (!(_t_ENDF[0] in _t_ENDF)) ) {
            p0=_tbpassx_i0(f,p,p0,p1); p=p in _tNEXT ? _tNEXT[p] : "" }
      return p0 }
#_________________________________________________________________
func	_trunpassx(f,p,p0,p1) { ####################################
      return _tpassx(f ? f : "_trunframe_i0",p,p0,p1) }
#_____________________________________________________________________________
func	_tbpass(f,p,p0,p1) { ###################################################
      delete _t_ENDF[++_t_ENDF[0]]
      f=p ? _tbpass_i0(f,p,p0,p1) : ""
      --_t_ENDF[0]
      return f }
#___________________________________________________________
func	_tbpass_i0(f,p,p0,p1, a) {
      while ( p in _tLINK ) p=_tLINK[p]
      return p in _tLCHLD ? _tmbpass(f,_tLCHLD[p],p0,p1) : @f(p,p0,p1) }
#_________________________________________________________________
func	_tmbpass(f,p,p0,p1) { ######################################
      while ( (p) && (!(_t_ENDF[0] in _t_ENDF)) ) {
            p0=_tbpass_i0(f,p,p0,p1, p=p in _tPREV ? _tPREV[p] : "") }
      return p0 }
#_________________________________________________________________
func	_tbrunpass(f,p,p0,p1) { ####################################
      return _tbpass(f ? f : "_trunframe_i0",p,p0,p1) }
#_____________________________________________________________________________
func	_tbpassx(f,p,p0,p1) { ##################################################
      delete _t_ENDF[++_t_ENDF[0]]
      f=p ? _tbpassx_i0(f,p,p0,p1) : ""
      --_t_ENDF[0]
      return f }
#___________________________________________________________
func	_tbpassx_i0(f,p,p0,p1) {
      while ( p in _tLINK ) p=_tLINK[p]
      return p in _tLCHLD ? _tmbpassx(f,_tLCHLD[p],p0,p1) : @f(p,p0,p1) }
#_________________________________________________________________
func	_tmbpassx(f,p,p0,p1) { #####################################
      while ( (p) && (!(_t_ENDF[0] in _t_ENDF)) ) {
            p0=_tbpassx_i0(f,p,p0,p1); p=p in _tPREV ? _tPREV[p] : "" }
      return p0 }
#_________________________________________________________________
func	_tbrunpassx(f,p,p0,p1) { ###################################
      return _tbpassx(f ? f : "_trunframe_i0",p,p0,p1) }
#_______________________________________________________________________
func	_tend(a,b) { #####################################################
      if ( b=="" )	return _t_ENDF[_t_ENDF[0]]=a
                  else	return _t_ENDF[_t_ENDF[0]+a]=b }
#_________________________________________________________________
func	_tifend(l) { ###############################################
      return (_t_ENDF[0]+l) in _t_ENDF ? (_t_ENDF[_t_ENDF[0]+l] ? _t_ENDF[_t_ENDF[0]+l] : 1) : "" }


#_____________________________________________________________________________
func	_tdelete(p, v) { #######################################################				# REMAKE EXCLUDE
      if ( p )	_wLCHLD(_tDELPTR,p)
      return v }


#_____________________________________________________________________________
func	_tbrochld(p, f,pp) { ###################################################				# TEST!!!
      if ( p ) {
            if ( p in _tFCHLD ) {
                  f=_tFCHLD[p]; delete _tFCHLD[p]; delete _tLCHLD[p]
                  if ( p in _tPARENT ) {
                        pp=_tPARENT[p]; delete _tPARENT[p]
                        if ( p in _tPREV ) {
                              _tNEXT[_tPREV[f]=_tPREV[p]]=f; delete _tPREV[p] }
                        else {
                              _tFCHLD[pp]=f }
                        for ( ; f in _tNEXT; f=_tNEXT[f] )	_tPARENT[f]=pp
                        _tPARENT[f]=pp
                        if ( p in _tNEXT ) {
                              _tPREV[_tNEXT[f]=_tNEXT[p]]=f; delete _tNEXT[p] }
                        else {
                              _tLCHLD[pp]=f }
                        _tQCHLD[pp]=_tQCHLD[pp]+_tQCHLD[p]-1
                        delete _tQCHLD[p]
                        return f }
                  else {
                        delete _tQCHLD[p]
                        if ( p in _tPREV ) {
                              _tNEXT[_tPREV[f]=_tPREV[p]]=f; delete _tPREV[p] }
                        for ( ; f in _tNEXT; f=_tNEXT[f] )	delete _tPARENT[f]
                        delete _tPARENT[f]
                        if ( p in _tNEXT ) {
                              _tPREV[_tNEXT[f]=_tNEXT[p]]=f; delete _tNEXT[p] }
                        return f } }
            else {
                  if ( p in _tPARENT ) {
                        pp=_tPARENT[p]; delete _tPARENT[p]
                        if ( p in _tPREV ) {
                              if ( p in _tNEXT ) {
                                    _tNEXT[_tPREV[f]=_tPREV[p]]=f=_tNEXT[p]; delete _tNEXT[p] }
                              else {
                                    delete _tNEXT[_tLCHLD[pp]=_tPREV[p]] }
                              delete _tPREV[p]; _tQCHLD[pp]-- }
                        else {
                              if ( p in _tNEXT ) {
                                    delete _tPREV[_tFCHLD[pp]=_tNEXT[p]]; delete _tNEXT[p]; _tQCHLD[pp]-- }
                              else {
                                    delete _tFCHLD[pp]; delete _tLCHLD[pp]; delete _tQCHLD[pp] } } }
                  else {
                        if ( p in _tPREV ) {
                              if ( p in _tNEXT ) {
                                    _tNEXT[_tPREV[f]=_tPREV[p]]=f=_tNEXT[p]; delete _tNEXT[p] }
                              else {
                                    delete _tNEXT[_tPREV[p]] }
                              delete _tPREV[p] }
                        else {
                              if ( p in _tNEXT ) {
                                    delete _tPREV[_tNEXT[p]]; delete _tNEXT[p] } } } } }
      return p }

# 	test _tbrochld fn; develope tOBJ r\w func specification for brochld func

#_________________________________________________________________
func	_tinit_i0(D,S, i) {
      for ( i in S ) {
            if ( isarray(S[i]) ) {
                  if ( !isarray(D[i][""]) ) {
                        delete D[i]; D[i][""]; delete D[i][""] }
                  _N_i0(D[i],S[i]) }
            else {
                  if ( isarray(D[i]) )	delete D[i]
                  D[i]=S[i] } } }
#_______________________________________________________________________
func	W(p,p0,p1) { #####################################################
      if ( isarray(p0) ) {
            delete p0[p]
            if ( isarray(p1) ) {
                  for ( i in p1 ) {
                        if ( isarray(p1[i]) ) {
                              p0[p][i][""]; delete p0[p][i][""]; _N_i0(p0[p][i],p1[i]) }
                        else	p0[p][i]=p1[i] }
                  return p }
            return p0[p]=p1 }
      delete _[p][p0]
      if ( isarray(p1) ) {
            for ( i in p1 ) {
                  if ( isarray(p1[i]) ) {
                        _[p][p0][i][""]; delete _[p][p0][i][""]; _N_i0(_[p][p0][i],p1[i]) }
                  else	_[p][p0][i]=p1[i] }
            return p }
      return _[p][p0]=p1 }




#___________________________________________________________________________________
# EMMULATED FUNCTIONAL FIELDS ######################################################

#_____________________________________________________________________________
func	_rSQFIRST(g,p,A) { #####################################################
      if ( isarray(A) )	return _rSQFIRSTA(g,p,A)
      _SQTOPTR[g]=p; _SQSTACK[g][0]=0
      return _rsqgetptr(g,p) }
#_________________________________________________________________
func	_rSQFIRSTA(g,p,A) { ########################################
      _SQTOPTR[g]=p; _SQSTACK[g][0]=0
      if ( (p=_rsqgetptr(g,p)) in A )		return p
      return _rSQNEXTA(g,p,A) }
#_______________________________________________________________________
func	_rSQNEXT(g,p,A) { ################################################
      if ( isarray(A) )	return _rSQNEXTA(g,p,A)
      return _rsqnext_i0(g,p) }
#___________________________________________________________
func	_rsqnext_i0(g,p) {
      if ( p==_SQTOPTR[g] ) {
            if ( _SQSTACK[g][0]>0 ) {
                  _SQTOPTR[g]=_SQSTACK[g][_SQSTACK[g][0]--]
                  return _rsqnext_i0(g,_SQSTACK[g][_SQSTACK[g][0]--]) }
            return }
      if ( p in _tNEXT )		return _rsqgetptr(g,_tNEXT[p])
      return _rsqnext_i0(g,_tPARENT[p]) }
#_________________________________________________________________
func	_rSQNEXTA(g,p,A) { #########################################
      if ( p==_SQTOPTR[g] ) {
            if ( _SQSTACK[g][0]>0 ) {
                  _SQTOPTR[g]=_SQSTACK[g][_SQSTACK[g][0]--]
                  return _rSQNEXTA(g,_SQSTACK[g][_SQSTACK[g][0]--],A) }
            return }
      while ( p in _tNEXT ) {
            if ( (p=_rsqgetptr(g,_tNEXT[p])) in A )		return p }
      return p in _tPARENT ? _rSQNEXTA(g,_tPARENT[p],A) : "" }
#_________________________________________________________________
func	_rsqgetptr(g,p,A) {
            if ( p in _tLINK ) {
                  _SQSTACK[g][++_SQSTACK[g][0]]=p
                  _SQSTACK[g][++_SQSTACK[g][0]]=_SQTOPTR[g]
                  while ( (p=_tLINK[p]) in _tLINK ) { _con(".") }
                  _SQTOPTR[g]=p }
            if ( p in _tFCHLD )		return _rsqgetptr(g,_tFCHLD[p])
            return p }
#___________________________________________________________________________________
####################################################################################


#___________________________________________________________________________________
# OTHER tFUNCTIONs #################################################################

#_____________________________________________________________________________
func	_dumpobj(p,f,t, s) { ###################################################
      s=_dumpobj_i0(p,f,t=t "." p "{")
      if ( (p=_rFCHLD(p)) )	return s=s _dumpobjm(p,f,s ? _getchrln(" ",length(t)-1) : t " ")
      return s }
#___________________________________________________________
func	_dumpobj_i0(p,f,t) {
      if ( f=="" )	return _dumpobj_i2(p,t)
      if ( f==0 )		return _dumpobj_i1(p,t " ")
      return _dumpobj_i1(p,t " ") _dumpobj_i2(p,_getchrln(" ",length(t))) }
#___________________________________________________________
func	_dumpobj_i1(p,t) {
      return _ln(t		substr(((p in _tPREV)	? "\xAB"	_tPREV[p]	: "")	"       ",1,7) " "		substr(((p in _tPARENT)	? "\x88"	_tPARENT[p]	: "")	"       ",1,7) " "		substr(			((p in _tFCHLD)	? _tFCHLD[p] : "") "\x85"			((p in _tQCHLD)	? " (" _tQCHLD[p] ") " : "\x85")			"\x85" ((p in _tLCHLD)	? _tLCHLD[p] : "") "                      ",1,22)		substr(((p in _tNEXT)	? "\xBB"	_tNEXT[p]	: "")	"        ",1,8) ) }
#___________________________________________________________
func	_dumpobj_i2(p,t) {
      return	_dumpobj_i3(_[p],t " ") _dumpobj_i3(_ptr[p],_getchrln(" ",length(t)) "`","`") }
#___________________________________________________________
func	_dumpobj_i3(A,t,p,e, s,i,t2) {
      if ( isarray(A) ) {
            for ( i in A ) {
                  t2=_getchrln(" ",length(t))
                  for ( i in A )	{ if ( isarray(A[i]) )		s=s _dumpobj_i3(A[i],t "[" _dumpobj_i4(i) "]",p,_ln())
                                                      else		s=s _ln(t "[" _dumpobj_i4(i) "]=" p _dumpobj_i4(A[i]) "'")
                                    t=t2 }
                  return s }
            return e=="" ? "" : t e }
      if ( A==0 && A=="" )	return
      return _ln(t "=" _dumpobj_i4(p A) "'") }
#___________________________________________________________
func	_dumpobj_i4(t) {
      if ( length(t)>64 )	return substr(t,1,28) " ... " substr(t,length(t)-28)
      return t }
#_________________________________________________________________
func	_dumpobjm(p,f,t, s,t2) { ###################################
      t2=_getchrln(" ",length(t))
      do {	s=s _dumpobj(p,f,t); t=t2	} while ( (p=_rNEXT(p)) )
      return s }
#_________________________________________________________________
func	_dumpobj_nc(p,f,t) { #######################################
      return _dumpobj_i0(p,f,t "." p "{ ") }
#_________________________________________________________________
func	_dumpobjm_nc(p,f,t, s,t2) { ################################
      t2=_getchrln(" ",length(t))
      do {	s=s _dumpobj_nc(p,f,t); t=t2	} while ( (p=_rNEXT(p)) )
      return s }
#___________________________________________________________________________________
####################################################################################







func	_tapi(p,f,p0,p1,p2,p3, c) {
      c=p
      do {	if ( f in _[c]["API"] )					{ f=_[c]["API"][f]; return @f(p,p0,p1,p2,p3) }
            c=_[c]["CLASS"]	} while ( "CLASS" in _[c] ) }

#	if ( F in _TCLASS )				{ _[p]["CLASS"]=_TCLASS[F]; _tapi(p); return p }
#		# ???		_mpu(F,p)		???
#		return p }
#	_[p][F]=v; return p }

#_______________________________________________________________________
func	_tgetitem(p,n, a,b) { ############################################
      if ( p ) {
            if ( isarray(_PTR[p]["ITEM"]) && (n in _PTR[p]["ITEM"]) )		a=_PTR[p]["ITEM"][n]
                                                                        else	a=_PTR[p]["ITEM"][n]=_N()
            if ( !(b=_rFCHLD(a)) )		{ b=_wLCHLD(a,_N()); _PTR[b]["HOST"]=p; _[b]["ITEMNAME"]=n }
            return b } }
#_________________________________________________________________
func	_tdelitem(p) { #############################################
      if ( p ) {
            if ( "HOST" in _PTR[p] && "ITEMNAME" in _[p] ) {
                  return _wLCHLD(_PTR[_PTR[p]["HOST"]]["ITEM"][_[p]["ITEMNAME"]],p) }
            _tdelete(p); return p } }
















#_____________________________________________________________________________
func	_tframe0(f,p,p0,p1,p2,p3, A) { #########################################
      if ( _isptr(p) )				{ if ( isarray(f) )		return _tframe0_i0(f,p)
                                          _tframex_p0(A,f,0);	return _th0(_tframe0_i0(A,p),--_TEND[_ARRLEN]) } }
#_______________________________________________
func	_tframe0_i0(A,p, f)			{ if ( p in _tLINK ) {
                                                _tframe_link=p
                                                if ( "`" in A )	{ f=A["`"]; while ( p in _tLINK )	@f(p=_tLINK[p]) }
                                                            else	while ( p in _tLINK )			p=_tLINK[p] }
                                          else	_tframe_link=""
                                          if ( p in _tFCHLD )		return	_tframe0_i2(A,"^",p) _tframe0_i1(A,_tFCHLD[p])
                                                                  return	_tframe0_i2(A,".",p) }
#_______________________________________________
func	_tframe0_i1(A,p)				{ if ( _TEND[_ARRLEN] in _TEND )	return
                                          if ( p in _tNEXT )		return	 _tframe0_i0(A,p) _tframe0_i1(A,_tNEXT[p])
                                                                  return	 _tframe0_i0(A,p) }
#_______________________________________________
func	_tframe0_i2(A,m,p)			{ _tframe_dlink=p; while ( p in _tDLINK )		p=_tDLINK[p]
                                          if ( m in A )		{ if ( (m "~") in A )	{ if ( !(_TYPEWORD in _[p]) ||	A[m "~"]!~_[p][_TYPEWORD] )	return }
                                                            m=A[m]; return @m(p) } }
#_____________________________________________________
func	_tframex_p0(A,f,q, i,B,C) {
      _tframe_qparam=q; delete _TEND[++_TEND[_ARRLEN]]
      
      if ( match(f,/\~(.*)$/,B) )	{ A["^~"]=A[".~"]=B[1]; f=substr(f,1,RSTART-1) }
      A["."]=A["^"]=f; return
      q=split(f,B,/;/); i=0
      while ( i<q )	{ _tframex_p1(A,C[i]); while ( ++i<=q )	_tframex_p1(A,C[i],B[i]) } }
#_______________________________________________
func	_tframex_p1(A,v,i, r,B) {
      gsub(/[ \t]+/,"",v)
      while ( match(v,/^([^~]*)~\/(([^\/\\]*\\.)*[^\/\\]*)\//,B) )		{ v=B[1] substr(v,RSTART+RLENGTH); r=B[2] }
      if ( i=="" )		{ if ( v!="" )		{ A["."]=v; delete A["`"]; delete A["^"] }
                        if ( r!="" )			A[".~"]=A["`~"]=A["^~"]=r }
                  else	{ if ( match(v,/!/) )	delete A[i]
                                          else	{ A[i]=v; if ( r!="" )		A[i "~"]=r } } }
#_________________________________________________________________
func	_tframe1(f,p,p0,p1,p2,p3, A) { #############################
      if ( _isptr(p) )				{ if ( isarray(f) )		return _tframe1_i0(f,p,p0)
                                          _tframex_p0(A,f,1);	return _th0(_tframe1_i0(A,p,p0),--_TEND[_ARRLEN]) } }
#_______________________________________________
func	_tframe1_i0(A,p,p0)			{ _tframe_link=p; while ( p in _tLINK )	p=_tLINK[p]
                                          if ( p in _tFCHLD )		return	_tframe1_i2(A,"^",p,p0) _tframe1_i1(A,_tFCHLD[p],p0)
                                                                  return	_tframe1_i2(A,".",p,p0) }
#_______________________________________________
func	_tframe1_i1(A,p,p0)			{ if ( _TEND[_ARRLEN] in _TEND )	return
                                          if ( p in _tNEXT )		return	 _tframe1_i0(A,p,p0) _tframe1_i1(A,_tNEXT[p],p0)
                                                                  return	 _tframe1_i0(A,p,p0) }
#_______________________________________________
func	_tframe1_i2(A,m,p,p0)			{ _tframe_dlink=p; while ( p in _tDLINK )		p=_tDLINK[p]
                                          if ( m in A )		{ if ( (m "~") in A )	{ if ( !(_TYPEWORD in _[p]) ||	A[m "~"]!~_[p][_TYPEWORD] )	return }
                                                            m=A[m]; return @m(p,p0) } }
#_________________________________________________________________
func	_tframe2(f,p,p0,p1,p2,p3, A) { #############################
      if ( _isptr(p) )				{ if ( isarray(f) )		return _tframe2_i0(f,p,p0,p1)
                                          _tframex_p0(A,f,2);	return _th0(_tframe2_i0(A,p,p0,p1),--_TEND[_ARRLEN]) } }
#_______________________________________________
func	_tframe2_i0(A,p,p0,p1)			{ _tframe_link=p; while ( p in _tLINK )	p=_tLINK[p]
                                          if ( p in _tFCHLD )		return	_tframe2_i2(A,"^",p,p0,p1) _tframe2_i1(A,_tFCHLD[p],p0,p1)
                                                                  return	_tframe2_i2(A,".",p,p0,p1) }
#_______________________________________________
func	_tframe2_i1(A,p,p0,p1)			{ if ( _TEND[_ARRLEN] in _TEND )	return
                                          if ( p in _tNEXT )		return	 _tframe2_i0(A,p,p0,p1) _tframe2_i1(A,_tNEXT[p],p0,p1)
                                                                  return	 _tframe2_i0(A,p,p0,p1) }
#_______________________________________________
func	_tframe2_i2(A,m,p,p0,p1)		{ _tframe_dlink=p; while ( p in _tDLINK )		p=_tDLINK[p]
                                          if ( m in A )		{ if ( (m "~") in A )	{ if ( !(_TYPEWORD in _[p]) ||	A[m "~"]!~_[p][_TYPEWORD] )	return }
                                                            m=A[m]; return @m(p,p0,p1) } }
#_________________________________________________________________
func	_tframe3(f,p,p0,p1,p2,p3, A) { #############################
      if ( _isptr(p) )				{ if ( isarray(f) )		return _tframe3_i0(f,p,p0,p1,p2)
                                          _tframex_p0(A,f,3);	return _th0(_tframe3_i0(A,p,p0,p1,p2),--_TEND[_ARRLEN]) } }
#_______________________________________________
func	_tframe3_i0(A,p,p0,p1,p2)		{ _tframe_link=p; while ( p in _tLINK )	p=_tLINK[p]
                                          if ( p in _tFCHLD )		return	_tframe3_i2(A,"^",p,p0,p1,p2) _tframe3_i1(A,_tFCHLD[p],p0,p1,p2)
                                                                  return	_tframe3_i2(A,".",p,p0,p1,p2) }
#_______________________________________________
func	_tframe3_i1(A,p,p0,p1,p2)		{ if ( _TEND[_ARRLEN] in _TEND )	return
                                          if ( p in _tNEXT )		return	 _tframe3_i0(A,p,p0,p1,p2) _tframe3_i1(A,_tNEXT[p],p0,p1,p2)
                                                                  return	 _tframe3_i0(A,p,p0,p1,p2) }
#_______________________________________________
func	_tframe3_i2(A,m,p,p0,p1,p2)		{ _tframe_dlink=p; while ( p in _tDLINK )		p=_tDLINK[p]
                                          if ( m in A )		{ if ( (m "~") in A )	{ if ( !(_TYPEWORD in _[p]) ||	A[m "~"]!~_[p][_TYPEWORD] )	return }
                                                            m=A[m]; return @m(p,p0,p1,p2) } }
#_________________________________________________________________
func	_tframe4(f,p,p0,p1,p2,p3, A) { #############################
      if ( _isptr(p) )				{ if ( isarray(f) )		return _tframe4_i0(f,p,p0,p1,p2,p3)
                                          _tframex_p0(A,f,4);	return _th0(_tframe4_i0(A,p,p0,p1,p2,p3),--_TEND[_ARRLEN]) } }
#_______________________________________________
func	_tframe4_i0(A,p,p0,p1,p2,p3)		{ _tframe_link=p; while ( p in _tLINK )	p=_tLINK[p]
                                          if ( p in _tFCHLD )		return	_tframe4_i2(A,"^",p,p0,p1,p2,p3) _tframe4_i1(A,_tFCHLD[p],p0,p1,p2,p3)
                                                                  return	_tframe4_i2(A,".",p,p0,p1,p2,p3) }
#_______________________________________________
func	_tframe4_i1(A,p,p0,p1,p2,p3)		{ if ( _TEND[_ARRLEN] in _TEND )	return
                                          if ( p in _tNEXT )		return	 _tframe4_i0(A,p,p0,p1,p2,p3) _tframe4_i1(A,_tNEXT[p],p0,p1,p2,p3)
                                                                  return	 _tframe4_i0(A,p,p0,p1,p2,p3) }
#_______________________________________________
func	_tframe4_i2(A,m,p,p0,p1,p2,p3)	{ _tframe_dlink=p; while ( p in _tDLINK )		p=_tDLINK[p]
                                          if ( m in A )		{ if ( (m "~") in A )	{ if ( !(_TYPEWORD in _[p]) ||	A[m "~"]!~_[p][_TYPEWORD] )	return }
                                                                  m=A[m]; return @m(p,p0,p1,p2,p3) } }
#_____________________________________________________
#	_tframe0(hndstr,ptr)
#
#
#			IN:
#			MOD:
#			OUT:
#			RETURN:
#
#	handler string:
#		Handler-string divides to words. Word splitter is char ";"
#
#	Note that handler-string processed left to right. This mean that next word(more rightly) will overwrite fields implemented before(leftmost).
#	Note that if word-string contains more than one rexp-field then only last rexp-field(most rightly) will be applied.
#_______________________________________________
# TO DESIGN:
#
# 0-4: complete design of tlink handler call
# 1-4: add new tlink handler call
# 1-4: add new run fn (changed rexp to different for each type: see _tframe0)
#
# hndstr:
#	may be add rexp for each type of handler and also total rexp for all ??? ADDED (test)
#	may be add separator char ";" ???		ADDED (test)
#_______________________________________________________________________
func	_tzend(a,b) { #####################################################
      if ( b==0 && b=="" )	return _TEND[_TEND[_ARRLEN]]=a
                        else	return _TEND[_TEND[_ARRLEN]+a]=b }
#_______________________________________________
BEGIN {	_TEND[_ARRLEN]=0
            _TYPEWORD		="_TYPE" }
#_______________________________________________________________________
########################################################################






















#_______________________________________________________________________
#	_N(arr\str\mpuptr,val) \ _n(arr\str\mpuptr,val)
#		This functions create new object and return ptr.
#		_n() - creates object from list of deleted objects or if it's empty create new one, while _N() always create new one
#		It is strongly recommended to use _N() for the objects that have some data outside of standart object arrays. Or - make routines
#		that will clear outsided object data in case if object deleting.
#
#			IN:		arr\str\mpu,val	- (both missed) just create obj and return ptr
#					arr,val		- create object and write arr[ptr]=val
#					str,val		- create object and write _[ptr][str]=val
#					mpuptr		- NOT ALLOWED (val missed) create object and run MPU-code specified by mpuptr with created object ptr as primary parameter
#			MOD:		-
#			OUT:		-
#			RETURN:	ptr			- pointer to newly created object
#_________________________________________________________________
#	_tdel(ptr)
#		This function exclude object from it's current structure and delete it. ptr can be later used by function: _n() for creating new object
#		Also same story will occured with all chields and subchields of object specified by ptr.
#		??? What happened with linked py _ptr[ptr] objects ???
#
#			IN:		ptr			- pointer to object that will deleted
#			MOD:		-
#			OUT:		-
#			RETURN:	undefined
#_________________________________________________________________
#	_isptr(ptr)
#		This function checks: is ptr is the object pointer that is currently exist?
#		Unescaped remained data will be in data of src_dst_ptr.
#
#			IN:		ptr			- string that will be tested
#			MOD:		-
#			OUT:		-
#			RETURN:	undefined		- if ptr is not pointer to exist object
#					ptr			- if ptr is the pointer to exist object
#_________________________________________________________________



#_________________________________________________________________
#
# TO DESIGN:
#
# create basic objectapi interface support
# modify everywhere checking ptr not by `if ( ptr )...', but by `if ( ptr in _ )...'
# _TMP0, _TMP1 name change to something like _DATA name ???
# think about redesigning routines for not depending if ptr is exist in tsysarrs: reason: performance\light code











func	_tlist(L,p,f) {
      _tlisti1=_tlisti0=L[_ARRLEN]+0
      if ( f==0 && f=="" )	_tlist_i0(L,p)
                        else	{ _tlistf0=f in _TAPI ? _TAPI[f] : f; _tlist_i1(L,p) }
      return _tlisti0-_tlisti1 }

func	_tlist_i0(L,p, q,i)	{ if ( isarray(p) )	{ q=p[_ARRLEN]; i=0; while ( i++<q )	_tlist_i0(L,p[i]); return }
                              if ( p in _ )		{ while ( p in _tLINK )		p=_tLINK[p]
                                                      L[++_tlisti0]=p
                                                      if ( p in _tFCHLD )		for ( p=_tFCHLD[p]; p; p=p in _tNEXT ? _tNEXT[p] : "" )	_tlist_i0(L,p) } }

func	_tlist_i1(L,p)		{ if ( isarray(p) )	{ q=p[_ARRLEN]; i=0; while ( i++<q )	_tlist_i1(L,p[i]); return }
                              if ( p in _ )		{ while ( p in _tLINK )		p=_tLINK[p]
                                                      if ( _tlistf0 in _[p] )		L[++_tlisti0]=p
                                                      if ( p in _tFCHLD )		for ( p=_tFCHLD[p]; p; p=p in _tNEXT ? _tNEXT[p] : "" )	_tlist_i1(L,p) } }














##########################################################################################
# PUBLIC:
#_____________________________________________________________________________
# _rFBRO(ptr)				- Return ptr of first-bro.				[TESTED]
#						If !ptr then returns "".
#_____________________________________________________________________________
# _rLBRO(ptr)				- Return ptr of last-bro.				[TESTED]
#						If !ptr then returns "".
#_____________________________________________________________________________
# _rQBRO(ptr)				- Returns brothers total quantity.			[TESTED]
#						If !ptr then returns "".
END{ ###############################################################################

      if ( _gawk_scriptlevel<1 ) {
            if ( !_fileio_notdeltmpflag ) {
                  _FILEIO_TMPATHS[_FILEIO_TMPRD]
                  _Foreach(_FILEIO_TMPATHS,"_uninit_del") } } }
#_____________________________________________________________________________
func	_uninit_del(A,i,p0) {
      _del(i) }
#___________________________________________________________________________________
####################################################################################

#___________________________________________________________________________________
func	_out(t, a,b) { ###############################################################
      a=BINMODE; b=ORS; BINMODE="rw"; ORS=""
      print t > _SYS_STDOUT; fflush(_SYS_STDOUT)
      BINMODE=a; ORS=b
      return t }
#_________________________________________________________________
func	_outnl(t) { ################################################
      return _out(t (t~/\x0A$/ ? "" : _CHR["EOL"])) }
#_______________________________________________________________________
func	_err(t, a,b) { ###################################################
      a=BINMODE; b=ORS; BINMODE="rw"; ORS=""
      print t > _SYS_STDERR; fflush(_SYS_STDERR)
      BINMODE=a; ORS=b
      return t }
#_________________________________________________________________
func	_errnl(t) { ################################################
      return _err(t (t~/\x0A$/ ? "" : _CHR["EOL"])) }
#_____________________________________________________________________________
func	_getfilepath(t, f,al,b,A) { ############################################
      ERRNO=""
      if ( match(t,/^[ \t]*(("([^"]*)"[ \t]*)|([`']([^']*)'[ \t]*)|(([^ \t]+)[ \t]*))/,A) ) {
            al=RLENGTH; f=A[3] A[5] A[7]; _conl("_getfilepath(" f ")        (" al ")")
            if ( (b=_filepath(f)) )		{ if ( length(f)<=FLENGTH )	{ FLENGTH=al; return b }
                                                                        ERRNO="Filepath `" f "' error" } }
      FLENGTH=0 }
#_______________________________________________________________________
func	_filepath(f,dd) { ################################################
      if ( (f=_filerdnehnd(f))=="" ) return ""
      return filegetrootdir(f,dd) (f in _FILENAM ? _FILENAM[f] : "") (f in _FILEXT ? _FILEXT[f] : "") }
#_________________________________________________________________
func	_filerdne(f,dd) { ##########################################
      if ( (f=_filerdnehnd(f))=="" ) return ""
      if ( (f in _FILENAM) )	return filegetrootdir(f,dd) _FILENAM[f] (f in _FILEXT ? _FILEXT[f] : "")
      if ( f in _FILEXT )	return filegetrootdir(f,dd) _FILEXT[f]
      return "" }
#_________________________________________________________________
func	_filerdn(f,dd) { ###########################################
      if ( (f=_filerdnehnd(f))=="" ) return ""
      return f in _FILENAM ? (filegetrootdir(f,dd) _FILENAM[f]) : "" }
#_________________________________________________________________
func	_filerd(f,dd) { ############################################
      if ( (f=_filerdnehnd(f))=="" ) return ""
      return filegetrootdir(f,dd) }
#_________________________________________________________________
func	_filer(f,dd) { #############################################
      if ( (f=_filerdnehnd(f))=="" ) return ""
      if ( f in _FILEROOT )								return _FILEROOT[f]
      if ( ((dd=dd ? dd : _FILEIO_RD),f) in _FILEROOT )			return _FILEROOT[dd,f]
      return _FILEROOT[dd,f]=fileri(dd) }
#_________________________________________________________________
func	_filed(f,dd, d) { ##########################################
      if ( (f=_filerdnehnd(f))=="" ) return ""
      if ( f in _FILEDIRFL )								return _FILEDIR[f]
      if ( f in _FILEROOT ) {
            if ( (d=filegetdrvdir(_FILEROOT[f])) ) _FILEDIRFL[f]
                                                                        return _FILEDIR[f]=d _FILEDIR[f] }
      if ( ((dd=dd ? dd : _FILEIO_RD),f) in _FILEDIR ) 			return _FILEDIR[dd,f]
      if ( (d=filedi(dd) _FILEDIR[f])~/^\\/ )					return _FILEDIR[dd,f]=d
      return d }
#___________________________________________________________
func	filegetrootdir(f,dd, d) {
      if ( f in _FILEDIRFL ) {
            if ( f in _FILEROOT )							return _FILEROOT[f] _FILEDIR[f]
            if ( ((dd=dd ? dd : _FILEIO_RD),f) in _FILEROOT )		return _FILEROOT[dd,f] _FILEDIR[f]
                                                                        return (_FILEROOT[dd,f]=fileri(dd)) _FILEDIR[f] }
      if ( f in _FILEROOT ) {
            if ( (d=filegetdrvdir(_FILEROOT[f])) ) {
                  _FILEDIRFL[f];							return _FILEROOT[f] (_FILEDIR[f]=d _FILEDIR[f]) }
            else	return _FILEROOT[f] _FILEDIR[f] }
      if ( ((dd=dd ? dd : _FILEIO_RD),f) in _FILEROOT ) {
            if ( (dd,f) in _FILEDIR ) 						return _FILEROOT[dd,f] _FILEDIR[dd,f]
            if ( (d=filedi(dd) _FILEDIR[f])~/^\\/ )				return _FILEROOT[dd,f] (_FILEDIR[dd,f]=d)
                                                                        return _FILEROOT[dd,f] d }
            if ( (dd,f) in _FILEDIR ) 						return (_FILEROOT[dd,f]=fileri(dd)) _FILEDIR[dd,f]
            if ( (d=filedi(dd) _FILEDIR[f])~/^\\/ )				return (_FILEROOT[dd,f]=fileri(dd)) (_FILEDIR[dd,f]=d)
                                                                        return (_FILEROOT[dd,f]=fileri(dd)) d }
#___________________________________________________________
func	_filerdnehnd(st, c,r,d,n,A) {
      if ( st ) {
            if ( (c=toupper(st)) in _FILECACHE ) {
                  FLENGTH=length(st); return _FILECACHE[c] }
            if ( match(st,/^[ \t]*\\[ \t]*\\/) ) {
                  if ( match(substr(st,(FLENGTH=RLENGTH)+1),/^[ \t]*([0-9A-Za-z\-]+)[ \t]*(\\[ \t]*([A-Za-z])[ \t]*\$[ \t]*)?(\\[ \t]*([0-9A-Za-z_\!\+\-\[\]\(\)\{\}\~\.]+( +[0-9A-Za-z_\!\+\-\[\]\(\)\{\}\~\.]+)*[ \t]*\\)+[ \t]*)?(([0-9A-Za-z_\!\+\.\~\-\[\]\{\}\(\)]+( +[0-9A-Za-z_\!\+\.\~\-\[\]\{\}\(\)]+)*)[ \t]*)?/,A) ) {
                        FLENGTH=FLENGTH+RLENGTH
                        d=(A[3] ? ("\\" A[3] "$") : "") A[4]; gsub(/[ \t]*\\[ \t]*/,"\\",d)
                        if ( (st=toupper((r="\\\\" A[1]) d (n=A[8]))) in _FILECACHE ) return _FILECACHE[substr(c,1,FLENGTH)]=_FILECACHE[st]
                        _FILEDIR[c=_FILECACHE[substr(c,1,FLENGTH)]=_FILECACHE[st]=++_file_rootcntr]=d; _FILEDIRFL[c]
                        _FILEROOT[c]=r }
                  else {
                        FLENGTH=0; _filepath_err="UNC"; return "" } }
            else {
                  match(st,/^(([ \t]*\.[ \t]*\\[ \t]*)|(([ \t]*([A-Za-z])[ \t]*(\:)[ \t]*)?([ \t]*(\\)[ \t]*)?))([ \t]*(([ \t]*[0-9A-Za-z_\!\+\-\[\]\(\)\{\}\~\.]+( +[0-9A-Za-z_\!\+\-\[\]\(\)\{\}\~\.]+)*[ \t]*\\)+)[ \t]*)?([ \t]*([0-9A-Za-z_\!\+\.\~\-\[\]\{\}\(\)]+( +[0-9A-Za-z_\!\+\.\~\-\[\]\{\}\(\)]+)*)[ \t]*)?/,A)
                  if ( !(FLENGTH=RLENGTH) ) return ""
                  d=A[8] A[10]; gsub(/[ \t]*\\[ \t]*/,"\\",d)
                  if ( (st=toupper((r=A[5] A[6]) d (n=A[14]))) in _FILECACHE ) return _FILECACHE[substr(c,1,FLENGTH)]=_FILECACHE[st]
                  _FILEDIR[c=_FILECACHE[substr(c,1,FLENGTH)]=_FILECACHE[st]=++_file_rootcntr]=d
                  if ( A[8] )	_FILEDIRFL[c]
                  if ( r )	_FILEROOT[c]=r }
            if ( n ) {
                  if ( match(n,/\.[^\.]*$/) ) {
                        _FILEXT[c]=substr(n,RSTART); _FILENAM[c]=substr(n,1,RSTART-1) }
                  else	_FILENAM[c]=n }
            return c }
      return "" }
#___________________________________________________________
func	filedi(f, d) {
      if ( (f=filerdnehndi(f))=="" ) return _FILEIO_D
      if ( f in _FILEDIRFL )								return _FILEDIR[f]
      if ( f in _FILEROOT ) {
            if ( (d=filegetdrvdir(_FILEROOT[f])) ) _FILEDIRFL[f]
                                                                        return _FILEDIR[f]=d _FILEDIR[f] }
      if ( (_FILEIO_RD,f) in _FILEDIR )						return _FILEDIR[_FILEIO_RD,f]
      return _FILEDIR[_FILEIO_RD,f]=_FILEIO_D _FILEDIR[f] }
#_____________________________________________________
func	fileri(f) {
      if ( (f=filerdnehndi(f))=="" ) return _FILEIO_R
      if ( f in _FILEROOT )								return _FILEROOT[f]
      if ( (_FILEIO_RD,f) in _FILEROOT )						return _FILEROOT[_FILEIO_RD,f]
      return _FILEROOT[_FILEIO_RD,f]=_FILEIO_R }
#___________________________________________________________
func	filerdnehndi(st, a,c,r,d,n,A) {
      if ( st ) {
            if ( (c=toupper(st)) in _FILECACHE ) return _FILECACHE[c]
            if ( match(st,/^[ \t]*\\[ \t]*\\/) ) {
                  if ( match(substr(st,a=RLENGTH+1),/^[ \t]*([0-9A-Za-z\-]+)[ \t]*(\\[ \t]*([A-Za-z])[ \t]*\$[ \t]*)?(\\[ \t]*([0-9A-Za-z_\!\+\-\[\]\(\)\{\}\~\.]+( +[0-9A-Za-z_\!\+\-\[\]\(\)\{\}\~\.]+)*[ \t]*\\)*[ \t]*)?(([0-9A-Za-z_\!\+\.\~\-\[\]\{\}\(\)]+( +[0-9A-Za-z_\!\+\.\~\-\[\]\{\}\(\)]+)*)[ \t]*)?/,A) ) {
                        a=a+RLENGTH
                        d=(A[3] ? ("\\" A[3] "$") : "") "\\" A[5]; gsub(/[ \t]*\\[ \t]*/,"\\",d)
                        if ( (st=toupper((r="\\\\" A[1]) d (n=A[8]))) in _FILECACHE ) return _FILECACHE[substr(c,1,a)]=_FILECACHE[st]
                        _FILEDIR[c=_FILECACHE[substr(c,1,a)]=_FILECACHE[st]=++_file_rootcntr]=d; _FILEDIRFL[c]
                        _FILEROOT[c]=r }
                  else {
                        _filepath_err="UNC"; return "" } }
            else {
                  match(st,/^(([ \t]*\.[ \t]*\\[ \t]*)|(([ \t]*([A-Za-z])[ \t]*(\:)[ \t]*)?([ \t]*(\\)[ \t]*)?))([ \t]*(([ \t]*[0-9A-Za-z_\!\+\-\[\]\(\)\{\}\~\.]+( +[0-9A-Za-z_\!\+\-\[\]\(\)\{\}\~\.]+)*[ \t]*\\)+)[ \t]*)?([ \t]*([0-9A-Za-z_\!\+\.\~\-\[\]\{\}\(\)]+( +[0-9A-Za-z_\!\+\.\~\-\[\]\{\}\(\)]+)*)[ \t]*)?/,A)
                  if ( !RLENGTH ) return ""
                  d=A[8] A[10]; gsub(/[ \t]*\\[ \t]*/,"\\",d)
                  if ( (st=toupper((r=A[5] A[6]) d (n=A[14]))) in _FILECACHE ) return _FILECACHE[substr(c,1,RLENGTH)]=_FILECACHE[st]
                  _FILEDIR[c=_FILECACHE[substr(c,1,RLENGTH)]=_FILECACHE[st]=++_file_rootcntr]=d
                  if ( A[8] )	_FILEDIRFL[c]
                  if ( r )	_FILEROOT[c]=r }
            if ( n ) {
                  if ( match(n,/\.[^\.]*$/) ) {
                        _FILEXT[c]=substr(n,RSTART); _FILENAM[c]=substr(n,1,RSTART-1) }
                  else	_FILENAM[c]=n }
            return c }
      return "" }
#___________________________________________________________
func	filegetdrvdir(t, r) {
      if ( t in _FILEDRV ) return _FILEDRV[t]
      if ( match(r=_cmd("cd " t " 2>NUL"),/[^\x00-\x1F]+/) ) {
            r=gensub(/[ \t]*([\\\$\:])[ \t]*/,"\\1","G",substr(r,RSTART,RLENGTH)); gsub(/(^[ \t]*)|([ \t]*$)/,"",r)
            if ( match (r,/\:(.*)/) ) {
                  return _FILEDRV[tolower(t)]=_FILEDRV[toupper(t)]=substr(r,RSTART+1) (r~/\\$/ ? "" : "\\") } }
      return "" }
#_________________________________________________________________
func	_filene(f) { ###############################################
      if ( (f=_filerdnehnd(f))=="" ) return ""
      return (f in _FILENAM ? _FILENAM[f] : "") (f in _FILEXT ? _FILEXT[f] : "") }
#_________________________________________________________________
func	_filen(f) { ################################################
      if ( (f=_filerdnehnd(f))=="" ) return ""
      return f in _FILENAM ? _FILENAM[f] : "" }
#_________________________________________________________________
func	_file(f) { #################################################
      if ( (f=_filerdnehnd(f))=="" ) return ""
      return f in _FILEXT ? _FILEXT[f] : "" }



#_______________________________________________________________________
func	_rdfile(f, i,A) { ################################################
      if ( ((f=_filerdne(f))=="") || (_filene(f)=="") )	{ ERRNO="Filename error"; return }
      _fio_cmda=RS; RS=".{1,}"; _fio_cmdb=BINMODE; BINMODE="rw"; ERRNO=RT=_NUL
      getline RS < f; BINMODE=_fio_cmdb; RS=_fio_cmda
      if ( ERRNO=="" )		close(f)
      if ( ERRNO=="" )		return RT
      return RT=_NOP }
#_________________________________________________________________
func	_wrfile(f,d, a,b) { #########################################
      if ( ((f=_wfilerdnehnd(f))=="") || (_filene(f)=="") ) {
            ERRNO="Filename error"; return }
      a=BINMODE; BINMODE="rw"; b=ORS; ORS=""; ERRNO=""
      print d > f
      if ( ERRNO ) return ""
      close(f)
      BINMODE=a; ORS=b
      if ( ERRNO ) return ""
      return f }
#___________________________________________________________
func	_wrfile1(f,d, a,b) { ##################################
      if ( ((f=_wfilerdnehnd(f))=="") || (_filene(f)=="") ) {
            ERRNO="Filename error"; return }
      a=BINMODE; BINMODE="rw"; b=ORS; ORS=""; ERRNO=""
      print d > f
      if ( ERRNO ) return ""
      close(f)
      BINMODE=a; ORS=b
      if ( ERRNO ) return ""
      return d }
#___________________________________________________________
func	_addfile(f,d, a,b) { ##################################
      if ( ((f=_wfilerdnehnd(f))=="") || (_filene(f)=="") ) {
            ERRNO="Filename error"; return }
      a=BINMODE; BINMODE="rw"; b=ORS; ORS=""; ERRNO=""
      print d >> f
      if ( ERRNO ) return ""
      close(f)
      BINMODE=a; ORS=b
      if ( ERRNO ) return ""
      return d }
#___________________________________________________________
func	_wfilerdnehnd(f, t) {
      if ( (f=_filerdne(f))=="" ) return ""
      if ( !((t=_filerd(f)) in _WFILEROOTDIR) ) {
            _cmd("md \"" t "\" 2>NUL"); _WFILEROOTDIR[t] }
      return f }
#_______________________________________________________________________
func	_dir(A,rd, i,r,f,ds,pf,B,C) { ####################################
      delete A
      gsub(/(^[ \t]*)|([ \t]*$)/,"",rd); if ( rd=="" ) return ""
      i=split(_cmd("dir \"" rd "\" 2>NUL"),B,/\x0D?\x0A/)-3
      pf=(match(B[4],/Directory of ([^\x00-\x1F]+)/,C) ? (C[1] (C[1]~/\\$/ ? "" :"\\")) : "")
      for ( r=0; i>5; i-- ) {
            if ( match(B[i],/^([^ \t]*)[ \t]+([^ \t]*)[ \t]+((<DIR>)|([0-9\,]+))[ \t]+([^\x00-\x1F]+)$/,C) ) {
                  if ( C[6]!~/^\.\.?$/ ) {
                        if ( C[4] ) ds="D "
                        else {
                              ds=C[5] " "; gsub(/\,/,"",ds) }
                        if ( (f=_filepath(pf C[6] (C[4] ? "\\" : "")))!="" ) {
                        A[f]=ds C[1] " " C[2]; r++ } } } }
      return r }
#_________________________________________________________________
func	_dirtree(A,f, B) { #########################################
      gsub(/(^[ \t]*)|([ \t]*$)/,"",f)
      delete A; A[""]; delete A[""]
      _dirtree_i0(B,8,split(_cmd("dir \"" f "\" /-C /S 2>NUL"),B,/\x0D?\x0A/),A,f=_filerd(f))
      return f }
#___________________________________________________________
func	_dirtree_i0(B,i,c,A,f, lf,a,C) {
      delete A[f]; A[f][0]; delete A[f][0]
      lf=length(f)
      for ( ; i<=c; ) {
                  if ( match(B[i],/^[ \t]*Directory of (.+)/,C) ) {
                        if ( substr(a=_filerd(C[1] "\\"),1,lf)==f ) {
                              i=_dirtree_i0(B,i+4,c,A[f],a) }
                        else	return i }
            else	if ( match(B[i++],/^([^ \t\-]+)\-([^ \t\-]+)\-([^ \t]+)[ \t]+([^ \t]+)[ \t]+([0-9]+)[ \t]+(.+)$/,C) ) {
                        A[f][f C[6]]=C[5] " " C[1] "/" _CHR["MONTH"][C[2]] "/" C[3] " " C[4] } }
      return i }
#_______________________________________________________________________
func	_filexist(f, a) { ################################################
      if ( f=="" ) return ""
      if ( (a=_filepath(f))=="" ) {
            ERRNO="Filepath error `" f "'"; return "" }
      _cmd("if exist \"" a "\" exit 1 2>NUL")
      if ( _exitcode==1 )	return a
      ERRNO="File not found `" f "'"
      return _NOP }
#_________________________________________________________________
func	_filenotexist(f, a) { ######################################
      if ( f=="" ) return ""
      if ( (a=_filepath(f))=="" ) {
            ERRNO="Filepath error `" f "'"; return "" }
      _cmd("if exist \"" a "\" exit 1 2>NUL")
      if ( _exitcode==1 )	return ERRNO=_NOP
      return a }
#_______________________________________________________________________
func	_newdir(f) { #####################################################
      if ( (f=_filerd(f))=="" ) return
      if ( !(f in  _WFILEROOTDIR) ) {
            _cmd("md " f " 2>NUL"); _WFILEROOTDIR[f] }
      return f }
#_________________________________________________________________
func	_newclrdir(f) { ############################################
      if ( (f=_filerd(f))=="" ) return
      _cmd("rd " f " /S /Q 2>NUL"); _cmd("md " f " 2>NUL")
      _WFILEROOTDIR[f]
      return f }
#_______________________________________________________________________
func	_del(f, c,a,A) { #################################################
      if ( match(f,/\\[ \t]*$/) ) {
            if ( (c=toupper(_filerd(f))) && (length(f)==FLENGTH) ) {
                  _cmd("rd " c " /S /Q 2>NUL")
                  _deletepfx(_WFILEROOTDIR,c); _deletepfx(_FILEIO_RDTMP,c); _deletepfx(_FILEIO_RDNETMP,c) }
            else	{
                  _conl("HUJ TEBE!")
                  return "" } }
      else {
            a=_dir(A,f); _cmd("del " f " /Q 2>NUL")
            for ( c in A ) {
                  if ( c~/\\$/ ) {
                        _cmd("rd " c " /S /Q 2>NUL")
                        _deletepfx(_WFILEROOTDIR,c); _deletepfx(_FILEIO_RDTMP,c) }
                  _deletepfx(_FILEIO_RDNETMP,c) } }
      return a }
#_______________________________________________________________________
func	_setmpath(p, a) { ################################################
      ERRNO=""
      if ( (p) && (a=_filerd(p)) ) {
            if ( _FILEIO_TMPRD ) _FILEIO_TMPATHS[_FILEIO_TMPRD]
            #if ( _filexist(a) ) _del(a)
            #_cmd("rd " a " /S /Q 2>NUL"); _cmd("del " a " /Q 2>NUL")
            return _FILEIO_TMPRD=a }
      else	return _warning("`" p "': cannot set temporary folder" (ERRNO ? (": " ERRNO) : "")) }
#_________________________________________________________________
func	_getmpfile(f,dd) { #########################################
      if ( (!dd) || (!(dd=_filerd(dd))) ) dd=_FILEIO_TMPRD
      if ( (f=_filerdne(_filene(f) ? f : (f "_" ++_FILEIO_TMPCNTR),dd)) ) _FILEIO_RDNETMP[toupper(f)]
      return f }
#_________________________________________________________________
func	_getmpdir(f,dd) { ##########################################
      if ( (!dd) || (!(dd=_filerd(dd))) ) dd=_FILEIO_TMPRD
      if ( (f=f ? _filerd(f,dd) : _filerd("_" ++_FILEIO_TMPCNTR "\\",dd)) ) _FILEIO_RDTMP[toupper(f)]
      return f }
#_________________________________________________________________
func	_untmp(f, a) { #############################################
      if ( (f=filepath(f)) ) {
            if ( match(f,/\\$/) ) {
                  _deletepfx(_FILEIO_RDTMP,a=toupper(f)); _deletepfx(_FILEIO_RDNETMP,a) }
            else {
                  delete _FILEIO_RDNETMP[toupper(f)] }
            return f }
      return "" }
#___________________________________________________________________________________
####################################################################################
















#___________________________________________________________________________________
# fn	_dirtree(array,pathmask)
#
#	Return in `array' file tree from pathmask:
#		array["file.filerdne"]="size date time"
#		array["subdir.filerd"]["file.filerdne"]="size date time"
#		array["subdir.filerd"]["file.filerd"][...]
#
#		The array will be cleared before any action. Function return pathmask w/o ltabspc and rtabspc.
#___________________________________________________________________________________





# OK:		change internal function's names to: w\o "_"
# OK:		FLENGTH: should cover r-spcs
# OK:		optimize REXP
# OK:		add new symbols to dir/file names ( ! and + )
# OK:		create _getfilepath()
# OK:		del - conflict with WROOTDIR (do not update it)
# OK:		dir/del - support for filemask ( * and ? )
# OK:		how to define code injections: header\ender; and HANDLERS
# OK:		units in header\ender? conline division...
# OK:		_FILEPATH problem: it will not been defined at the moment when subscript0 starts - at the start TMPRD="_tmp"
# OK:		del:	if del("dir\\") - then all ok except it NOT deleted "dir\\"	- _del function removed(renamed to __del)
# OK:		tmpdirs: it delete only autotmp dir and only from script0
# OK:		MICROTEST:	global testing of filepath (UNC! CORRECT RESULTS! )
#	question about cache: did new just now generated absolute filepath cached in FILECACHE? its seems like NO
# check _untmp: CONFLICT: if file or dir from autotmp dir will be untmp then it anyway will be deleted; but file or dir from other point never be deleted anyway - so what is the point of untmp?????
#ERRLOG:	_setmpath:	warning!!!!!

#___________________________________________________________________________________
####################################################################################
# PUBLIC:
#___________________________________________________________________________________
#
#	fn	_rdfile(_filepath)
#
#		Read and return data from file specified in _filepath.
#			If _filepath=="" then no action occured and return "".
#			Function read and return data from file. No any changes in data occured.
#			Function use _filerdne function internally. If some syntax error
#				found in _filepath then function return "".
#			If some error occured while reading data from file then fuction return ""
#				and error-text is in ERRNO(and no close-file action will be occured!).
#			If reading data completed successfully then function try to close
#				file and if while closing file some error occured then function
#				returns "" and error-text is in ERRNO.
#			Otherwise function returns readed data.
#_____________________________________________________________________________
#
#	fn	_wrfile(_filepath,_data)
#
#		Write data into file specified in _filepath.
#			If _filepath=="" then no action occured and return "".
#			Function write _data to file. No any changes in data occured.
#			Function use _filerdne function internally. If some syntax error
#				found in _filepath then function return "".
#			If some error occured while writing data to file then fuction return ""
#				and error-text is in ERRNO(and no close-file action will be occured!).
#			If writing data completed successfully then function try to close
#				file and if while closing file some error occured then function
#				returns "" and error-text is in ERRNO.
#			Otherwise function returns _filepath(re-processed).
#___________________________________________________________________________________
#
#	fn	_filepath(_filepath)
#
#		Return re-processed root-dir-name-ext of _filepath.
#			If _filepath=="" then no action occured and return "".
#			If some syntax error found in _filepath then function return ""
#				(and NO _filepath-cache-record will be created!).
#_____________________________________________________________________________
#
#	fn	_filerdne(_filepath)
#
#		Return re-processed root-dir-filename of _filepath.
#			If _filepath=="" then no action occured and return "".
#			Function return result only if in _filepath present file-name(name
#				and/or extension) - otherwise its return "".
#			If some syntax error found in _filepath then function return ""
#				(and NO _filepath-cache-record will be created!).
#_____________________________________________________________________________
#
#	fn	_filerdn(_filepath)
#
#		Return re-processed root-dir-name of _filepath.
#			If _filepath=="" then no action occured and return "".
#			Function return result only if in _filepath present name field -
#				- otherwise its return "".
#			If some syntax error found in _filepath then function return ""
#				(and NO _filepath-cache-record will be created!).
#_____________________________________________________________________________
#
#	fn	_filerd(_filepath)
#
#		Return re-processed root-dir of _filepath.
#			If _filepath=="" then no action occured and return "".
#			If some syntax error found in _filepath then function return ""
#				(and NO _filepath-cache-record will be created!).
#_____________________________________________________________________________
#
#	fn	_filer(_filepath)
#
#		Return re-processed root of _filepath.
#			If _filepath=="" then no action occured and return "".
#			If some syntax error found in _filepath then function return ""
#				(and NO _filepath-cache-record will be created!).
#_____________________________________________________________________________
#
#	fn	_filed(_filepath)
#
#		Return re-processed dir of _filepath.
#			If _filepath=="" then no action occured and return "".
#			There is only one case when dir string can be =="" - when in
#				_filepath specified unmounted drive(MS-format) and from-
#				current-location address used(like Z:file.ext). In this
#				case no rootdir-cache-record will be created.
#			If some syntax error found in _filepath then function return ""
#				(and NO _filepath-cache-record will be created!).
#_____________________________________________________________________________
#	fn	_filene(_filepath)
#
#		Return re-processed name-ext of _filepath.
#			If _filepath=="" then no action occured and return "".
#			Function return result only if in _filepath present file-name(name
#				and/or extension) - otherwise its return "".
#			If some syntax error found in _filepath then function return ""
#				(and NO _filepath-cache-record will be created!).
#_____________________________________________________________________________
#
#	fn	_filen(_filepath)
#
#		Return re-processed name of _filepath.
#			If _filepath=="" then no action occured and return "".
#			Function return result only if in _filepath present name field -
#				- otherwise its return "".
#			If some syntax error found in _filepath then function return ""
#				(and NO _filepath-cache-record will be created!).
#_____________________________________________________________________________
#
#	fn	_file(_filepath)
#
#		Return re-processed ext of _filepath.
#			If _filepath=="" then no action occured and return "".
#			Function return result only if in _filepath present ext field -
#				- otherwise its return "".
#			If some syntax error found in _filepath then function return ""
#				(and NO _filepath-cache-record will be created!).
#___________________________________________________________________________________
#
#	fn	_dir(_ARR,_filepathmask)
#
#		Get file-/folder-list of root-folder of _filepathmask.
#			If _filepathmask=="" then no action occured and return "".
#			_filepathmask can contain symbols like `*' and `?' as like
#				its used in `dir'-shell command.
#			Function gets file-/folder-list of specified root-dir-_filepathmask
#				and return this list in array _ARR - where each element:
#
#			index - is the _filepath of file-or-folder name-ext
#			value - contains 3 fields separated by " ":
#				1. =="D" if this is folder
#				   ==/[0-9]+/ if this is file - size of file in bytes
#				2. ==date-of-creation of file or folder
#				3. ==time-of-creation of file or folder
#
#			Function returns quantity of items in ARR.
#___________________________________________________________________________________
#
#	fn	_filexist(_filepath)
#
#		Test if file or path or drive specified in _filepath is exist.
#				If _filepath=="" then no action occured and return "".
#				If some syntax error found in _filepath then function return ""
#			(and NO _filepath-cache-record will be created!).
#				Function returns _filepath if _filepath is exist. Otherwise
#			function return 0.
#_____________________________________________________________________________
#
#	fn	_filenotexist(_filepath)
#
#		Test if file or path or drive specified in _filepath is not exist.
#			If _filepath=="" then no action occured and return "".
#			If some syntax error found in _filepath then function return ""
#				(and NO _filepath-cache-record will be created!).
#			Function returns 1 if _filepath is not exist. Otherwise function
#				return 0.
#_____________________________________________________________________________
#
#	fn	_newdir(_filepath)
#
#		Create path specified in root-dir-_filepath.
#			If _filepath=="" then no action occured and return "".
#			If some syntax error found in _filepath then function return ""
#				(and NO _filepath-cache-record will be created!).
#			Function returns root-dir of _filepath.
#_______________________________________________________________________
#
#	fn	_newdir(_filepath)
#
#		Create path specified in root-dir-_filepath. If this folder
#		already exist then it will be completely cleared.
#			If _filepath=="" then no action occured and return "".
#			If some syntax error found in _filepath then function return ""
#				(and NO _filepath-cache-record will be created!).
#			Function returns root-dir of _filepath.
#___________________________________________________________________________________
#
#	fn	_getmpfile(_filepath,_currfilepath)
#
#		Return ....
#
#_____________________________________________________________________________
#
#	fn	_getmpdir(_filepath,_currfilepath)
#
#		Return ...
#
#_____________________________________________________________________________
#
#	Temporary files folder.
#
#		Temporary files folder location is defined by _FILEIO_TMPRD.
#		If it wasn't been initialized before program run or not been initialized
#			by ENVIRON["TMPDIR"] then it will defined as the:
#				`current rootdir(stored in _FILEIO_RD)\programname.TMP'
#			In this case if its already exist then it will completely cleared when _FILEIO
#			library initialization processed.
#			And at the program uninitialization processed it will completely
#			cleared if _FILEIO_TMPCLRFLAG is true.
#___________________________________________________________________________________
#
#	var	_FILEIO_RD (ENVIRON["CD"])
#
#		This var can be set before running program. It can contain path which
#		will be used as default current dir while program run.
#		If this var is set before program runs - then it will be refreshed by the
#			_filerd it will be used as default current dir while program run.
#		If this var is not set before program runs - then ENVIRON["CD"] can also
#			set up default current dir while program run. If it set before program
#			begin then it will be refreshed by the _filerd - and also writed into
#			_FILEIO_RD.
#		If both _FILEIO_RD and ENVIRON["CD"] are not set before program begins
#			then real current root\dir will be writed into both _FILEIO_RD and
#			ENVIRON["CD"] and it will be used as default current dir while program run.
#
#___________________________________________________________________________________
#
#	var	_FILEIO_TMPRD (ENVIRON["TMPRD"])
#
#		This var can be set before running program. It can contain path which
#		will be used as default temporary files root-folder while program run.
#		If this var is set before program runs - then it will be refreshed by the
#			_filerd - and also writed into ENVIRON["TMPRD"].
#		If this var is not set before program runs - then ENVIRON["TMPRD"] can also
#			set up default temporary files root-folder while program run. If it set
#			before program begin then it will be refreshed by the _filerd - and
#			also writed into _FILEIO_TMPRD.
#		If both _FILEIO_TMPRD and ENVIRON["TMPRD"] are not set before program begins
#			then new folder into path specified by the _FILEIO_RD(after its handling)
#			will be writed into both _FILEIO_TMPRD and ENVIRON["TMPRD"] and it
#			will be used as default temporary files root-folder while program run.
#___________________________________________________________________________________
#
#	var	_FILEPATH
#
#		This var contain filepath of working script. It should be setting up externally.
#
#	var	_gawk_scriptlevel
#___________________________________________________________________________________
####################################################################################
END{ ###############################################################################
      if ( _constatstrln>0 )		_constat() }

#_____________________________________________________________________________
func	_cmd(c, i,A) { #######################################################
      _fio_cmda=RS; RS=".{1,}"; _fio_cmdb=BINMODE; BINMODE="rw"; ERRNO=RT=_NUL
      c | getline RS; BINMODE=_fio_cmdb; RS=_fio_cmda
      if ( ERRNO || 0>_exitcode=close(c) )	return RT=_NOP
      return RT }


#_____________________________________________________________________________
func	_con(t,ts, a,b,c,d,i,r,A,B) { ##########################################
      d=RLENGTH
      if ( (c=split(r=t,A,/\x0D?\x0A/,B))>0 ) {
            a=BINMODE; b=ORS; BINMODE="rw"; ORS=""
            if ( c>1 ) {
                  if ( (i=length(t=_tabtospc(A[1],ts,_conlastrln)))<_constatstrln ) {
                        t=t _getchrln(" ",_constatstrln-i) }
                  print (t B[1]) > _SYS_STDCON
                  for ( i=2; i<c; i++ ) {
                        print (_tabtospc(A[i],ts) B[i]) > _SYS_STDCON }
                  print (_conlastr=_tabtospc(A[c],ts)) > _SYS_STDCON; fflush(_SYS_STDCON) }
            else {
                  print (t=_tabtospc(t,ts,_conlastrln))  > _SYS_STDCON; fflush(_SYS_STDCON)
                  _conlastr=_conlastr t }
            if ( (i=length(_conlastr))>=_CON_WIDTH ) {
                  _conlastr=substr(_conlastr,1+(int(i/_CON_WIDTH)*_CON_WIDTH)) }
            _conlastrln=length(_conlastr)
            if ( _constatstr ) {
                  print ((t=_constatgtstr(_constatstr,_CON_WIDTH-1-_conlastrln)) _CHR["CR"] _conlastr) > _SYS_STDCON; fflush(_SYS_STDCON)
                  _constatstrln=length(t) }
            BINMODE=a; ORS=b; RLENGTH=d; return r }
      RLENGTH=d }
#_______________________________________________________________________
func	_conl(t,ts) { ####################################################
      return _con(t (t~/\x0A$/ ? "" : _CHR["EOL"]),ts) }
#_______________________________________________________________________
func	_conline(t,ts) { #################################################
      return _con(_chrline(t,ts)) }
#_______________________________________________________________________
func	_constat(t,ts, ln,a) { ###########################################
      if ( _constatstrln>(ln=length(t=_constatgtstr(_constatstr=_tabtospc(t,ts),_CON_WIDTH-1-_conlastrln))) ) {
            t=t _getchrln(" ",_constatstrln-ln) }
      _constatstrln=ln
      ln=ORS; a=BINMODE; BINMODE="rw"; ORS=""
      print (t _CHR["CR"] _conlastr) > _SYS_STDCON; fflush(_SYS_STDCON)
      ORS=ln; BINMODE=a; return _constatstr }
#_________________________________________________________________
func	_constatgtstr(t,ln, a,b) {
      if ( ln<1 ) {
            return "" }
      if ( (a=length(t))<=ln ) {
            return t }
      if ( ln<11 ) {
            return substr(t,a-ln+1) }
      if ( ln<19 ) {
            return "..." substr(t,a-ln+4) }
      return substr(t,1,b=int((ln-3)/2)) "..." substr(t,a-ln+b+4) }
#_______________________________________________________________________
func	_constatpush(t,ts) { #############################################
      _CONSTATPUSH[++_CONSTATPUSH[0]]=_constatstr
      if ( t )	_constat(t,ts)
      return _constatstr }
#_______________________________________________________________________
func	_constatpop() { ##################################################
      if ( _CONSTATPUSH[0]>0 ) {
            return _constat(_CONSTATPUSH[_CONSTATPUSH[0]--]) }
      return _constat("") }
#_______________________________________________________________________
func	_conin(t, a,b) { #################################################
      _constatpush(); _constat(); a=BINMODE; b=RS; BINMODE="rw"; RS="\n"
      _con(t); getline t < "CON"; close("CON"); _conlastrln=0; _conlastr=""
      gsub(/[\x0D\x0A]+/,"",t)
      BINMODE=a; RS=b; _constatpop()
      return t }
#___________________________________________________________________________________
####################################################################################



func	_conlq(t,ts) {
      return _conl("`" t "'",ts) }








####################################################################################
# PUBLIC:
#_____________________________________________________________________________
#	var	_SYS_STDOUT			- (by default = "/dev/stdout") standart output pipe filename
#	var	_SYS_STDERR			- (by default = "/dev/stderr") standart error output pipe filename
#	var	_SYS_STDCON			- (by default = "CON") standart console output device
#_____________________________________________________________________________
#	var	_CHR["CR"]			- return cursor to the position 0 without newline(normally ="\x0D")
#	var	_CHR["EOL"]			- return cursor to the position 0 & newline (MS:="\x0D\x0A" / UX:="\x0D")
#	var	_CON_WIDTH 			- console width(columns number)
#_____________________________________________________________________________
#	fn	_cmd(c)			- execute shell command c and return output
#	fn	_err				- output string w\o any addition into _SYS_STDERR device
#	fn	_errnl			- output string with addition _CHR["EOL"] at the end of the string into _SYS_STDERR device
#	fn	_out				- output string w\o any addition into _SYS_STDOUT device
#	fn	_outnl			- output string with addition _CHR["EOL"] at the end of the string into _SYS_STDOUT device
#_____________________________________________________________________________
#	fn	_con(text[,tabspace])
#	fn	_conl(text[,tabspace])
#	fn	_conline(text[,tabspace])
#	fn	_constat(status[,tabspace])
#	fn	_constatpush([status[,tabspace]])
#	fn	_constatpop()
#_______________________________________________________________________
#	var	_constatstr
####################################################################################


func	_unstr(t)	{ return gensub(/\\(.)/,"\\1","G",t) }
#_____________________________________________________________________________
func	_gensubfn(t,r,f,p0, A) { ###############################################
      if ( match(t,r,A) ) return substr(t,1,RSTART-1) @f(_th0(substr(t,RSTART,RLENGTH),t=substr(t,RSTART+RLENGTH)),A,p0) _gensubfn(t,r,f,p0)
      return t }
#_____________________________________________________________________________
func	_rexpstr(r, i,c,A) { ###################################################
      c=split(r,A,""); r=""
      for ( i=1; i<=c; i++ )	r=r _REXPSTR[A[i]]
      return r }
#_____________________________________________________________________________
func	_hexnum(n,l) { #########################################################
      if ( l+0<1 )		l=2
      return sprintf("%." (l+0<1 ? 2 : l) "X",n) }
#_____________________________________________________________________________
func	_ln(t) { ###############################################################
      return t~/\x0A$/ ? t : (t _CHR["EOL"]) }
#_______________________________________________________________________
func	_getchrln(s,w) { #################################################
      if ( s=="" )			return
      #if ( w!=w+0 || w<0 )	w=_CON_WIDTH
      if ( length(s)<w )	{ if ( s in _GETCHRLN )		{ if ( length(_getchrlnt0=_GETCHRLN[s])>=w )	return substr(_getchrlnt0,1,w) }
                                                else	_getchrlnt0=s s
                              while ( length(_getchrlnt0)<w )	_getchrlnt0=_getchrlnt0 _getchrlnt0
                              _GETCHRLN[s]=_getchrlnt0;		return substr(_getchrlnt0,1,w) }
                        else	return substr(s,1,w) }
#_______________________________________________________________________
func	_chrline(t,ts,w,s) { #############################################
      return (t=" " _tabtospc(t,ts) (t ? t~/[ \t]$/ ? "" : " " : "")) _getchrln(s ? s : "_",(w ? w : _CON_WIDTH-1)-length(t)) _CHR["EOL"] }
#_______________________________________________________________________
func	_tabtospc(t,ts,xc, a,c,n,A,B) { ##################################
      if ( !ts ) {
            ts=_TAB_STEP_DEFAULT }
      c=split("." t,A,/\t+/,B); A[1]=substr(A[1],2); t=""
      for ( n=1; n<=c; n++ ) {
            t=t A[n] _getchrln(" ",(xc=length(B[n])*ts+int((a=xc+length(A[n]))/ts)*ts)-a) }
      return t }
#_________________________________________________________________
func	_lspctab(t,ts,l, l1,l2,A) { ################################
      while ( match(t,/^(\t*)( *)((\t*)(.*))$/,A) ) {
            if ( A[1,"length"]>=l )							return substr(t,l+1)
            if ( A[2] ) {
                  if ( (l1=int(A[2,"length"]/ts))>=(l2=l-A[1,"length"]) ) 	return substr(A[2],l2*ts+1) A[3]
                  if ( !A[4] )		return A[5]
                  t=A[1] _getchrln("\t",l1) A[3] }
            else	return t } }
#_______________________________________________________________________
func	_qstr(t, c,A,B) { ################################################
      c=""; for ( t=split(t,A,/[\x00-\x1F\\"]/,B); t>=0; t-- ) {
            c=_QSTR[B[t]] A[t+1] c }
      return c }
#_________________________________________________________________
func	_qstrq(t) { ################################################
      gsub(/\\/,"\\\\",t); gsub(/"/,"\\\"",t); return t }
#_______________________________________________________________________
func	_Zexparr(S,s, t,i) { ##############################################
      t=""; if ( isarray(S) ) {
            for ( i in S ) {
                  t=t (isarray(S[i]) ?				(_Zexparr_i1(i) "\x10" _Zexparr_i0(S[i]) "\x11\x11\x10"		) :				(_Zexparr_i2(_Zexparr_i3(i) "\x11" _Zexparr_i3(S[i])) "\x10"	) ) } }
      if ( s!="" ) {
            gsub(/\x1B/,"\x1B\x3B",s)
            gsub(/\x10/,"\x1B\x30",s)
            t=t "\x11\x11\x10" s }
      gsub(/\x0A/,"\x1B\x3A",t); return t }
#_________________________________________________________________
func	_Zexparr_i0(S, t,i) {
      for ( i in S ) {
            t=t (isarray(S[i]) ?			(_Zexparr_i1(i) "\x10" _Zexparr_i0(S[i]) "\x11\x11\x10"			) :			(_Zexparr_i2(_Zexparr_i3(i) "\x11" _Zexparr_i3(S[i])) "\x10"		) ) }
      return t }
#_________________________________________________________________
func	_Zexparr_i1(t) {
      gsub(/\x1B/,"\x1B\x3B",t); gsub(/\x11/,"\x1B\x31",t); gsub(/\x10/,"\x1B\x30",t)
      return t }
#_________________________________________________________________
func	_Zexparr_i2(t) {
      gsub(/\x10/,"\x1B\x30",t); return t }
#_________________________________________________________________
func	_Zexparr_i3(t) {
      gsub(/\x1B/,"\x1B\x3B",t); gsub(/\x11/,"\x1B\x31",t)
      return t }
#_______________________________________________________________________
func	_Zimparr(D,t, A,B) { ##############################################
      if ( isarray(D) ) {
            split(t,A,/\x10/,B)
            t=_Zimparr_i0(A,B,_Zimparr_i1(D,A,B,1))
            gsub(/\x1B\x30/,"\x10",t)
            gsub(/\x1B\x3B/,"\x1B",t)
            return t } }
#_________________________________________________________________
func	_Zimparr_i0(A,B,i) {
      return i in A ? (A[i] B[i] _Zimparr_i0(A,B,i+1)) : "" }
#_________________________________________________________________
func	_Zimparr_i1(D,A,B,i, t,a,n) {
      while ( i in B ) {
            if ( (t=A[i++])=="\x11\x11" )	return i
            gsub(/\x1B\x30/,"\x10",t)
            if ( (a=index(t,"\x11"))>0 ) {
                  if ( isarray(D[n=_Zimparr_i2(substr(t,1,a-1))]) ) {
                        delete D[n] }
                  D[n]=_Zimparr_i2(substr(t,a+1)) }
            else {
                  if ( !isarray(D[t=_Zimparr_i2(t)]) ) {
                        delete D[t]; D[t][""]; delete D[t][""] }
                  i=_Zimparr_i1(D[t],A,B,i) } } }
#_________________________________________________________________
func	_Zimparr_i2(t) {
      gsub(/\x1B\x31/,"\x11",t); gsub(/\x1B\x3B/,"\x1B",t)
      return t }
#___________________________________________________________________________________
####################################################################################




#_______________________________________________________________________
# _CHR array
#
#	_CHR[ASC-code decimal number]=="char"
#
#		Contains 256 elements. The index is the decimal number from 0-255.
#		The value is the single character with ASC-code equivalent to index number:
#
#			_CHR[97]		=="a"			- character with ASC-code 97 is `a'
#
#		This array is useful if you want to get character using it's ASC-code
#_________________________________________________________________
# _ASC array
#
#	_ASC[char]==number: ASC-code of char
#
#		Contains 256 elements. The index is the any single character with ASC-code \x00-\xFF.
#		The value is the number equivalent of character's ASC-code:
#
#			_ASC["A"]		==65			- ASC-code of character `A' is 65
#
#		This array is useful if you want to get ASC-code of the character.
#_________________________________________________________________
# _QASC array
#
#	_QASC[char]=="string: octal ASC-code of char in 3-digit octal format"
#
#		Contains 256 elements. The index is the any single charcter with ASC-code \x00-\xFF.
#		The value is the octal number equivalent of character's ASC-code in fixed-length - 3-digit - string:
#
#			_QASC["!"]		=="041"		- ASC-code of character `!' is 33(decimal) == 41(in octal)
#			_QASC["\x0D"]	=="015"
#
#		This array is useful when some type of string escape conversion is performed. It allows quickly get
#		replace string for the characters that can be specified only by character code in result string:
#
#			"\x0D"	->	"\\015"
#_______________________________________________________________________







####################################################################################
# PUBLIC:
#_____________________________________________________________________________
#	fn	_getchrln(ptt,len)
#_____________________________________________________________________________
#	fn	_tabtospc(src,tabstep,xcoord)
####################################################################################

#_____________________________________________________________________________
func	_retarr(A,i,p,a, q) { ##################################################
      if ( isarray(A) ) {
            i=i=="" ? 0 : i+0; q=A[_ARRLEN]+0
            if ( i<q )	return p					A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i]					A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i]					A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i]					A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i]					A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i]					A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i]					A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i]					A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] _retarr_i0(A,q,i,a)
                        } }

func	_retarr_i0(A,q,i,a) {
      if ( i<q )	return	A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i]				A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i]				A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i]				A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i]				A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i]				A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i]				A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i]				A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] _retarr_i0(A,q,i,a)
      while ( q<i ) delete A[++q]
      return a }
#_____________________________________________________
#	_retarr(ARRAY,start,prefixtr,postfixtr)
#		Return string collected from elements of ARRAY.
#		The data elements in ARRAY have numeric indexes. By default it starts from element with index 1, but it is possible to locate elements starting from
#		0,-1,-.... The last data element in the ARRAY have the highest numeric index that is stored in ARRAY[_ARRLEN].
#		Optimized for very large data size.
#
#			IN:		ARRAY			- source data array(is ARRAY is not array then return undefined)
#					start			- (optional) start index in ARRAY; if missed or have non-numeric value then start array index will be 1.
#					prefixst		- the string that will be inserted in the begin of generated return string
#					postfix		- the string that will be added at the end of generated return string
#			MOD:		-
#			OUT:		-
#			RETURN:	undefined		- if ARRAY is not array; if ARRAY is empty; if start is higher than ARRAY last element index
#					string		- collected string: prefixtr-arraydata-postfixtr
#_________________________________________________________________
func	_nretarr(A,i,v, r,q) { #####################################
      if ( (i=i=="" ? 1 : i+0)<=(q=A[_ARRLEN]) ) {
            if ( i<=(r=q-16) ) {
                  _ARRSTR=A[i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i]
                  while ( i<r )	_ARRSTR=_ARRSTR A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i]
                  _ARRSTR=_ARRSTR A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] v _retarr_i0(A,q,i)
                  return }
            _ARRSTR=A[i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] v _retarr_i0(A,q,i)
            return }
      _ARRSTR=v
      return }
#___________________________________________________________
func	_nretarrd(A,i,v, r,q) { ##############################
      if ( (i=i=="" ? 1 : i+0)<=(q=A[_ARRLEN]) ) {
            if ( i<=(r=q-16) ) {
                  _ARRSTR=A[i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i]
                  while ( i<r )	_ARRSTR=_ARRSTR A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i]
                  _ARRSTR=_ARRSTR A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] v _retarr_i0(A,q,i) }
            else	_ARRSTR=A[i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] A[++i] v _retarr_i0(A,q,i) }
      else	_ARRSTR=v
      delete A; A[""]; delete A[""] }
#_______________________________________________
BEGIN{	_ARRLEN		="\x1ALEN"
            _ARRPTR		="\x1APTR"
            _ARRSTR="" }
#_______________________________________________________________________
func	_movarr(D,S) { ###################################################
      delete D; D[""]; delete D[""]
      _addarr(D,S) }
#_________________________________________________________________
func	_addarr(D,S) { #############################################
      if ( isarray(S) )	_addarr_i0(D,S) }
#_____________________________________________________
func	_addarr_i0(D,S, i) {
      for ( i in S ) {
            if ( isarray(S[i]) ) {
                  delete D[i]; D[i][""]; delete D[i][""]; _addarr_i0(D[i],S[i]) }
            else {
                  delete D[i]; D[i]=S[i] } } }
#_______________________________________________________________________
func	_addarrmask(D,S,M) { #############################################
      for ( _addarrmaski0 in M )	{ if ( _addarrmaski0 in S )	{ if ( isarray(S[_addarrmaski0]) )	{ if ( !isarray(D[_addarrmaski0]) )	{ delete D[_addarrmaski0]; D[_addarrmaski0][""]; delete D[_addarrmaski0][""] }
                                                                                                      if ( isarray(M[_addarrmaski0]) )		{ _addarrmask(D[_addarrmaski0],S[_addarrmaski0],M[_addarrmaski0]) }
                                                                                                                                    else	{ _extarr_i0(D[_addarrmaski0],S[_addarrmaski0]) } }
                                                            else	{ if ( isarray(D[_addarrmaski0])	)	delete D[_addarrmaski0]
                                                                  D[_addarrmaski0]=S[_addarrmaski0] } }
                                                            else	delete D[_addarrmaski0] } }
#_______________________________________________________________________
func	_add(S,sf,D,df) { ################################################
      if ( sf in S ) {
            if ( isarray(S[sf]) ) {
                  if ( df in D ) {
                        if ( isarray(D[df]) )	return _extarr(D[df],S[sf])
                        delete D[df] }
                  D[df][""]; delete D[df][""]
                  return _extarr(D[df],S[sf]) }
            else {
                  if ( isarray(D[df]) )	delete D[df]
                  D[df]=D[df] S[sf] } } }
#_______________________________________________________________________
func	_ins(S,sf,D,df) { ################################################
      if ( sf in S ) {
            if ( isarray(S[sf]) ) {
                  if ( df in D ) {
                        if ( isarray(D[df]) )	return _extarr(D[df],S[sf])
                        delete D[df] }
                  D[df][""]; delete D[df][""]
                  return _extarr(D[df],S[sf]) }
            else {
                  if ( isarray(D[df]) )	delete D[df]
                  D[df]=S[sf] D[df] } } }
#_______________________________________________________________________
func	_cmparr(A0,A1,R, a,i) { ##########################################
      a=0; delete R
      for ( i in A0 ) {
                  if ( !(i in A1) ) {
                        a++; R[i]=0 }
            else	if ( A0[i]!=A1[i] ) {
                        a++; R[i]=2 } }
      for ( i in A1 ) {
            if ( !(i in A0) ) {
                  a++; R[i]=1 } }
      return a }
#_______________________________________________________________________
func	_deletepfx(A,f, B,le,i) { ########################################
      le=length(f)
      for ( i in A ) {
            if ( substr(toupper(i),1,le)==f ) {
                  B[i]=A[i]; delete A[i] } } }
#___________________________________________________________________________________
####################################################################################


#_______________________________________________________________________
func	_addlist(A,v) { ##################################################
      A[++A[0]]=v }











#_________________________________________________________________
func	_retarrd(A,v, i) { #########################################
      if ( 1 in A )	return		A[1]		A[2]		A[3]		A[4]		A[5]		A[6]		A[7]		A[8]					A[9]		A[10]		A[11]		A[12]		A[13]		A[14]		A[15]		A[16]					((i=17) in A ? _retarrd_i0(A,i) v : v)
      delete A; return v }
#_____________________________________________________
func	_retarrd_i0(A,i) {
      if ( i in A )	return		A[i++]	A[i++]	A[i++]	A[i++]	A[i++]	A[i++]	A[i++]	A[i++]					A[i++]	A[i++]	A[i++]	A[i++]	A[i++]	A[i++]	A[i++]	A[i++]					(i in A ? _retarrd_i0(A,i) : "")
      delete A }




#_________________________________________________________________
func	_lengthsort(i1, v1, i2, v2) { ##############################
      return length(i1)<length(i2) ? -1 : length(i1)>length(i2) ? 1 : i1<i2 ? -1 : 1 }


#_______________________________________________________________________
func	_dumparr(A,t,lv, a) { ############################################
      b=PROCINFO["sorted_in"]; PROCINFO["sorted_in"]="_lengthsort"
      if ( isarray(A) ) {
            delete _DUMPARR; _dumparrc=_dumparrd=""
            _dumparr_i1(A,lv=(lv=="" ? 16 : lv==0 || (lv+0)!=0 ? lv : lv=="-*" ? -3 : lv~/^\+?\*$/ ? 3 : 16)+0,lv<0 ? -1 : 1,0,_tabtospc(t))
            PROCINFO["sorted_in"]=a
            return _retarrd(_DUMPARR,_dumparrd, _dumparrd="") } }
#___________________________________________________________
func	_dumparr_i1(A,lv,ls,ln,t, t2,i,a,f) {
      t2=_getchrln(" ",length(t))
      if ( ln==lv )	{ if ( ls>0 )	for ( i in A )	++a
                                    else	for ( i in A )	isarray(A[i]) ? ++a : ""
                        if ( length(_dumparrd=_dumparrd t (a>0 ? " ... (x" a ")" : "") _CHR["EOL"])>262144 )		{ _DUMPARR[++_dumparrc]=_dumparrd; _dumparrd="" }
                        return }
      if ( ls>=0 )		for ( i in A )	if ( !isarray(A[i]) )	if ( length(_dumparrd=_dumparrd (f ? t2 : t _nop(f=1)) "[" i "]=" A[i] "'" _CHR["EOL"])>262144 )		{ _DUMPARR[++_dumparrc]=_dumparrd; _dumparrd="" }
      for ( i in A )	if ( isarray(A[i]) )	_dumparr_i1(A[i],lv,ls,ln+ls,_th0(f ? t2 : t,f=1) "[" i "]")
      if ( !f )	if ( length(_dumparrd=_dumparrd t _CHR["EOL"])>262144 )	{ _DUMPARR[++_dumparrc]=_dumparrd; _dumparrd="" } }
#_________________________________________________________________
func	_printarr(A,t,lv,r, a) { ####################################
      a=PROCINFO["sorted_in"]; PROCINFO["sorted_in"]="_lengthsort"; _printarrexp=r ? r : ""
      if ( isarray(A) ) {
            delete _DUMPARR; _dumparrc=_dumparrd=""
            _printarr_i1(A,lv=(lv=="" ? 16 : lv==0 || (lv+0)!=0 ? lv : lv=="-*" ? -3 : lv~/^\+?\*$/ ? 3 : 16)+0,lv<0 ? -1 : 1,0,_tabtospc(t))
            PROCINFO["sorted_in"]=a
            return _retarrd(_DUMPARR,_dumparrd, _dumparrd="") } }
#___________________________________________________________
func	_printarr_i1(A,lv,ls,ln,t, t2,i,a,f) {
      t2=_getchrln(" ",length(t))
      if ( ln==lv )	{ if ( ls>0 )	for ( i in A )	++a
                                    else	for ( i in A )	isarray(A[i]) ? ++a : ""
                        if ( length(_dumparrd=_dumparrd t (a>0 ? " ... (x" a ")" : "") _CHR["EOL"])>262144 )		{ _conl(_dumparrd); _dumparrd="" }
                        return }
      if ( ls>=0 )		for ( i in A )	if ( !_printarrexp || i~_printarrexp )	if ( !isarray(A[i]) )	if ( length(_dumparrd=_dumparrd (f ? t2 : t _nop(f=1)) "[" i "]=" A[i] "'" _CHR["EOL"])>262144 )		{ _conl(_dumparrd); _dumparrd="" }
      for ( i in A )	if ( isarray(A[i]) )	if ( !_printarrexp || i~_printarrexp )	_printarr_i1(A[i],lv,ls,ln+ls,_th0(f ? t2 : t,f=1) "[" i "]")
      if ( !f )	if ( length(_dumparrd=_dumparrd t _CHR["EOL"])>262144 )	{ _conl(_dumparrd); _dumparrd="" } }
















      
####################################################################################

#_____________________________________________________________________________
func	_th0(p,p1,p2,p3) { return p } ##########################################
#_________________________________________________________________
func	_th1(p0,p,p2,p3) { return p } ##############################
#_________________________________________________________________
func	_th2(p0,p1,r,p3) { return p } ##############################
#_________________________________________________________________
func	_th3(p0,p1,p2,r) { return p } ##############################
#_________________________________________________________________
func	_th10(p0,p1) { return p1 p0 } ##############################
#_______________________________________________________________________
func	_nop(p0,p1,p2,p3) { } ############################################
#_______________________________________________________________________
func	_bearray(A) { ####################################################
      if ( isarray(A) || (A==0 && A=="") )	return 1 }
#_______________________________________________________________________
func	_setarrsort(f, a) { ##############################################
      a=PROCINFO["sorted_in"]
      if ( !f )	delete 	PROCINFO["sorted_in"]
            else	PROCINFO["sorted_in"]=f
      return a }
#_________________________________________________________________
func	cmp_str_idx(i1, v1, i2, v2) { ##############################
      return i1 < i2 ? -1 : 1 }
#___________________________________________________________
func	ncmp_str_idx(i1, v1, i2, v2) { #######################
      return i1 < i2 ? 1 : -1 }
#_______________________________________________________________________
func	_exit(c) { #######################################################
      exit c }
#_______________________________________________________________________
func	_fn(f,p0,p1,p2) { ################################################
      if ( f in FUNCTAB )		return @f(p0,p1,p2) }
#_______________________________________________________________________
func	_defn(f,c,v) { ###################################################
      FUNCTAB[c f]=v }
#_______________________________________________________________________
func	_delay(t, a) { ###################################################
      for ( a=1; a<=t; a++ ) {
            _delayms() } }
#_________________________________________________________________
func	_delayms( a) { #############################################
      for ( a=1; a<=_delay_perfmsdelay; a++ ) { } }
#_______________________________________________________________________
func	_getdate() { #####################################################
      return strftime("%F") }
#_________________________________________________________________
func	_getime() { ################################################
      return strftime("%H:%M:%S") }
#_________________________________________________________________
func	_getsecond() { #############################################
      return systime() }
#___________________________________________________________
func	_getsecondsync( a,c,b,c2) { ##########################
      a=systime()
      while ( a==systime() ) { ++c }
      return a+1 }
#_______________________________________________________________________
func	_getperf(o,t, a) { ###############################################
      o=="" ? ++_getperf_opcurr : _getperf_opcurr=o
      if ( (a=_getsecond())!=_getperf_last ) {
            _getperf_opsec=(_getperf_opcurr-_getperf_opstart)/((_getperf_last=a)-_getperf_start)
            return @_getperf_fn(o,t,a) }
      return 1 }
#_____________________________________________________
BEGIN{
      _getperf_fn="_nop" }
#___________________________________________________________
func	_getperf_noenot(o,t,a)		{ return 1 }
#___________________________________________________________
func	_getperf_noe(o,t,a) {
      if ( _getperf_opsecp!=_getperf_opsec )	{ _constat((_constatstr==_getperf_stat ? _getperf_statstr : (_getperf_statstr=_constatstr)) t " [TIME=" (a-_getperf_start) " sec(" (_getperf_opsecp=_getperf_opsec) " ops/sec)]"); _getperf_stat=_constatstr }
      return 1 }
#___________________________________________________________
func	_getperf_not(o,t,a) {
      if ( a<_getperf_end )	return 1 }
#___________________________________________________________
func	_getperf_(o,t,a) {
      if ( a>=_getperf_end )	return 0
      if ( _getperf_opsecp!=_getperf_opsec )	{ _constat((_constatstr==_getperf_stat ? _getperf_statstr : (_getperf_statstr=_constatstr)) t " [TIME=" (a-_getperf_start) " sec(" (_getperf_opsecp=_getperf_opsec) " ops/sec)]"); _getperf_stat=_constatstr }
      return 1 }
#_________________________________________________________________
func	_igetperf(t,s,o) { #########################################	# t-test period in seconds(==0 ? no period; s(=true/false)-output/not output status; o-qnt of ops before test start
      if ( t==0 && t=="" && s==0 && s=="" && o==0 && o=="" ) {
            if ( _getperf_fn!~/not$/ && _constatstr==_getperf_stat )	_constat(_getperf_statstr)
            _getperf_fn="_nop"
            return "[TIME=" (_getperf_last-_getperf_start) " sec(" _getperf_opsec " ops/sec)]" }
      _conl("initiate _getperf")
      _getperf_opstart=_getperf_opcurr=o+0; _getperf_opsec=_getperf_opsecp=_getperf_stat=_getperf_statstr=""
      _getperf_end=t+(_getperf_start=_getperf_last=_getsecondsync())
      _getperf_fn=(t+0>0 ? "_getperf_" : "_getperf_noe") (s ? "" : "not")
      return _getperf_start }

#___________________________________________________________________________________
####################################################################################


#_______________________________________________________________________
func	_addf(A,f) { #####################################################
      A["B"][""]=A["F"][A["B"][f]=A["B"][""]]=f }
#_________________________________________________________________
func	_insf(A,f) { ###############################################
      A["F"][""]=A["B"][A["F"][f]=A["F"][""]]=f }
#_________________________________________________________________
func	_delf(A,f) { ###############################################
      A["B"][A["F"][A["B"][f]]=A["F"][f]]=A["B"][f]
      delete A["F"][f]; delete A["B"][f] }
#_______________________________________________________________________
func	_pass(A,f,t,p2, i,a) { ###########################################
      a=_endpass_v0; _endpass_v0=""; i=1
      while ( t && i )	{ i=""; while ( (i=A[i]) && (t==(t=@i(f,t,p2))) ) { } }
      if ( i && _endpass_v0 )	{ A["!"]=1; t=_endpass_v0 }
                        else	delete A["!"]
      _endpass_v0=a; return t }
#_________________________________________________________________
func	_endpass(t)		{ _endpass_v0=t } ########################
#_________________________________________________________________
func	_inspass(A,f)	{ A[f]=A[""]; A[""]=f } ##################
#_______________________________________________________________________
func	_fframe(A,t,p) { #################################################
      return _fframe_i0(A,t,p,A[""]) }
#___________________________________________________________
func	_fframe_i0(A,t,p,f) {
      return f ? (@f(t,p) _fframe_i0(A,t,p,A[f])) : "" }
#_________________________________________________________________
func	_bframe(A,t,p) { ###########################################
      return _bframe_i0(A,t,p,A[""]) }
#___________________________________________________________
func	_bframe_i0(A,t,p,f) {
      return f ? (_bframe_i0(A,t,p,A[f]) @f(t,p)) : "" }
#_________________________________________________________________
func	_insframe(A,f) { ###########################################
      A[f]=A[""]; A[""]=f }
#_______________________________________________________________________
########################################################################









func	_fthru(A,c,p, B) {
      return _fthru_i0(A,c,p,B,A[""]) }
#_________________________________________________________________
func	_fthru_i0(A,c,p,B,f) {
      return f ? @f(c,_fthru_i0(A,c,p,B,A[f]),B) : "" }











#_______________________________________________________________________
########################################################################
#EXPERIMENTAL

func	_rexpfn(R,t,p) {
      _REXPFN[""]=""
      while ( t ) {
            t=_rxpfn(R,t,p) }
      return _REXPFN[""] }

func	_rxpfn(R,t,p, i,f,A) {
      for ( i in R ) {
            if ( match(t,i,A) ) {
                  f=R[i]; if ( t!=(t=@f(A,substr(t,RLENGTH+1),p)) ) return t } }
      return _rexpfnend(t) }
                        
func	_rexpfnend(t) {
      _REXPFN[""]=t }


func	_ffaccr(A,t,p,P) {
      return _faccr_i0(A["F"],t,p,P) }

func	_fbaccr(A,t,p,P) {
      return _faccr_i0(A["B"],t,p,P) }

func	_faccr_i0(A,t,p,P, f,r) {
      f=r=""
      if ( isarray(A) ) {
            while ( (f=A[f]) )	r=r @f(t,p,P) }
      return r }

func	_ffaccl(A,t,p,P) {
      return _faccl_i0(A["F"],t,p,P) }

func	_fbaccl(A,t,p,P) {
      return _faccl_i0(A["B"],t,p,P) }

func	_faccl_i0(A,t,p,P, f,r) {
      f=r=""
      if ( isarray(A) ) {
            while ( (f=A[f]) )	r=@f(t,p,P) r }
      return r }


func	_Foreach(A,f, p0, i) {
      for ( i in A ) @f(A,i,p0) }
#_______________________________________________________________________
func	_foreach(A,f,r,p0,p1,p2, i,p) { ####################################
      if ( isarray(A) ) {
            _TMP0[p=_n()]["."]=1
            _foreach_i0(A,f,_TMP0[p],p0,p1,p2)
            return _th0(_retarr(_TMP0[p]),_tdel(p)) }
      if ( _isptr(A) ) {
            _TMP0[p=_n()][_ARRLEN]=1
            _tframe4("_foreach_i1" (r ? "~" r : ""),A,f,_TMP0[p],p0,p1)
            return _th0(_retarr(_TMP0[p]),_tdel(p)) } }
      #_____________________________________________________
      func	_foreach_i0(A,f,D,p0,p1,p2) {
            for ( i in A ) {
                  if ( isarray(A[i]) )		_foreach_i0(A[i],f,D,p0,p1,p2)
                                    else	_gen(D,@f(A[i],p0,p1,p2)) } }
      #_____________________________________________________
      func	_foreach_i1(p,f,D,p0,p1,p2) {
            
            _gen(D,@f(p,p0,p1,p2)) }

BEGIN{
      _datablock_length		=262144 }

func	_gen(D,t) {
      if ( length(D[D[_ARRLEN]]=D[D["."]] t)>_datablock_length ) {
            D[++D[_ARRLEN]]="" } }


































####################################################################################
# PUBLIC:
#_____________________________________________________________________________
#	fn	_th0,_th1,_th2,_th3
#		USAGE:
#			_th0(p1,p2,p3,p4)
#
#			Each of this functions can have up to 4 parameters.
#				_th0(p1,p2,p3,p4) return 1st parameter (p1)
#				_th1(p1,p2,p3,p4) return 2nd parameter (p2)
#				_th2(p1,p2,p3,p4) return 3rd parameter (p3)
#				_th3(p1,p2,p3,p4) return 4th parameter (p4)
#_____________________________________________________________________________
#	fn	_nop(p1,p2,p3,p4,p5,p6,p7,p8)
#		USAGE:
#			_nop()
#
#			Does not do any action. No result returned. Up to 8 parameters.
#_____________________________________________________________________________
#	fn	_exit(c)
#		USAGE:
#			_exit(code)
#
#			This function do the same as GAWK-operator `exit code'.
#_____________________________________________________________________________
#	fn	_getdate()
#	fn	_getime()
#	fn	_getsecond()
#	fn	_getsecondsync()
func	_rdreg(D,p)	{ ################################################################
      _rdregp0="reg query \"" p "\" /S /reg:64 2>NUL"; _rdregfld=_rdregkey=0
      _rdregq0=split(gensub(/[\x0D?\x0A]{2,}/,_CHR["EOL"],"G",_cmd(_rdregp0)),_RDREGA0,/\x0D?\x0A/)
      while ( _rdregq0>0 )		_rdreg_i0(D)
      return _rdregfld+_rdregkey }
      #___________________________________________________________
      func	_rdreg_i0(D, A) { while ( _rdregq0>0 ){
                                    if ( match(_rdregp0=_RDREGA0[_rdregq0--],/    (.*)    REG_((SZ)|(DWORD)|(QWORD)|(BINARY)|(EXPAND_SZ)|(MULTI_SZ))    (.*)$/,A) ) {
                                          if ( !_rdreg_i0(D) )		{ ++_rdregfld; D[_rdregp0 A[1] "." _RDREGTYPE[A[2]]]=A[9]; return } else	break }
                                    else	if ( _rdregp0~/^HK/ )		{ ++_rdregkey; return D[_rdregp0=_rdregp0 "\\"] } } return 1 }
      #_____________________________________________________
      BEGIN	{ _initrdreg() }
            func	_initrdreg() {	_RDREGTYPE["SZ"]		="STR"
                                    _RDREGTYPE["DWORD"]	="W32"
                                    _RDREGTYPE["QWORD"]	="W64"
                                    _RDREGTYPE["BINARY"]	="BIN"
                                    _RDREGTYPE["EXPAND_SZ"]	="XSZ"
                                    _RDREGTYPE["MULTI_SZ"]	="MSZ"
                                    _RDrdregfld=_rdregkey=0 }

# _rdregfld		: gvar	- number of readed registry fields by _rdreg()
# _rdregkey		: gvar	- number of readed registry keys by _rdreg()
#_____________________________________________________________________________
func	_regpath0(D,i, s,q,S) { ############################################ 0 #
      if ( i=_patharr0(S,i) ) {
            if ( "name" in S )	D["name"]=S["name"]; if ( "ext" in S )	D["ext"]=S["ext"]
            s=(toupper(s=i in S ? S[i] : "") in _REGPATH0REGDIR ? D[++q]=_REGPATH0REGDIR[toupper(s)] : (D[++q]=_REGPATH0REGDIR[""]) "\\" (D[++q]=s)) "\\"
            while ( ++i in S )		s=s (D[++q]=S[i]) "\\"
            if ( s!="" )	D[0]=s; IGNORECASE=1
            D["hostdir"]="\\\\" (D["host"]="host" in S && ((""==i=S["host"]) || "."==i || "?"==i || "localhost"==i) ? ENVIRON["COMPUTERNAME"] : i) "\\" s; IGNORECASE=0 } }
      #_____________________________________________________
      BEGIN	{ _initregpath0() }
            func	_initregpath0() {	_REGPATH0REGDIR[""]				="HKEY_LOCAL_MACHINE"
                                    _REGPATH0REGDIR["HKLM"]				="HKEY_LOCAL_MACHINE"
                                    _REGPATH0REGDIR["HKEY_LOCAL_MACHINE"]	="HKEY_LOCAL_MACHINE"
                                    _REGPATH0REGDIR["HKCR"]				="HKEY_CLASSES_ROOT"
                                    _REGPATH0REGDIR["HKEY_CLASSES_ROOT"]	="HKEY_CLASSES_ROOT"
                                    _REGPATH0REGDIR["HKCU"]				="HKEY_CURRENT_USER"
                                    _REGPATH0REGDIR["HKEY_CURRENT_USER"]	="HKEY_CURRENT_USER"
                                    _REGPATH0REGDIR["HKU"]				="HKEY_USERS"
                                    _REGPATH0REGDIR["HKEY_USERS"]			="HKEY_USERS"
                                    _REGPATH0REGDIR["HKCC"]				="HKEY_CURRENT_CONFIG"
                                    _REGPATH0REGDIR["HKEY_CURRENT_CONFIG"]	="HKEY_CURRENT_CONFIG"
                                    _REGPATH0REGDIR["HKPD"]				="HKEY_PERFORMANCE_DATA"
                                    _REGPATH0REGDIR["HKEY_PERFORMANCE_DATA"]	="HKEY_PERFORMANCE_DATA" }
#_________________________________________________________________________________________
##########################################################################################





















func	_getreg_i1(D,r,R, a,i,il,ir,rc,B) {
      a=IGNORECASE; IGNORECASE=1; r="^" _torexp(r); rc=0
      zs=""
      for ( i in R )	{ if ( match(i,r,B) )	{ il=B[_torexp_pfxcntr]; ir=gensub(/....$/,"",1,substr(i,1+B[_torexp_pfxcntr,"length"]))
                                                if ( !gsub(/^\\/,"",ir) && match(il,/[^\\]+$/) )	ir=substr(il,RSTART) ir
                                                D[ir]=R[i]; rc++ } }
      IGNORECASE=a; if ( rc>0 )	return rc }
#_________________________________________________________________________________________
func	_rrdreg(DD,p, k,t,v,c,i,q,tT,A,B,C,D) { #############################################	old; regedit
      if ( !_registrytmpfile )		_registryinit()
      _cmd("regedit /E \"" _registrytmpfile "\" \"" p "\" 2>&1")
      q=patsplit(gensub(/[\x00\xFF\xFE]+/,"","G",_rdfile(_registrytmpfile)),A,/\x0D?\x0A\[[^\]]+\]\x0D?\x0A/,B)
      for ( i=1; i<=q; i++ )	{ p=gensub(/(^[ \t\x0D\x0A]*\[)|((\\)\\+)|(\][ \t\x0D\x0A]*$)/,"\\3","G",A[i]); DD[p "\\"]; delete C[split(B[i],C,/[\x0D\x0A]+/)]
                              for ( c=1; c in C; c++ )	{ tt=tt C[c]; if ( gsub(/\\$/,"",tt) )		continue
                                                            if ( tt=="" )	continue
                                                            if ( match(_th0(tt,tt=""),/((^"(([^\\"]|\\.)*)")|(@))=(("(([^\\"]|\\.)*)")|(dword:([[:xdigit:]]{8}))|(hex(\(([27b])\))?:(.*)))$/,D) ) {
                                                            if ( D[7] )			{ t="STR"; v=_unstr(D[8]) }
                                                            else	if ( D[10] )		{ t="W32"; v=D[11] }
                                                            else	{ v=D[15]
                                                                  if ( D[13] )	{ switch ( D[14] ) {
                                                                                          case "2":	t="XSZ"; break
                                                                                          case "7":	t="MSZ"; break
                                                                                          default:	t="W64" } }
                                                                              else	t="BIN" }
                                                      DD[gensub(/(\\)\\+/,"\\1","G",p "\\" _unstr(D[3] (D[5] ? "(Default)" : "")) "." t)]=v }
                                                else	_fatal("regedit: unknown output format(" c "): `" C[c] "'") } } }
      #_____________________________________________________
      func	_registryinit()	{ _registrytmpfile=_getmpfile() }
#_____________________________________________________________________________
# _rdreg(ARRAY,reg_path)
#		Import into ARRAY the content of the whole registree tree with the higher point specified by reg_path.
#		ARRAY will be filled by the strings with following format:
#
# HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\GnuWin32\CoreUtils\5.3.0\pck\InstallPath.STR=C:\Program Files (x86)\GnuWin32
#	where:
# HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\GnuWin32\CoreUtils\5.3.0\pck									<- REG KEY PATH
#											     InstallPath							<- DATA FIELD
#													     STR						<- TYPE
#														   C:\Program Files (x86)\GnuWin32	<- VALUE
# TYPE:
#	STR		- REG_SZ		(String Value)
#	W32		- REG_DWORD		(DWORD (32-bit) Value)
#	W64		- REG_QWORD		(QWORD (64-bit) Value)
#	BIN		- REG_BINARY	(Binary Value)
#	XSZ		- REG_EXPAND_SZ	(Expandable String Value)
#	MSZ		- REG_MULTI_SZ	(Multi-String Value)
#_________________________________________________________________________________________




# HKCR		HKEY_CLASSES_ROOT
# HKCU		HKEY_CURRENT_USER
# HKLM		HKEY_LOCAL_MACHINE
# HKU			HKEY_USERS
# HKCC		HKEY_CURRENT_CONFIG
# HKPD		HKEY_PERFORMANCE_DATA












































#___________________________________________________________________________________
####################################################################################























func	_sysinfo(D,h) { ##############################################################
      h="wmic /NODE: \"" h "\" OS 2>NUL"
      if ( split(_cmd(h),_SYSINFOA0,/[\x0D\x0A]+/)==3 ) {
            _sysinfol0=length(h=_SYSINFOA0[2])+1; _sysinfoq0=_sysinfoq1=split(_SYSINFOA0[1],_SYSINFOA0,/ +/,_SYSINFOB0)
            while ( --_sysinfoq0>0 )			D[_sysinfof0]=gensub(/^ +| +$/,"","G",substr(h,_sysinfol0=_sysinfol0-(_sysinfol1=length(_sysinfof0=_SYSINFOA0[_sysinfoq0])+length(_SYSINFOB0[_sysinfoq0])),_sysinfol1))
            return _sysinfoq1-1 } }
#_____________________________________________________________________________
func	zzer()	{ ################################################################
      }
      #_____________________________________________________
      BEGIN	{ _initsys() }
            func	_initsys() { }
#_________________________________________________________________________________________
##########################################################################################







#BootDevice               BuildNumber  BuildType            Caption                                      CodeSet  CountryCode  CreationClassName      CSCreationClassName   CSDVersion      CSName  CurrentTimeZone  DataExecutionPrevention_32BitApplications  DataExecutionPrevention_Available  DataExecutionPrevention_Drivers  DataExecutionPrevention_SupportPolicy  Debug  Description  Distributed  EncryptionLevel  ForegroundApplicationBoost  FreePhysicalMemory  FreeSpaceInPagingFiles  FreeVirtualMemory  InstallDate                LargeSystemCache  LastBootUpTime             LocalDateTime              Locale  Manufacturer           MaxNumberOfProcesses  MaxProcessMemorySize  MUILanguages  Name                                                                                  NumberOfLicensedUsers  NumberOfProcesses  NumberOfUsers  OperatingSystemSKU  Organization  OSArchitecture  OSLanguage  OSProductSuite  OSType  OtherTypeDescription  PAEEnabled  PlusProductID  PlusVersionNumber  Primary  ProductType  RegisteredUser  SerialNumber             ServicePackMajorVersion  ServicePackMinorVersion  SizeStoredInPagingFiles  Status  SuiteMask  SystemDevice             SystemDirectory      SystemDrive  TotalSwapSpaceSize  TotalVirtualMemorySize  TotalVisibleMemorySize  Version   WindowsDirectory
#\Device\HarddiskVolume1  7601         Multiprocessor Free  Microsoft Windows Server 2008 R2 Enterprise  1252     1            Win32_OperatingSystem  Win32_ComputerSystem  Service Pack 1  CPU     180              TRUE                                       TRUE                               TRUE                             3                                      FALSE               FALSE        256              0                           6925316             33518716                41134632           20110502192745.000000+180                    20130426120425.497469+180  20130510134606.932000+180  0409    Microsoft Corporation  -1                    8589934464            {"en-US"}     Microsoft Windows Server 2008 R2 Enterprise |C:\Windows|\Device\Harddisk0\Partition2  0                      116                2              10                                64-bit          1033        274             18                                                                          TRUE     3            Windows User    55041-507-2389175-84833  1                        0                        33554432                 OK      274        \Device\HarddiskVolume2  C:\Windows\system32  C:                               50311020                16758448                6.1.7601  C:\Windows













BEGIN { ############################################################################

      a=ENVIRON["EGAWK_CMDLINE"]; gsub(/^[ \t]*/,"",a)
      a=_lib_CMDLN(a)
      if ( (a!="") && (!_LIBAPI["F"]["!"]) )	{ _out(_lib_HELP()); _fatal("Bad comandline argument `" a "'") }
      gsub(/^[ \t]*/,"",a); ENVIRON["EGAWK_CMDLINE"]=a
      _lib_APPLY(); if ( _basexit_fl )	exit
            _INIT()
            _START()
            _END() }
#___________________________________________________________________________________
func	_INITBASE() { ################################################################

      _egawk_utilpath			=ENVIRON["EGAWK_PATH"] "BIN\\UTIL\\" }
#___________________________________________________________________________________
####################################################################################







# make sure that stdout contain only expected characters
# make sure that stderr contain only expected characters
# redesign & reformat keys and its outputs
# try different key combinations
# add lib-specified to all libs
      
