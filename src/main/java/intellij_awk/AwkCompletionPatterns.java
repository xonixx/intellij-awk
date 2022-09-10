package intellij_awk;

import com.intellij.patterns.ElementPattern;
import com.intellij.patterns.ObjectPattern;
import com.intellij.patterns.PsiElementPattern;
import com.intellij.psi.PsiElement;
import intellij_awk.psi.AwkTypes;

import static com.intellij.patterns.PlatformPatterns.psiElement;
import static com.intellij.patterns.StandardPatterns.*;

public class AwkCompletionPatterns {
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
}
