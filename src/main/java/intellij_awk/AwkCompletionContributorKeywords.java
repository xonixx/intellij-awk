package intellij_awk;

import com.intellij.codeInsight.completion.*;
import com.intellij.codeInsight.lookup.LookupElementBuilder;
import com.intellij.openapi.editor.EditorModificationUtil;
import com.intellij.patterns.PlatformPatterns;
import com.intellij.util.ProcessingContext;
import intellij_awk.psi.AwkPattern;
import org.jetbrains.annotations.NotNull;

public class AwkCompletionContributorKeywords extends CompletionContributor {

  public AwkCompletionContributorKeywords() {
    extend(
        CompletionType.BASIC,
        PlatformPatterns.psiElement()
            .inside(AwkPattern.class), // TODO improve this selector to be less specific
        new CompletionProvider<>() {
          public void addCompletions(
              @NotNull CompletionParameters parameters,
              @NotNull ProcessingContext context,
              @NotNull CompletionResultSet resultSet) {

            resultSet.addElement(
                LookupElementBuilder.create("function")
                    .withBoldness(true)
                    .withInsertHandler(
                        (ctx, item) -> {
                          ctx.getDocument().insertString(ctx.getSelectionEndOffset(), " ");
                          EditorModificationUtil.moveCaretRelatively(ctx.getEditor(), 1);
                        }));

            for (String pattern : new String[] {"BEGIN", "END"}) {
              resultSet.addElement(
                  LookupElementBuilder.create(pattern)
                      .withBoldness(true)
                      .withInsertHandler(
                          (ctx, item) -> {
                            ctx.getDocument().insertString(ctx.getSelectionEndOffset(), " { }");
                            EditorModificationUtil.moveCaretRelatively(ctx.getEditor(), 3);
                          }));
            }
          }
        });
  }
}
