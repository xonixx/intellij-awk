package intellij_awk.psi.impl;

import com.intellij.lang.ASTNode;
import com.intellij.openapi.util.TextRange;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiReference;
import intellij_awk.AwkReferenceFunction;
import intellij_awk.psi.AwkElementFactory;
import intellij_awk.psi.AwkFunctionCallName;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;

public abstract class AwkFunctionCallNameMixin extends AwkNamedElementImpl
    implements AwkFunctionCallName {
  public AwkFunctionCallNameMixin(@NotNull ASTNode node) {
    super(node);
  }

  public PsiElement setName(String newName) {
    replace(AwkElementFactory.createFunctionCallName(getProject(), newName));
    return this;
  }

  @Override
  public PsiReference getReference() {
    return new AwkReferenceFunction(
        (AwkFunctionCallNameImpl) this, TextRange.from(0, getName().length()));
  }

  @Override
  public @Nullable Icon getIcon(int flags) {
    return null;
  }
}
