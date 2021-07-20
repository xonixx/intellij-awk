package intellij_awk.psi;

import com.intellij.lang.ASTNode;
import com.intellij.patterns.PsiElementPattern;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiReference;
import com.intellij.psi.stubs.IStubElementType;
import intellij_awk.AwkReferenceVariable;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;

import static com.intellij.patterns.PlatformPatterns.psiElement;

public abstract class AwkUserVarNameMixin
    extends AwkNamedStubBasedPsiElementBase<AwkUserVarNameStub> implements AwkUserVarName {

  /** `Var = ...` */
  private static final PsiElementPattern.@NotNull Capture<PsiElement> VAR_ASSIGN =
      psiElement()
          .inside(AwkLvalue.class)
          .and(psiElement().beforeLeaf(psiElement(AwkTypes.ASSIGN)));

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
    AwkUserVarNameStub stub = getStub();
    if (stub != null) {
      return stub.looksLikeDeclaration();
    }

    PsiElement parent0 = getParent();
    PsiElement parent1 = parent0.getParent();
    PsiElement[] childrenOfParent1 = parent1.getChildren();

    if (VAR_ASSIGN.accepts(this)) {
      return true;
    }

    PsiElement p = parent1.getParent();
    if (p != null) {
      p = p.getParent();

      ASTNode splitFunc;
      if (p instanceof AwkNonUnaryExpr
          && (splitFunc = p.getFirstChild().getNode())
              .getElementType()
              .equals(AwkTypes.BUILTIN_FUNC_NAME)
          && splitFunc.getText().equals("split")
          && p.getText().replace(" ", "").equals("split(\"\"," + getName() + ")")) {
        // `split("",Var)` case
        return true;
      }
    }

    return false;
  }
}
