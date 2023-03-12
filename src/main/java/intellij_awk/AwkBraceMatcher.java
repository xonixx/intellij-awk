package intellij_awk;

import static intellij_awk.psi.AwkTypes.*;

import com.intellij.lang.BracePair;
import com.intellij.lang.PairedBraceMatcher;
import com.intellij.psi.PsiFile;
import com.intellij.psi.TokenType;
import com.intellij.psi.tree.IElementType;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public class AwkBraceMatcher implements PairedBraceMatcher {

  private static final BracePair[] PAIRS =
      new BracePair[] {
        new BracePair(LBRACE, RBRACE, true), // same as in Java
        new BracePair(LBRACKET, RBRACKET, false),
        new BracePair(LPAREN, RPAREN, false)
      };

  @Override
  public BracePair @NotNull [] getPairs() {
    return PAIRS;
  }

  @Override
  public boolean isPairedBracesAllowedBeforeType(
      @NotNull IElementType lbraceType, @Nullable IElementType contextType) {
    return TokenType.WHITE_SPACE == contextType
        || RBRACE == contextType
        || RBRACKET == contextType
        || RPAREN == contextType
        || NEWLINE == contextType
        || SEMICOLON == contextType;
  }

  @Override
  public int getCodeConstructStart(PsiFile file, int openingBraceOffset) {
    return openingBraceOffset;
  }
}
