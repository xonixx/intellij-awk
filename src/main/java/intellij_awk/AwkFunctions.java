package intellij_awk;

import java.util.*;

import static java.util.Map.entry;

public final class AwkFunctions {
  static final Map<String, String> builtInFunctions =
      Map.ofEntries(
          entry("atan2", "(y, x)"),
          entry("cos", "(x)"),
          entry("sin", "(x)"),
          entry("exp", "(x)"),
          entry("log", "(x)"),
          entry("sqrt", "(x)"),
          entry("int", "(x)"),
          entry("rand", "()"),
          entry("srand", "([x])"),
          entry("gsub", "(regexp, replacement [, target])"),
          entry("index", "(in, find)"),
          entry("length", "([string])"),
          entry("match", "(string, regexp [, array])"),
          entry("split", "(string, array [, fieldsep [, seps ] ])"),
          entry("sprintf", "(format, expression1, …)"),
          entry("sub", "(regexp, replacement [, target])"),
          entry("substr", "(string, start [, length ])"),
          entry("tolower", "(string)"),
          entry("toupper", "(string)"),
          entry("close", "(filename [, how])"),
          entry("fflush", "([filename])"),
          entry("system", "(command)"));

  static final Map<String, String> gawkFunctions =
      Map.ofEntries(
          entry("asort", "(source [, dest [, how ] ])"),
          entry("asorti", "(source [, dest [, how ] ])"),
          entry("gensub", "(regexp, replacement, how [, target])"),
          entry("patsplit", "(string, array [, fieldpat [, seps ] ])"),
          entry("strtonum", "(str)"),
          entry("mktime", "(datespec [, utc-flag ])"),
          entry("strftime", "([format [, timestamp [, utc-flag] ] ])"),
          entry("systime", "()"),
          entry("and", "(v1, v2 [, …])"),
          entry("compl", "(val)"),
          entry("lshift", "(val, count)"),
          entry("or", "(v1, v2 [, …])"),
          entry("rshift", "(val, count)"),
          entry("xor", "(v1, v2 [, …])"),
          entry("isarray", "(x)"),
          entry("typeof", "(x)"),
          entry("bindtextdomain", "(directory [, domain])"),
          entry("dcgettext", "(string [, domain [, category] ])"),
          entry("dcngettext", "(string1, string2, number [, domain [, category] ])"));

  private static final Map<String, ParametersHint> parameterHintsCache = new HashMap<>();

  static ParametersHint resolveParameterHints(String funcName) {
    Objects.requireNonNull(funcName, "funcName should be set");

    ParametersHint hints = parameterHintsCache.get(funcName);
    if (hints != null) {
      return hints;
    }

    String signature = builtInFunctions.get(funcName);
    if (signature == null) {
      signature = gawkFunctions.get(funcName);
    }
    if (signature == null) {
      throw new IllegalArgumentException("Not a built-in function: " + funcName);
    }
    parameterHintsCache.put(funcName, hints = parseToHints(signature));
    return hints;
  }

  private static ParametersHint parseToHints(String signature) {
    final String signatureNoSpaceNoParensNoCloseBrackets;
    {
      final String signatureNoParens = signature.replaceAll("[()]", "");
      final String signatureNoSpaceNoParens = signatureNoParens.replaceAll("\\s", "");
      signatureNoSpaceNoParensNoCloseBrackets = signatureNoSpaceNoParens.replace("]", "");
    }
    final Integer optionalsStarting;
    if (!signatureNoSpaceNoParensNoCloseBrackets.contains("[")) {
      optionalsStarting = null;
    } else if (signatureNoSpaceNoParensNoCloseBrackets.charAt(0) == '[') {
      optionalsStarting = 0;
    } else {
      int lBracketFirstPos = signatureNoSpaceNoParensNoCloseBrackets.indexOf('[');
      String mandatoryParams =
          signatureNoSpaceNoParensNoCloseBrackets.substring(0, lBracketFirstPos);
      optionalsStarting = mandatoryParams.split(",").length;
    }
    return new ParametersHint(
        List.of(signatureNoSpaceNoParensNoCloseBrackets.split("\\[?,")), optionalsStarting);
  }

  static class ParametersHint {
    final List<String> parameterNames;
    final Integer optionalsStarting;

    public ParametersHint(List<String> parameterNames, Integer optionalsStarting) {
      this.parameterNames = parameterNames;
      this.optionalsStarting = optionalsStarting;
    }
  }
}
