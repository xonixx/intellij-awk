package intellij_awk;

import com.intellij.codeInsight.completion.*;
import com.intellij.codeInsight.lookup.LookupElementBuilder;
import com.intellij.util.ProcessingContext;
import intellij_awk.psi.AwkExpr;
import intellij_awk.psi.impl.AwkFunctionNameImpl;
import org.jetbrains.annotations.NotNull;

import java.util.List;

import static com.intellij.patterns.PlatformPatterns.psiElement;
import static intellij_awk.AwkUtil.insertHandler;

public class AwkCompletionContributorFunctions extends CompletionContributor {

  private static final String[] builtInFunctions =
      new String[] {
        "atan2", "cos", "sin", "exp", "log", "sqrt", "int", "rand", "srand", "gsub", "index",
        "length", "match", "split", "sprintf", "sub", "substr", "tolower", "toupper", "close",
        "system"
      };

  public AwkCompletionContributorFunctions() {
    extend(
        CompletionType.BASIC,
        psiElement().inside(AwkExpr.class),
        new CompletionProvider<>() {
          public void addCompletions(
              @NotNull CompletionParameters parameters,
              @NotNull ProcessingContext context,
              @NotNull CompletionResultSet resultSet) {

            List<AwkFunctionNameImpl> functionNames =
                AwkUtil.findFunctions(parameters.getOriginalFile());

            for (String standardFunction : builtInFunctions) {
              addFunctionCompletionCandidate(resultSet, standardFunction, true, "()");
            }
            for (AwkFunctionNameImpl functionName : functionNames) {
              addFunctionCompletionCandidate(
                  resultSet,
                  functionName.getName(),
                  false,
                  functionName.getSignatureString());
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
