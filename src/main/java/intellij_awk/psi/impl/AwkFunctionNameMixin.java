package intellij_awk.psi.impl;

import com.intellij.lang.ASTNode;
import com.intellij.psi.PsiElement;
import intellij_awk.psi.AwkFunctionName;
import org.jetbrains.annotations.NotNull;

public abstract class AwkFunctionNameMixin extends AwkNamedElementImpl implements AwkFunctionName {
  public AwkFunctionNameMixin(@NotNull ASTNode node) {
    super(node);
  }

  public PsiElement setName(String newName) {
    throw new UnsupportedOperationException("TBD");
  }

  public PsiElement getNameIdentifier() {
    return this;
  }
}
