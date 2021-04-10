package intellij_awk;

import com.intellij.lexer.FlexAdapter;

public class AwkLexerAdapter extends FlexAdapter {

  public AwkLexerAdapter() {
    super(new AwkLexer(null));
  }
}
