package intellij_awk;

import java.util.regex.Pattern;

public final class Util {
  private static final Pattern lcLetterFirst = Pattern.compile("^[a-z]");
  private static final Pattern ucLetterFirst = Pattern.compile("^[A-Z]");
  private static final Pattern spacesRegex = Pattern.compile("\\s+");

  public static boolean startsWithLowercaseLetter(String string) {
    return lcLetterFirst.matcher(string).find();
  }

  public static boolean startsWithUppercaseLetter(String string) {
    return ucLetterFirst.matcher(string).find();
  }

  public static String ucFirst(String str) {
    if (str == null) return null;
    if (str.length() == 0) return str;
    return str.substring(0, 1).toUpperCase() + str.substring(1);
  }
  public static String lcFirst(String str) {
    if (str == null) return null;
    if (str.length() == 0) return str;
    return str.substring(0, 1).toLowerCase() + str.substring(1);
  }

  /** 'aaa_bbb' -> 'AaaBbb' */
  public static String lowerUnderscoreToCamelCase(String str) {
    if (str == null) return null;
    String[] parts = str.split("_");
    for (int i = 0; i < parts.length; i++) {
      parts[i] = ucFirst(parts[i]);
    }
    return String.join("", parts);
  }

  /** 'aaa BBBB cc' -> 'aaaBbbbCc' */
  public static String stringToCamelCase(String str) {
    if (str == null) return null;
    String[] parts = spacesRegex.split(str);
    for (int i = 0; i < parts.length; i++) {
      String part = parts[i].toLowerCase();
      parts[i] = i == 0 ? part : ucFirst(part);
    }
    return String.join("", parts);
  }
}
