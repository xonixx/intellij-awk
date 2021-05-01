package intellij_awk;

import com.intellij.lexer.Lexer;
import com.intellij.openapi.editor.DefaultLanguageHighlighterColors;
import com.intellij.openapi.editor.HighlighterColors;
import com.intellij.openapi.editor.colors.TextAttributesKey;
import com.intellij.openapi.fileTypes.SyntaxHighlighterBase;
import com.intellij.psi.TokenType;
import com.intellij.psi.tree.IElementType;
import com.intellij.psi.tree.TokenSet;
import intellij_awk.psi.AwkTypes;
import org.jetbrains.annotations.NotNull;

import static com.intellij.openapi.editor.colors.TextAttributesKey.createTextAttributesKey;

public class AwkSyntaxHighlighter extends SyntaxHighlighterBase {

  public static final TokenSet KEYWORDS =
      TokenSet.create(
          AwkTypes.FUNCTION,
          AwkTypes.BEGIN,
          AwkTypes.END,
          AwkTypes.NEXT,
          AwkTypes.WHILE,
          AwkTypes.FOR,
          AwkTypes.WHILE,
          AwkTypes.DO,
          AwkTypes.DELETE,
          AwkTypes.IF,
          AwkTypes.IN,
          AwkTypes.ELSE,
          AwkTypes.PRINT,
          AwkTypes.PRINTF,
          AwkTypes.GETLINE,
          AwkTypes.RETURN,
          AwkTypes.BREAK,
          AwkTypes.CONTINUE,
          AwkTypes.EXIT);

  public static final TokenSet OPERATORS =
      TokenSet.create(
          AwkTypes.ADD_ASSIGN,
          AwkTypes.SUB_ASSIGN,
          AwkTypes.MUL_ASSIGN,
          AwkTypes.DIV_ASSIGN,
          AwkTypes.MOD_ASSIGN,
          AwkTypes.POW_ASSIGN,
          AwkTypes.OR,
          AwkTypes.AND,
          AwkTypes.NO_MATCH,
          AwkTypes.EQ,
          AwkTypes.LE,
          AwkTypes.GE,
          AwkTypes.NE,
          AwkTypes.INCR,
          AwkTypes.DECR,
          AwkTypes.LT,
          AwkTypes.GT,
          AwkTypes.ADD,
          AwkTypes.SUB,
          AwkTypes.MUL,
          AwkTypes.DIV,
          AwkTypes.MOD,
          AwkTypes.POW,
          AwkTypes.MATCH,
          AwkTypes.NOT,
          AwkTypes.ASSIGN);

  public static final TokenSet BRACES_SET = TokenSet.create(AwkTypes.LBRACE, AwkTypes.RBRACE);
  public static final TokenSet BRACKETS_SET = TokenSet.create(AwkTypes.LBRACKET, AwkTypes.RBRACKET);
  public static final TokenSet PARENTHESES_SET = TokenSet.create(AwkTypes.LPAREN, AwkTypes.RPAREN);

  public static final TextAttributesKey COMMA =
      createTextAttributesKey("AWK_COMMA", DefaultLanguageHighlighterColors.COMMA);
  public static final TextAttributesKey SEMICOLON =
      createTextAttributesKey("AWK_SEMICOLON", DefaultLanguageHighlighterColors.SEMICOLON);
  public static final TextAttributesKey OPERATION_SIGN =
      createTextAttributesKey(
          "AWK_OPERATION_SIGN", DefaultLanguageHighlighterColors.OPERATION_SIGN);

  public static final TextAttributesKey BRACES =
      createTextAttributesKey("AWK_BRACES", DefaultLanguageHighlighterColors.BRACES);
  public static final TextAttributesKey BRACKETS =
      createTextAttributesKey("AWK_BRACKETS", DefaultLanguageHighlighterColors.BRACKETS);
  public static final TextAttributesKey PARENTHESES =
      createTextAttributesKey("AWK_PARENTHESES", DefaultLanguageHighlighterColors.PARENTHESES);

