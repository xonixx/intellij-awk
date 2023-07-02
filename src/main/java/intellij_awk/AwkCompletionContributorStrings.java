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
import java.util.*;
import java.util.stream.Collectors;
import org.jetbrains.annotations.NotNull;

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
              stringVal = stringVal.replace("\\n", " ");
              //              String[] words = stringVal.split("[\\W&&[^.]]");
              Set<String> words = new HashSet<>();
              StringBuilder currentWord = new StringBuilder();
              for (int i = 0; i < stringVal.length(); i++) {
                char c = stringVal.charAt(i);
                if (Character.isAlphabetic(c) || Character.isDigit(c)) {
                  currentWord.append(c);
                } else {
                  words.add(currentWord.toString());
                  currentWord = new StringBuilder();
                }
              }
              words.add(currentWord.toString());
              currentWord = new StringBuilder();
              for (int i = 0; i < stringVal.length(); i++) {
                char c = stringVal.charAt(i);
                if (Character.isAlphabetic(c) || Character.isDigit(c) || '.' == c) {
                  currentWord.append(c);
                } else {
                  words.add(currentWord.toString());
                  currentWord = new StringBuilder();
                }
              }
              words.add(currentWord.toString());
              wordCompletions.addAll(
                  words.stream().filter(s -> !prefix.equals(s)).collect(Collectors.toList()));
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
