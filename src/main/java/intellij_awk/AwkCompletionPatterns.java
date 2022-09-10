package intellij_awk;

import com.intellij.patterns.ElementPattern;
import com.intellij.patterns.ObjectPattern;
import com.intellij.patterns.PsiElementPattern;
import com.intellij.psi.PsiElement;
import intellij_awk.psi.AwkTypes;

import static com.intellij.patterns.PlatformPatterns.psiElement;
import static com.intellij.patterns.StandardPatterns.and;
import static com.intellij.patterns.StandardPatterns.not;

public class AwkCompletionPatterns {
  static final PsiElementPattern.Capture<PsiElement> INSIDE_STRING = psiElement(AwkTypes.STRING);
  static final PsiElementPattern.Capture<PsiElement> INSIDE_ERE = psiElement(AwkTypes.ERE);

  static final ObjectPattern.Capture<PsiElement> NOT_INSIDE_STRING_ERE =
      not(INSIDE_STRING).andNot(INSIDE_ERE);

  static ElementPattern<? extends PsiElement> notInsideStringERE(
      ElementPattern<? extends PsiElement> pattern) {
    return and(NOT_INSIDE_STRING_ERE, pattern);
  }
}
