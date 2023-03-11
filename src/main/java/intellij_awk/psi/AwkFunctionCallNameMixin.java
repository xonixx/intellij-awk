package intellij_awk.psi;

import com.intellij.lang.ASTNode;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiReference;
import intellij_awk.AwkReferenceFunction;
import javax.swing.*;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public abstract class AwkFunctionCallNameMixin extends AwkNamedElementImpl
    implements AwkFunctionCallName {
  public AwkFunctionCallNameMixin(@NotNull ASTNode node) {
    super(node);
  }

  public PsiElement setName(String newName) {
    return replaceNameNode(AwkElementFactory.createFunctionCallName(getProject(), newName));
  }

  @Override
  public PsiReference getReference() {
    return new AwkReferenceFunction(this, getNameTextRange());
  }

  @Override
  public @Nullable Icon getIcon(int flags) {
    return null;
  }
}
