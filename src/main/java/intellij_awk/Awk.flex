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
//WHITE_SPACE=\s+

COMMENT=#.*
BUILTIN_FUNC_NAME=atan2|cos|sin|exp|log|sqrt|int|rand|srand|gsub|index|length|match|split|sprintf|sub|substr|tolower|toupper|close|system
NUMBER=[0-9]+(\.[0-9]+)?([eE][+-][0-9]+)?
STRING=([\"]([^\"\\]|\\.)*[\"])
ERE="/"([^\\\n]|\\[^\n])*"/"
NEWLINE=\r\n|\n
FUNC_NAME=[a-zA-Z_]+[a-zA-Z_\d]*
VAR_NAME=[a-zA-Z_]+[a-zA-Z_\d]*
//LIVEPREVIEWWS=[ \t]*(\\\n)*
WHITE_SPACE=[ \t]+ | (\\\n)

%%
<YYINITIAL> {
  {WHITE_SPACE}            { return WHITE_SPACE; }

  "BEGIN"                  { return BEGIN; }
  "END"                    { return END; }
  "break"                  { return BREAK; }
  "continue"               { return CONTINUE; }
  "delete"                 { return DELETE; }
  "do"                     { return DO; }
  "else"                   { return ELSE; }
  "exit"                   { return EXIT; }
  "for"                    { return FOR; }
  "function"               { return FUNCTION; }
  "if"                     { return IF; }
  "in"                     { return IN; }
  "next"                   { return NEXT; }
  "print"                  { return PRINT; }
  "printf"                 { return PRINTF; }
  "return"                 { return RETURN; }
  "while"                  { return WHILE; }
  "getline"                { return GETLINE; }
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

  {COMMENT}                { return COMMENT; }
  {BUILTIN_FUNC_NAME}      { return BUILTIN_FUNC_NAME; }
  {NUMBER}                 { return NUMBER; }
  {STRING}                 { return STRING; }
  {ERE}                    { return ERE; }
  {NEWLINE}                { return NEWLINE; }
  {FUNC_NAME}/\(           { return FUNC_NAME; }
  {VAR_NAME}               { return VAR_NAME; }
//  {LIVEPREVIEWWS}          { return LIVEPREVIEWWS; }

}

[^] { return BAD_CHARACTER; }
