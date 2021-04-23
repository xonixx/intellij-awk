package intellij_awk.psi.impl;

import com.intellij.lang.ASTNode;
import com.intellij.openapi.util.TextRange;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiReference;
import intellij_awk.AwkReferenceFunction;
import intellij_awk.AwkReferenceVariable;
import intellij_awk.psi.AwkFunctionCall;
import intellij_awk.psi.AwkUserVarName;
import org.jetbrains.annotations.NotNull;

public abstract class AwkUserVarNameMixin extends AwkNamedElementImpl implements AwkUserVarName {
  public AwkUserVarNameMixin(@NotNull ASTNode node) {
    super(node);
  }

  public PsiElement setName(String newName) {
    throw new UnsupportedOperationException("TBD");
  }

  @Override
  public PsiReference getReference() {
    return new AwkReferenceVariable(getNameIdentifier(), TextRange.from(0, getName().length()));
  }
}
