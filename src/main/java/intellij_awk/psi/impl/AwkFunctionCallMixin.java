package intellij_awk.psi.impl;

import com.intellij.lang.ASTNode;
import com.intellij.openapi.util.TextRange;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiReference;
import intellij_awk.AwkReferenceFunction;
import intellij_awk.psi.AwkFunctionCall;
import org.jetbrains.annotations.NotNull;

public abstract class AwkFunctionCallMixin extends AwkNamedElementImpl implements AwkFunctionCall {
  public AwkFunctionCallMixin(@NotNull ASTNode node) {
    super(node);
  }

  public PsiElement setName(String newName) {
    throw new UnsupportedOperationException("TBD");
  }

  public PsiElement getNameIdentifier() {
    return getFuncName();
  }

  @Override
  public PsiReference getReference() {
    return new AwkReferenceFunction(getNameIdentifier(), TextRange.from(0, getName().length()));
  }
}