  public static final TextAttributesKey SPECIAL_VARIABLE =
      createTextAttributesKey("AWK_SPECIAL_VARIABLE", DefaultLanguageHighlighterColors.CONSTANT);

  public static final TextAttributesKey KEYWORD =
      createTextAttributesKey("AWK_KEYWORD", DefaultLanguageHighlighterColors.KEYWORD);
  public static final TextAttributesKey NUMBER =
      createTextAttributesKey("AWK_NUMBER", DefaultLanguageHighlighterColors.NUMBER);
  public static final TextAttributesKey STRING =
      createTextAttributesKey("AWK_STRING", DefaultLanguageHighlighterColors.STRING);
  public static final TextAttributesKey COMMENT =
      createTextAttributesKey("AWK_COMMENT", DefaultLanguageHighlighterColors.LINE_COMMENT);
  public static final TextAttributesKey BAD_CHARACTER =
      createTextAttributesKey("AWK_BAD_CHARACTER", HighlighterColors.BAD_CHARACTER);

  private static final TextAttributesKey[] BAD_CHAR_KEYS = new TextAttributesKey[] {BAD_CHARACTER};

  private static final TextAttributesKey[] COMMA_KEYS = new TextAttributesKey[] {COMMA};
  private static final TextAttributesKey[] SEMICOLON_KEYS = new TextAttributesKey[] {SEMICOLON};
  private static final TextAttributesKey[] OPERATION_SIGN_KEYS =
      new TextAttributesKey[] {OPERATION_SIGN};

  private static final TextAttributesKey[] BRACES_KEYS = new TextAttributesKey[] {BRACES};
  private static final TextAttributesKey[] BRACKETS_KEYS = new TextAttributesKey[] {BRACKETS};
  private static final TextAttributesKey[] PARENTHESES_KEYS = new TextAttributesKey[] {PARENTHESES};

  private static final TextAttributesKey[] SPECIAL_VARIABLE_KEYS =
      new TextAttributesKey[] {SPECIAL_VARIABLE};

  private static final TextAttributesKey[] KEYWORD_KEYS = new TextAttributesKey[] {KEYWORD};
  private static final TextAttributesKey[] STRING_KEYS = new TextAttributesKey[] {STRING};
  private static final TextAttributesKey[] NUMBER_KEYS = new TextAttributesKey[] {NUMBER};
  private static final TextAttributesKey[] COMMENT_KEYS = new TextAttributesKey[] {COMMENT};
  private static final TextAttributesKey[] EMPTY_KEYS = new TextAttributesKey[0];

  @NotNull
  @Override
  public Lexer getHighlightingLexer() {
    return new AwkLexerAdapter();
  }

  @NotNull
  @Override
  public TextAttributesKey[] getTokenHighlights(IElementType tokenType) {
    if (KEYWORDS.contains(tokenType)) {
      return KEYWORD_KEYS;
    } else if (BRACES_SET.contains(tokenType)) {
      return BRACES_KEYS;
    } else if (BRACKETS_SET.contains(tokenType)) {
      return BRACKETS_KEYS;
    } else if (PARENTHESES_SET.contains(tokenType)) {
      return PARENTHESES_KEYS;
    } else if (OPERATORS.contains(tokenType)) {
      return OPERATION_SIGN_KEYS;
    } else if (tokenType.equals(AwkTypes.STRING) || tokenType.equals(AwkTypes.ERE)) {
      return STRING_KEYS;
    } else if (tokenType.equals(AwkTypes.NUMBER)) {
      return NUMBER_KEYS;
    } else if (tokenType.equals(AwkTypes.COMMENT)) {
      return COMMENT_KEYS;
    } else if (tokenType.equals(AwkTypes.COMMA)) {
      return COMMA_KEYS;
    } else if (tokenType.equals(AwkTypes.SEMICOLON)) {
      return SEMICOLON_KEYS;
    } else if (tokenType.equals(AwkTypes.SPECIAL_VAR_NAME)) {
      return SPECIAL_VARIABLE_KEYS;
    } else if (tokenType.equals(TokenType.BAD_CHARACTER)) {
      return BAD_CHAR_KEYS;
    }
    return EMPTY_KEYS;
  }
}
