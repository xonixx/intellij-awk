// Copyright 2000-2020 JetBrains s.r.o. and other contributors. Use of this source code is governed by the Apache 2.0 license that can be found in the LICENSE file.
package intellij_awk;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import intellij_awk.psi.AwkTypes;
import com.intellij.psi.TokenType;

%%

%class AwkLexer
%implements FlexLexer
%unicode
%function advance
%type IElementType
%eof{  return;
%eof}

CRLF=\R
WHITE_SPACE=[\ \n\t\f]
END_OF_LINE_COMMENT=("#")[^\r\n]*

STRING=\"([^\"\r\n\\]|\\.)*\"

/* identifiers */

ConstantIdentifier = {SimpleConstantIdentifier}
SimpleConstantIdentifier = [#A-Z0-9_]+

Identifier = [:jletter:][:jletterdigit:]*

TypeIdentifier = {SimpleTypeIdentifier}
SimpleTypeIdentifier = [A-Z][:jletterdigit:]*

/* int literals */

DecLiteral = 0 | [1-9][0-9]* {IntegerSuffix}

HexLiteral    = 0 [xX] 0* {HexDigit}* {IntegerSuffix}
HexDigit      = [0-9a-fA-F]

OctLiteral    = 0+ {OctDigit}* {IntegerSuffix}
OctDigit          = [0-7]

IntegerSuffix = [uU]? [lL]? [uU]?

/* float literals */

FloatLiteral  = ({FLit1}|{FLit2}|{FLit3}|{FLit4}) ([fF]|[dD])?

FLit1 = [0-9]+ \. [0-9]* {Exponent}?
FLit2 = \. [0-9]+ {Exponent}?
FLit3 = [0-9]+ {Exponent}
FLit4 = [0-9]+ {Exponent}?

Exponent = [eE] [+\-]? [0-9]+


%state WAITING_VALUE

%%

{END_OF_LINE_COMMENT}                       { yybegin(YYINITIAL); return AwkTypes.COMMENT; }
{CRLF}({CRLF}|{WHITE_SPACE})+               { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }
({CRLF}|{WHITE_SPACE})+                     { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

[^]                                         { return TokenType.BAD_CHARACTER; }
