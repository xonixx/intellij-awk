package intellij_awk.psi.impl;

import com.intellij.icons.AllIcons;
import com.intellij.lang.ASTNode;
import com.intellij.navigation.ItemPresentation;
import com.intellij.psi.PsiElement;
import intellij_awk.psi.AwkFunctionName;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;

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

  public ItemPresentation getPresentation() {
    return new ItemPresentation() {
      @Nullable
      @Override
      public String getPresentableText() {
        return getName();
      }

      @Override
      public String getLocationString() {
        return getContainingFile().getName();
      }

      @Override
      public Icon getIcon(boolean unused) {
        return AllIcons.Nodes.Function;
      }
    };
  }

  @Override
  public @Nullable Icon getIcon(int flags) {
    return AllIcons.Nodes.Function;
  }
}
