package intellij_awk;

import com.intellij.lang.BracePair;
import com.intellij.lang.PairedBraceMatcher;
import com.intellij.psi.PsiFile;
import com.intellij.psi.tree.IElementType;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import static intellij_awk.psi.AwkTypes.*;

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
    return true;
  }

  @Override
  public int getCodeConstructStart(PsiFile file, int openingBraceOffset) {
    return openingBraceOffset;
  }
}
