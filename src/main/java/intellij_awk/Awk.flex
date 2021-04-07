// Copyright 2000-2020 JetBrains s.r.o. and other contributors. Use of this source code is governed by the Apache 2.0 license that can be found in the LICENSE file.
package intellij_awk;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import intellij_awk.psi.AwkTypes;
import com.intellij.psi.TokenType;
import com.intellij.lang.Language;

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

Identifier = [:jletter:][:jletterdigit:]*

/* int literals */

DecLiteral = 0 | [1-9][0-9]*

// TODO posix doesn't support oct
OctLiteral    = 0+ {OctDigit}*
OctDigit          = [0-7]

/* float literals */

FloatLiteral  = {FLit1}|{FLit2}|{FLit3}|{FLit4}

FLit1 = [0-9]+ \. [0-9]* {Exponent}?
FLit2 = \. [0-9]+ {Exponent}?
FLit3 = [0-9]+ {Exponent}
FLit4 = [0-9]+ {Exponent}?

Exponent = [eE] [+\-]? [0-9]+


//%state WAITING_VALUE

%%

{END_OF_LINE_COMMENT}                       { return AwkTypes.COMMENT; }
{CRLF}({CRLF}|{WHITE_SPACE})+               { return TokenType.WHITE_SPACE; }
({CRLF}|{WHITE_SPACE})+                     { return TokenType.WHITE_SPACE; }

{STRING}    { return new IElementType("STRING", Language.ANY); }
{DecLiteral} |
{OctLiteral} |
{FloatLiteral}
	 { return new IElementType("NUMBER", Language.ANY); }

[^]                                         { return TokenType.BAD_CHARACTER; }
