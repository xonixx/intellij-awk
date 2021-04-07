package intellij_awk.psi.impl;

import com.intellij.extapi.psi.ASTWrapperPsiElement;
import com.intellij.lang.ASTNode;
import intellij_awk.psi.AwkNamedElement;
import org.jetbrains.annotations.NotNull;

public abstract class AwkNamedElementImpl extends ASTWrapperPsiElement implements AwkNamedElement {

  public AwkNamedElementImpl(@NotNull ASTNode node) {
    super(node);
  }
}
