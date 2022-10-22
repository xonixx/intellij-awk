package intellij_awk;

import com.intellij.codeInsight.completion.CompletionParameters;
import com.intellij.codeInsight.completion.CompletionProvider;
import com.intellij.codeInsight.completion.CompletionResultSet;
import com.intellij.codeInsight.completion.CompletionType;
import com.intellij.codeInsight.lookup.LookupElementBuilder;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiFile;
import com.intellij.util.ProcessingContext;
import intellij_awk.psi.AwkTypes;
import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

public class AwkCompletionContributorStrings extends AwkCompletionContributorBase {

  public AwkCompletionContributorStrings() {
    extend(
        CompletionType.BASIC,
        INSIDE_STRING,
        new CompletionProvider<>() {
          public void addCompletions(
              @NotNull CompletionParameters parameters,
              @NotNull ProcessingContext context,
              @NotNull CompletionResultSet resultSet) {

            resultSet = adjustPrefix(resultSet, parameters);

            PsiElement psiElement = parameters.getPosition();

            PsiFile psiFile = psiElement.getContainingFile();

            ArrayList<PsiElement> strings = new ArrayList<>();
            AwkUtil.findAllMatchedDeep2(
                psiFile, psiEl -> AwkUtil.isType(psiEl, AwkTypes.STRING), strings);

            String prefix = resultSet.getPrefixMatcher().getPrefix();

            Set<String> wordCompletions = new HashSet<>();
            for (PsiElement string : strings) {
              String text = string.getText(); // TODO do we need some un-escaping?
              String stringVal = text.substring(1, text.length() - 1);
              String[] words = stringVal.split("\\s");
              wordCompletions.addAll(
                  Arrays.stream(words).filter(s -> !prefix.equals(s)).collect(Collectors.toList()));
            }

            for (String wordCompletion : wordCompletions) {
              resultSet.addElement(
                  LookupElementBuilder.create(
                      wordCompletion) /*.withIcon(AwkIcons.VARIABLE)*/); // TODO icon
            }
          }
        });
  }
}
