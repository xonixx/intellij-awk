package intellij_awk.psi;

import com.intellij.lang.ASTNode;
import com.intellij.openapi.util.TextRange;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiReference;
import intellij_awk.AwkReferenceFunction;
import javax.swing.*;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public abstract class AwkStringMixin extends AwkNamedElementImpl {
  public AwkStringMixin(@NotNull ASTNode node) {
    super(node);
  }

  public PsiElement setName(String newName) {
    return replaceNameNode(AwkElementFactory.createFunctionCallName(getProject(), newName));
  }

  @Override
  public PsiReference getReference() {
//    return new AwkReferenceFunction(this, getNameTextRange());
    return new AwkReferenceFunction(this, TextRange.from(1, getTextLength()-2));
//    return null;
  }

  @Override
  public @Nullable Icon getIcon(int flags) {
    return null;
  }
}
