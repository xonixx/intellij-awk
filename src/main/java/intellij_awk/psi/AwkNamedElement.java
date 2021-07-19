package intellij_awk.psi;

import com.intellij.openapi.diagnostic.Logger;
import com.intellij.openapi.util.NlsSafe;
import com.intellij.openapi.util.TextRange;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiNameIdentifierOwner;
import com.intellij.util.IncorrectOperationException;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public interface AwkNamedElement extends PsiNameIdentifierOwner {
  Logger LOG = Logger.getInstance(AwkNamedElementImpl.class);

  @Override
  default @Nullable PsiElement getNameIdentifier() {
    return this;
  }

/*
  @Override
  default String getName() {
    return getNameIdentifier().getText();
  }
*/

  @Override
  default PsiElement setName(@NlsSafe @NotNull String name) throws IncorrectOperationException {
    throw new UnsupportedOperationException("Implement me in a mixin");
  }

  default TextRange getNameTextRange() {
    return TextRange.from(0, getName().length());
  }

  default PsiElement replaceNameNode(PsiElement newNode) {
    if (newNode != null) {
      replace(newNode);
    } else {
      LOG.warn("Unable to replace renamed node, because it's null");
    }
    return this;
  }
}
