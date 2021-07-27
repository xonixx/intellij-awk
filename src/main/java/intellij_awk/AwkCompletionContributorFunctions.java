package intellij_awk;

import com.intellij.codeInsight.completion.*;
import com.intellij.codeInsight.lookup.LookupElementBuilder;
import com.intellij.util.ProcessingContext;
import intellij_awk.psi.AwkExpr;
import intellij_awk.psi.impl.AwkFunctionNameImpl;
import org.jetbrains.annotations.NotNull;

import java.util.List;
import java.util.Map;

import static com.intellij.patterns.PlatformPatterns.psiElement;
import static intellij_awk.AwkUtil.insertHandler;
import static java.util.Map.entry;

public class AwkCompletionContributorFunctions extends CompletionContributor {

  private static final Map<String, String> builtInFunctions =
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

  private static final Map<String, String> gawkFunctions =
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

  public AwkCompletionContributorFunctions() {
    extend(
        CompletionType.BASIC,
        psiElement().inside(AwkExpr.class),
        new CompletionProvider<>() {
          public void addCompletions(
              @NotNull CompletionParameters parameters,
              @NotNull ProcessingContext context,
              @NotNull CompletionResultSet resultSet) {

            for (Map.Entry<String, String> standardFunction : builtInFunctions.entrySet()) {
              addFunctionCompletionCandidate(
                  resultSet, standardFunction.getKey(), true, standardFunction.getValue());
            }
            for (Map.Entry<String, String> standardFunction : gawkFunctions.entrySet()) {
              addFunctionCompletionCandidate(
                  resultSet, standardFunction.getKey(), true, standardFunction.getValue());
            }

            List<AwkFunctionNameImpl> functionNames =
                AwkUtil.findFunctions(parameters.getOriginalFile().getProject());

            for (AwkFunctionNameImpl functionName : functionNames) {
              addFunctionCompletionCandidate(
                  resultSet, functionName.getName(), false, functionName.getSignatureString());
            }
          }

          private void addFunctionCompletionCandidate(
              @NotNull CompletionResultSet resultSet,
              String fName,
              boolean isBuiltIn,
              String tailText) {
            resultSet.addElement(
                LookupElementBuilder.create(fName)
                    .withTailText(tailText)
                    .withIcon(AwkIcons.FUNCTION)
                    .withBoldness(isBuiltIn)
                    .withInsertHandler(insertHandler("()", 1)));
          }
        });
  }
}
