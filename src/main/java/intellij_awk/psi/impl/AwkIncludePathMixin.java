package intellij_awk.psi.impl;

import com.intellij.lang.ASTNode;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiReference;
import intellij_awk.AwkReferenceIncludePath;
import intellij_awk.AwkReferenceVariable;
import intellij_awk.psi.AwkElementFactory;
import intellij_awk.psi.AwkIncludePath;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;

public abstract class AwkIncludePathMixin extends AwkNamedElementImpl implements AwkIncludePath {
  public AwkIncludePathMixin(@NotNull ASTNode node) {
    super(node);
  }

  public PsiElement setName(String newName) {
    throw new UnsupportedOperationException("TBD");
//    return replaceNameNode(AwkElementFactory.createUserVarName(getProject(), newName));
  }

  @Override
  public PsiReference getReference() {
    return new AwkReferenceIncludePath(this, getNameTextRange());
  }

  @Override
  public @Nullable Icon getIcon(int flags) {
    return null;
  }
}
