package intellij_awk;

import com.intellij.lang.Language;

public class AwkLanguage extends Language {

  public static final AwkLanguage INSTANCE = new AwkLanguage();

  private AwkLanguage() {
    super("AWK");
  }
}
