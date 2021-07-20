package intellij_awk.psi;

import com.intellij.lang.ASTNode;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiReference;
import com.intellij.psi.stubs.IStubElementType;
import intellij_awk.AwkReferenceVariable;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;

public abstract class AwkUserVarNameMixin
    extends AwkNamedStubBasedPsiElementBase<AwkUserVarNameStub> implements AwkUserVarName {
  public AwkUserVarNameMixin(@NotNull ASTNode node) {
    super(node);
  }

  public AwkUserVarNameMixin(@NotNull AwkUserVarNameStub stub, @NotNull IStubElementType nodeType) {
    super(stub, nodeType);
  }

  public PsiElement setName(String newName) {
    return replaceNameNode(AwkElementFactory.createUserVarName(getProject(), newName));
  }

  @Override
  public PsiReference getReference() {
    return new AwkReferenceVariable(this, getNameTextRange());
  }

  @Override
  public @Nullable Icon getIcon(int flags) {
    return null;
  }

  /** <code>Var = ...</code> or <code>split("",Var)</code> */
  public boolean looksLikeDeclaration() {
    throw new UnsupportedOperationException("TBD");
  }
}
