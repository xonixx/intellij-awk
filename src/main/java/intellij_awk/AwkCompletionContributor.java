package intellij_awk;

import com.intellij.codeInsight.completion.*;
import com.intellij.codeInsight.lookup.LookupElementBuilder;
import com.intellij.patterns.PlatformPatterns;
import com.intellij.util.ProcessingContext;
import intellij_awk.psi.AwkFile;
import intellij_awk.psi.impl.AwkFunctionNameImpl;
import org.jetbrains.annotations.NotNull;

import java.util.List;

import static com.intellij.patterns.StandardPatterns.instanceOf;

public class AwkCompletionContributor extends CompletionContributor {

  public AwkCompletionContributor() {
    extend(
        CompletionType.BASIC,
        //        PlatformPatterns.psiElement(AwkFunctionCallName.class).,
        PlatformPatterns.psiElement().inFile(instanceOf(AwkFile.class)),
        new CompletionProvider<>() {
          public void addCompletions(
              @NotNull CompletionParameters parameters,
              @NotNull ProcessingContext context,
              @NotNull CompletionResultSet resultSet) {

            List<AwkFunctionNameImpl> functionNames =
                AwkUtil.findFunctions(parameters.getPosition().getProject());

            for (AwkFunctionNameImpl functionName : functionNames) {
              resultSet.addElement(
                  LookupElementBuilder.create(functionName.getName())
                      .withTailText("()")
                      .withIcon(AwkIcons.FUNCTION));
            }
          }
        });
  }
}
