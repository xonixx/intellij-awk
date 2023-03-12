package intellij_awk;

import static com.intellij.patterns.PlatformPatterns.psiElement;
import static com.intellij.patterns.StandardPatterns.*;
import static intellij_awk.AwkUtil.insertHandler;

import com.intellij.codeInsight.completion.*;
import com.intellij.codeInsight.lookup.LookupElementBuilder;
import com.intellij.patterns.PsiElementPattern;
import com.intellij.psi.PsiElement;
import com.intellij.util.ProcessingContext;
import intellij_awk.psi.AwkExpr;
import intellij_awk.psi.AwkPrintExpr;
import intellij_awk.psi.AwkTypes;
import intellij_awk.psi.impl.AwkFunctionNameImpl;
import java.util.List;
import java.util.Map;
import org.jetbrains.annotations.NotNull;

public class AwkCompletionContributorFunctions extends AwkCompletionContributorBase {

  private static final PsiElementPattern.Capture<PsiElement> FOLLOWED_BY_LPAREN =
      psiElement().beforeLeaf(psiElement(AwkTypes.LPAREN));

  private static final String dummyIdentifier =
      CompletionInitializationContext.DUMMY_IDENTIFIER_TRIMMED;

  @Override
  public void beforeCompletion(@NotNull CompletionInitializationContext context) {
    /*
     By default, `DUMMY_IDENTIFIER` is used which is "IntellijIdeaRulezzz ".
     This causes problem for completion for the case `tolow<caret>()` because during completion this will try to parse
     as `tolowIntellijIdeaRulezzz ()`. But in awk the space not allowed in function call before `()`.
     This will cause it erroneous parsing to tokens only, not to PSI tree.
    */
    context.setDummyIdentifier(dummyIdentifier);
  }

  public AwkCompletionContributorFunctions() {
    extend(
        CompletionType.BASIC,
        notInsideERE(
            or(psiElement().inside(AwkExpr.class), psiElement().inside(AwkPrintExpr.class))),
        new CompletionProvider<>() {
          public void addCompletions(
              @NotNull CompletionParameters parameters,
              @NotNull ProcessingContext context,
              @NotNull CompletionResultSet resultSet) {

            resultSet = adjustPrefix(resultSet, parameters);

            for (Map.Entry<String, String> standardFunction :
                AwkFunctions.builtInFunctions.entrySet()) {
              addFunctionCompletionCandidate(
                  parameters,
                  resultSet,
                  standardFunction.getKey(),
                  true,
                  standardFunction.getValue());
            }
            for (Map.Entry<String, String> standardFunction :
                AwkFunctions.gawkFunctions.entrySet()) {
              addFunctionCompletionCandidate(
                  parameters,
                  resultSet,
                  standardFunction.getKey(),
                  true,
                  standardFunction.getValue());
            }

            List<AwkFunctionNameImpl> functionNames =
                AwkUtil.findFunctions(parameters.getOriginalFile().getProject());

            for (AwkFunctionNameImpl functionName : functionNames) {
              addFunctionCompletionCandidate(
                  parameters,
                  resultSet,
                  functionName.getName(),
                  false,
                  functionName.getSignatureString());
            }
          }

          private void addFunctionCompletionCandidate(
              @NotNull CompletionParameters parameters,
              @NotNull CompletionResultSet resultSet,
              String fName,
              boolean isBuiltIn,
              String tailText) {
            PsiElement position = parameters.getPosition();
            boolean followedByLparen = FOLLOWED_BY_LPAREN.accepts(position);
            boolean isInsideString = INSIDE_STRING.accepts(position);
            if (isInsideString && isBuiltIn) {
              return;
            }
            String[] parts = position.getText().split(dummyIdentifier);
            boolean hasTextBeforeLparen = parts.length == 2 && parts[1].length() > 0;
            resultSet.addElement(
                LookupElementBuilder.create(fName)
                    .withTailText(tailText)
                    .withIcon(AwkIcons.FUNCTION)
                    .withBoldness(isBuiltIn)
                    .withInsertHandler(
                        isInsideString
                            ? null
                            : followedByLparen
                                ? (hasTextBeforeLparen
                                    ? insertHandler(
                                        insertHandler("", 1),
                                        insertHandler("();", 3)) // aaa<caret>bbb()
                                    : insertHandler("", 1)) // aaa<caret>()
                                : insertHandler("()", 1))); // aaa<caret>
          }
        });
  }
}
