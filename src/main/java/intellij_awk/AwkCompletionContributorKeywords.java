package intellij_awk;

import static com.intellij.patterns.PlatformPatterns.psiElement;
import static com.intellij.patterns.StandardPatterns.or;
import static intellij_awk.AwkUtil.insertHandler;

import com.intellij.codeInsight.completion.*;
import com.intellij.codeInsight.lookup.LookupElement;
import com.intellij.codeInsight.lookup.LookupElementBuilder;
import com.intellij.util.ProcessingContext;
import intellij_awk.psi.*;
import java.util.Map;
import org.jetbrains.annotations.NotNull;

public class AwkCompletionContributorKeywords extends AwkCompletionContributorBase {

  public static final InsertHandler<LookupElement> ihBeginEnd = insertHandler(" {}", 2);

  private static final Map<String, InsertHandler<LookupElement>> KEYWORDS0 =
      Map.of(
          "function",
          insertHandler(" ", 1),
          "BEGIN",
          ihBeginEnd,
          "END",
          ihBeginEnd,
          "BEGINFILE",
          ihBeginEnd,
          "ENDFILE",
          ihBeginEnd);

  private static final InsertHandler<LookupElement> ihParens = insertHandler(" ()", 2);
  private static final InsertHandler<LookupElement> ihSpace = insertHandler(" ", 1);
  private static final InsertHandler<LookupElement> ihNone = insertHandler("", 0);

  private static final Map<String, InsertHandler<LookupElement>> KEYWORDS1 =
      Map.of(
          "if",
          ihParens,
          "else",
          ihSpace,
          "while",
          ihParens,
          "switch",
          insertHandler(" () {}", 2),
          "for",
          ihParens,
          "do",
          ihSpace,
          "in",
          ihSpace,
          "getline",
          ihNone);
  private static final Map<String, InsertHandler<LookupElement>> KEYWORDS_CASE_DEFAULT =
      Map.of(
          "case", insertHandler(" :", 1),
          "default", insertHandler(":", 1));
  private static final Map<String, InsertHandler<LookupElement>> KEYWORDS2 =
      Map.of(
          "break",
          ihNone,
          "continue",
          ihNone,
          "next",
          ihNone,
          "nextfile",
          ihNone,
          "exit",
          ihSpace,
          "return",
          ihNone,
          "delete",
          ihSpace,
          "print",
          ihSpace,
          "printf",
          ihSpace);

  public AwkCompletionContributorKeywords() {
    extend(
        CompletionType.BASIC,
        notInsideStringERE(
            psiElement()
                .inside(AwkPattern.class)), // TODO improve this selector to be less specific
        new CompletionProvider<>() {
          public void addCompletions(
              @NotNull CompletionParameters parameters,
              @NotNull ProcessingContext context,
              @NotNull CompletionResultSet resultSet) {

            addContributionResults(resultSet, KEYWORDS0);
          }
        });
    extend(
        CompletionType.BASIC,
        notInsideStringERE(
            or(
                psiElement().inside(AwkTerminatedStatement.class),
                psiElement().inside(AwkUnterminatedStatement.class))),
        new CompletionProvider<>() {
          public void addCompletions(
              @NotNull CompletionParameters parameters,
              @NotNull ProcessingContext context,
              @NotNull CompletionResultSet resultSet) {

            // TODO: handle autocomplete while in `do {}while`
            // TODO: make `in` autocompletion work
            addContributionResults(resultSet, KEYWORDS1);
          }
        });
    extend(
        CompletionType.BASIC,
        notInsideStringERE(psiElement().inside(AwkTerminatableStatement.class)),
        new CompletionProvider<>() {
          public void addCompletions(
              @NotNull CompletionParameters parameters,
              @NotNull ProcessingContext context,
              @NotNull CompletionResultSet resultSet) {

            addContributionResults(resultSet, KEYWORDS2);
          }
        });
    extend(
        CompletionType.BASIC,
        notInsideStringERE(psiElement().inside(AwkGawkTerminatedStatementSwitch.class)),
        new CompletionProvider<>() {
          @Override
          protected void addCompletions(
              @NotNull CompletionParameters parameters,
              @NotNull ProcessingContext context,
              @NotNull CompletionResultSet resultSet) {

            addContributionResults(resultSet, KEYWORDS_CASE_DEFAULT);
          }
        });
  }

  private void addContributionResults(
      @NotNull CompletionResultSet resultSet, Map<String, InsertHandler<LookupElement>> keywords2) {
    for (Map.Entry<String, InsertHandler<LookupElement>> entry : keywords2.entrySet()) {
      resultSet.addElement(
          LookupElementBuilder.create(entry.getKey())
              .withBoldness(true)
              .withInsertHandler(entry.getValue()));
    }
  }
}
