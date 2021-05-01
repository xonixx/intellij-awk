package intellij_awk;

import com.intellij.codeInsight.completion.*;
import com.intellij.codeInsight.lookup.LookupElementBuilder;
import com.intellij.util.ProcessingContext;
import intellij_awk.psi.AwkPattern;
import intellij_awk.psi.AwkTerminatedStatement;
import intellij_awk.psi.AwkUnterminatedStatement;
import org.jetbrains.annotations.NotNull;

import java.util.Map;

import static com.intellij.patterns.PlatformPatterns.psiElement;
import static com.intellij.patterns.StandardPatterns.or;
import static intellij_awk.AwkUtil.insertHandler;

public class AwkCompletionContributorKeywords extends CompletionContributor {

  private static final String[] BEGIN_END = {"BEGIN", "END"};
  private static final Map<String, Boolean> KEYWORDS1 =
      Map.of("if", true, "else", false, "while", true, "for", true, "do", false, "in", false);

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
            for (Map.Entry<String, Boolean> entry : KEYWORDS1.entrySet()) {
              boolean insertParens = entry.getValue();
              resultSet.addElement(
                  LookupElementBuilder.create(entry.getKey())
                      .withBoldness(true)
                      .withInsertHandler(
                          insertHandler(insertParens ? " ()" : " ", insertParens ? 2 : 1)));
            }
          }
        });
  }
}
