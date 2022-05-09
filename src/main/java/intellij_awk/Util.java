package intellij_awk;

import java.util.regex.Pattern;

public final class Util {
  private static final Pattern lcLetterFirst = Pattern.compile("^[a-z]");
  private static final Pattern ucLetterFirst = Pattern.compile("^[A-Z]");

  public static boolean startsWithLowercaseLetter(String string) {
    return lcLetterFirst.matcher(string).find();
  }

  public static boolean startsWithUppercaseLetter(String string) {
    return ucLetterFirst.matcher(string).find();
  }
}
