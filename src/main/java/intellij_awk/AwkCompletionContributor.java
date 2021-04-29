package intellij_awk;

import com.intellij.codeInsight.completion.*;
import com.intellij.codeInsight.lookup.LookupElementBuilder;
import com.intellij.openapi.editor.EditorModificationUtil;
import com.intellij.patterns.PlatformPatterns;
import com.intellij.util.ProcessingContext;
import intellij_awk.psi.AwkExpr;
import intellij_awk.psi.impl.AwkFunctionNameImpl;
import org.jetbrains.annotations.NotNull;

import java.util.List;

public class AwkCompletionContributor extends CompletionContributor {

  public AwkCompletionContributor() {
    extend(
        CompletionType.BASIC,
        PlatformPatterns.psiElement().inside(AwkExpr.class),
        new CompletionProvider<>() {
          public void addCompletions(
              @NotNull CompletionParameters parameters,
              @NotNull ProcessingContext context,
              @NotNull CompletionResultSet resultSet) {

            List<AwkFunctionNameImpl> functionNames =
                AwkUtil.findFunctions(parameters.getOriginalFile());

            for (AwkFunctionNameImpl functionName : functionNames) {
              resultSet.addElement(
                  LookupElementBuilder.create(functionName.getName())
                      .withTailText("()")
                      .withIcon(AwkIcons.FUNCTION)
                      .withInsertHandler(
                          (ctx, item) -> {
                            ctx.getDocument().insertString(ctx.getSelectionEndOffset(), "()");
                            EditorModificationUtil.moveCaretRelatively(ctx.getEditor(), 1);
                          }));
            }
          }
        });
  }
}
