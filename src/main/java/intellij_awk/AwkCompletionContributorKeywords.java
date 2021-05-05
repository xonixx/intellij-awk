package intellij_awk;

import com.intellij.codeInsight.completion.*;
import com.intellij.codeInsight.lookup.LookupElement;
import com.intellij.codeInsight.lookup.LookupElementBuilder;
import com.intellij.util.ProcessingContext;
import intellij_awk.psi.*;
import org.jetbrains.annotations.NotNull;

import java.util.Map;

import static com.intellij.patterns.PlatformPatterns.psiElement;
import static com.intellij.patterns.StandardPatterns.or;
import static intellij_awk.AwkUtil.insertHandler;

public class AwkCompletionContributorKeywords extends CompletionContributor {

  private static final String[] BEGIN_END = {"BEGIN", "END"};
  private static final InsertHandler<LookupElement> ihParens = insertHandler(" ()", 2);
  private static final InsertHandler<LookupElement> ihSpace = insertHandler(" ", 1);
  private static final InsertHandler<LookupElement> ihNone = insertHandler("", 0);
  private static final Map<String, InsertHandler<LookupElement>> KEYWORDS1 =
      Map.of(
          "if", ihParens, "else", ihSpace, "while", ihParens, "for", ihParens, "do", ihSpace, "in",
          ihSpace, "getline", ihNone);
  private static final Map<String, InsertHandler<LookupElement>> KEYWORDS2 =
      Map.of(
          "break",
          ihNone,
          "continue",
          ihNone,
          "next",
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
        psiElement().inside(AwkPattern.class), // TODO improve this selector to be less specific
        new CompletionProvider<>() {
          public void addCompletions(
              @NotNull CompletionParameters parameters,
              @NotNull ProcessingContext context,
              @NotNull CompletionResultSet resultSet) {

            resultSet.addElement(
                LookupElementBuilder.create("function")
                    .withBoldness(true)
                    .withInsertHandler(insertHandler(" ", 1)));

            for (String pattern : BEGIN_END) {
              resultSet.addElement(
                  LookupElementBuilder.create(pattern)
                      .withBoldness(true)
                      .withInsertHandler(insertHandler(" { }", 3)));
            }
          }
        });
    extend(
        CompletionType.BASIC,
        or(
            psiElement().inside(AwkTerminatedStatement.class),
            psiElement().inside(AwkUnterminatedStatement.class)),
        new CompletionProvider<>() {
          public void addCompletions(
              @NotNull CompletionParameters parameters,
              @NotNull ProcessingContext context,
              @NotNull CompletionResultSet resultSet) {

            // TODO: handle autocomplete while in `do {}while`
            // TODO: make `in` autocompletion work
            for (Map.Entry<String, InsertHandler<LookupElement>> entry : KEYWORDS1.entrySet()) {
              resultSet.addElement(
                  LookupElementBuilder.create(entry.getKey())
                      .withBoldness(true)
                      .withInsertHandler(entry.getValue()));
            }
          }
        });
    extend(
        CompletionType.BASIC,
        psiElement().inside(AwkTerminatableStatement.class),
        new CompletionProvider<>() {
          public void addCompletions(
              @NotNull CompletionParameters parameters,
              @NotNull ProcessingContext context,
              @NotNull CompletionResultSet resultSet) {

            for (Map.Entry<String, InsertHandler<LookupElement>> entry : KEYWORDS2.entrySet()) {
              resultSet.addElement(
                  LookupElementBuilder.create(entry.getKey())
                      .withBoldness(true)
                      .withInsertHandler(entry.getValue()));
            }
          }
        });
  }
}
