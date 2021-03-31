package intellij_awk.psi.impl;

import com.intellij.extapi.psi.ASTWrapperPsiElement;
import com.intellij.lang.ASTNode;
import intellij_awk.psi.SimpleNamedElement;
import org.jetbrains.annotations.NotNull;

public abstract class SimpleNamedElementImpl extends ASTWrapperPsiElement
    implements SimpleNamedElement {

  public SimpleNamedElementImpl(@NotNull ASTNode node) {
    super(node);
  }
}
