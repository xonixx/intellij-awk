package intellij_awk;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;

import static com.intellij.psi.TokenType.BAD_CHARACTER;
import static com.intellij.psi.TokenType.WHITE_SPACE;
import static intellij_awk.psi.AwkTypes.*;

%%

%{
  public AwkLexer() {
    this((java.io.Reader)null);
  }
%}

%public
%class AwkLexer
%implements FlexLexer
%function advance
%type IElementType
%unicode

EOL=\R

COMMENT=#.* | (\\\n)
BUILTIN_FUNC_NAME=atan2|cos|sin|exp|log|sqrt|int|rand|srand|gsub|index|length|match|split|sprintf|sub|substr|tolower|toupper|close|system
BUILTIN_FUNC_NAME_GAWK=asort|asorti|gensub|patsplit|strtonum|mktime|strftime|systime|and|compl|lshift|or|rshift|xor|isarray|typeof|bindtextdomain|dcgettext|dcngettext
NUMBER=( \d+ | (\d* \. \d+) | (\d+ \. \d*) ) ([eE] [+-]? \d+)?
STRING=([\"]([^\"\\]|\\.)*[\"])
ERE="/"((\[\^?\/)|[^\\\n/]|(\\[^\n]))*"/"
TYPED_ERE=@{ERE}
NEWLINE=\r\n|\n
NS_PART=[a-zA-Z_]+[a-zA-Z_\d]*::
SPECIAL_VAR_NAME      = {NS_PART}? (ARGC|ARGV|CONVFMT|ENVIRON|FILENAME|FNR|FS|NF|NR|OFMT|OFS|ORS|RLENGTH|RS|RSTART|SUBSEP)
SPECIAL_VAR_NAME_GAWK = {NS_PART}? (BINMODE|FIELDWIDTHS|FPAT|IGNORECASE|LINT|PREC|ROUNDMODE|TEXTDOMAIN|ARGIND|ERRNO|FUNCTAB|PROCINFO|RT|SYMTAB)
VAR_NAME              = {NS_PART}? [a-zA-Z_]+[a-zA-Z_\d]*
//LIVEPREVIEWWS=[ \t]*(\\\n)*
WHITE_SPACE=[ \t]+

%state AFTER_BEGIN_END

%%
// In AWK the '{' should go on the same line with BEGIN/END
<AFTER_BEGIN_END> {
  {WHITE_SPACE}            { return WHITE_SPACE; }
  "{"                      { yybegin(YYINITIAL); return LBRACE; }
}

<YYINITIAL> {
  {WHITE_SPACE}            { return WHITE_SPACE; }

  "BEGINFILE" /\(?         { yybegin(AFTER_BEGIN_END); return BEGINFILE; }
  "ENDFILE"   /\(?         { yybegin(AFTER_BEGIN_END); return ENDFILE; }
  "BEGIN"     /\(?         { yybegin(AFTER_BEGIN_END); return BEGIN; }
  "END"       /\(?         { yybegin(AFTER_BEGIN_END); return END; }
  "break"     /\(?         { return BREAK; }
  "continue"  /\(?         { return CONTINUE; }
  "delete"    /\(?         { return DELETE; }
  "do"        /\(?         { return DO; }
  "else"      /\(?         { return ELSE; }
  "exit"      /\(?         { return EXIT; }
  "for"       /\(?         { return FOR; }
  "function"  /\(?         { return FUNCTION; }
  "func"      /\(?         { return FUNCTION; }
  "if"        /\(?         { return IF; }
  "in"        /\(?         { return IN; }
  "nextfile"  /\(?         { return NEXTFILE; }
  "next"      /\(?         { return NEXT; }
  "print"     /\(?         { return PRINT; }
  "printf"    /\(?         { return PRINTF; }
  "return"    /\(?         { return RETURN; }
  "while"     /\(?         { return WHILE; }
  "switch"    /\(?         { return SWITCH; }
  "case"                   { return CASE; }
  "default"                { return DEFAULT; }
  "getline"   /\(?         { return GETLINE; }
  "namespace"              { return NAMESPACE; }
  "include"                { return INCLUDE; }
  "load"                   { return LOAD; }
  "+="                     { return ADD_ASSIGN; }
  "-="                     { return SUB_ASSIGN; }
  "*="                     { return MUL_ASSIGN; }
  "/="                     { return DIV_ASSIGN; }
  "%="                     { return MOD_ASSIGN; }
  "^="                     { return POW_ASSIGN; }
  "||"                     { return OR; }
  "&&"                     { return AND; }
  "!~"                     { return NO_MATCH; }
  "=="                     { return EQ; }
  "<="                     { return LE; }
  ">="                     { return GE; }
  "!="                     { return NE; }
  "++"                     { return INCR; }
  "--"                     { return DECR; }
  ">>"                     { return APPEND; }
  "$"                      { return DOLLAR; }
  "["                      { return LBRACKET; }
  "]"                      { return RBRACKET; }
  "{"                      { return LBRACE; }
  "}"                      { return RBRACE; }
  "("                      { return LPAREN; }
  ")"                      { return RPAREN; }
  ","                      { return COMMA; }
  ";"                      { return SEMICOLON; }
  "<"                      { return LT; }
  ">"                      { return GT; }
  "+"                      { return ADD; }
  "-"                      { return SUB; }
  "*"                      { return MUL; }
  "/"                      { return DIV; }
  "%"                      { return MOD; }
  "^"                      { return POW; }
  "~"                      { return MATCH; }
  "|&"                     { return PIPE_AMP; }
  "|"                      { return PIPE; }
  "!"                      { return NOT; }
  "?"                      { return QUESTION; }
  ":"                      { return COLON; }
  "="                      { return ASSIGN; }
  "@"                      { return AT; }

  {COMMENT}                     { return COMMENT; }
  {NUMBER}                      { return NUMBER; }
  {STRING}                      { return STRING; }
  {TYPED_ERE}                   { return TYPED_ERE; }
  {ERE}                         { return ERE; }
  {NEWLINE}                     { return NEWLINE; }
  {BUILTIN_FUNC_NAME}      /\(? { return BUILTIN_FUNC_NAME; }
  {BUILTIN_FUNC_NAME_GAWK} /\(? { return BUILTIN_FUNC_NAME_GAWK; }
  {VAR_NAME}               /\(  { return FUNC_NAME; }
  {SPECIAL_VAR_NAME}            { return SPECIAL_VAR_NAME; }
  {SPECIAL_VAR_NAME_GAWK}       { return SPECIAL_VAR_NAME_GAWK; }
  {VAR_NAME}                    { return VAR_NAME; }
//  {LIVEPREVIEWWS}          { return LIVEPREVIEWWS; }

}

[^] { return BAD_CHARACTER; }
