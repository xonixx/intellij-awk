package intellij_awk.psi;

import com.intellij.lang.ASTNode;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiReference;
import intellij_awk.AwkReferenceFunction;
import intellij_awk.AwkReferenceVariable;
import intellij_awk.AwkUtil;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;

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
    PsiElement prevSibling = AwkUtil.getPrevNotWhitespace(this);
    return prevSibling != null && prevSibling.getNode().getElementType().equals(AwkTypes.AT)
        ? new AwkReferenceVariable(this, getNameTextRange())
        : new AwkReferenceFunction(this, getNameTextRange());
  }

  @Override
  public @Nullable Icon getIcon(int flags) {
    return null;
  }
}
