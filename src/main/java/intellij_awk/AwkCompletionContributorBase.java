package intellij_awk;

import static com.intellij.patterns.PlatformPatterns.psiElement;
import static com.intellij.patterns.StandardPatterns.*;

import com.intellij.codeInsight.completion.CompletionContributor;
import com.intellij.codeInsight.completion.CompletionParameters;
import com.intellij.codeInsight.completion.CompletionResultSet;
import com.intellij.patterns.ElementPattern;
import com.intellij.patterns.ObjectPattern;
import com.intellij.patterns.PsiElementPattern;
import com.intellij.psi.PsiElement;
import intellij_awk.psi.AwkTypes;

abstract class AwkCompletionContributorBase extends CompletionContributor {
  static final PsiElementPattern.Capture<PsiElement> INSIDE_STRING = psiElement(AwkTypes.STRING);
  private static final ElementPattern<PsiElement> notInsideERE =
          not(or(psiElement(AwkTypes.ERE), psiElement(AwkTypes.TYPED_ERE)));

  private static final ObjectPattern.Capture<PsiElement> notInsideStringEre =
          not(INSIDE_STRING).and(notInsideERE);

  static ElementPattern<? extends PsiElement> notInsideStringERE(
          ElementPattern<? extends PsiElement> pattern) {
    return and(notInsideStringEre, pattern);
  }

  static ElementPattern<? extends PsiElement> notInsideERE(
          ElementPattern<? extends PsiElement> pattern) {
    return and(notInsideERE, pattern);
  }

  // The idea behind this is we want to autocomplete `funcName` when inside string with
  // space: "xxx fun<caret>"
  static CompletionResultSet adjustPrefix(
      CompletionResultSet resultSet, CompletionParameters parameters) {

    PsiElement element = parameters.getPosition();
    boolean isInsideString = INSIDE_STRING.accepts(parameters.getPosition());

    if (!isInsideString) {
      return resultSet; // no change
    }

    int offset = parameters.getOffset();
    String text = element.getText();
    String substr = text.substring(0, offset - element.getTextRange().getStartOffset());

    String[] parts = substr.split("\\s");
    if (parts.length == 1) {
      return resultSet; // no change
    }

    return resultSet.withPrefixMatcher(parts[parts.length - 1]);
  }
}
