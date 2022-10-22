package intellij_awk;

import com.intellij.codeInsight.completion.CompletionContributor;
import com.intellij.codeInsight.completion.CompletionParameters;
import com.intellij.codeInsight.completion.CompletionResultSet;
import com.intellij.psi.PsiElement;

import static intellij_awk.AwkCompletionPatterns.INSIDE_STRING;

abstract class AwkCompletionBase extends CompletionContributor {
  // The idea behind this is we want to autocomplete funcName when inside string with
  // space: "xxx fun<cursor>"
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
