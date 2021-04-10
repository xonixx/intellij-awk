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
          AwkTypes.IF,
          AwkTypes.ELSE,
          AwkTypes.PRINT,
          AwkTypes.PRINTF,
          AwkTypes.GETLINE,
          AwkTypes.RETURN,
          AwkTypes.BREAK,
          AwkTypes.CONTINUE,
          AwkTypes.EXIT);

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
    } else if (tokenType.equals(AwkTypes.STRING)) {
      return STRING_KEYS;
    } else if (tokenType.equals(AwkTypes.NUMBER)) {
      return NUMBER_KEYS;
    } else if (tokenType.equals(AwkTypes.COMMENT)) {
      return COMMENT_KEYS;
    } else if (tokenType.equals(TokenType.BAD_CHARACTER)) {
      return BAD_CHAR_KEYS;
    }
    return EMPTY_KEYS;
  }
}
