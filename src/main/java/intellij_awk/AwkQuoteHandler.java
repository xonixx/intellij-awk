package intellij_awk;

import com.intellij.codeInsight.editorActions.SimpleTokenSetQuoteHandler;
import com.intellij.psi.TokenType;

public class AwkQuoteHandler extends SimpleTokenSetQuoteHandler {
  public AwkQuoteHandler() {
    super(TokenType.BAD_CHARACTER);
  }
}
