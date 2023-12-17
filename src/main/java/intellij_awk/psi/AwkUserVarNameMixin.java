package intellij_awk.psi;

import static com.intellij.patterns.PlatformPatterns.psiElement;

import com.intellij.lang.ASTNode;
import com.intellij.navigation.ItemPresentation;
import com.intellij.patterns.PsiElementPattern;
import com.intellij.psi.PsiElement;
import com.intellij.psi.stubs.IStubElementType;
import com.intellij.psi.util.PsiTreeUtil;
import intellij_awk.AwkIcons;
import intellij_awk.AwkReferenceVariable;
import intellij_awk.AwkUtil;
import java.util.regex.Pattern;
import javax.swing.*;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public abstract class AwkUserVarNameMixin
    extends AwkNamedStubBasedPsiElementBase<AwkUserVarNameStub>
    implements AwkUserVarName, AwkUserVarNameDeclaration {

  /**
   *
   * <li>Var = ...
   * <li>Var["key"] = ...
   */
  private static final PsiElementPattern.@NotNull Capture<PsiElement> LVALUE_ASSIGN =
      psiElement()
          .withParent(
              (psiElement(AwkLvalue.class).beforeLeaf(psiElement(AwkTypes.ASSIGN)))
                  .withParent(psiElement(AwkNonUnaryExpr.class)));

  /**
   *
   * <li>Var TODO should we support this? bwk doesn't support, gawk/mawk do
   * <li>Var["key"]
   */
  private static final PsiElementPattern.@NotNull Capture<PsiElement> LVALUE_ASSIGN1 =
      psiElement()
          .withParent(
              psiElement(AwkLvalue.class)
                  .withParent(
                      psiElement(AwkNonUnaryExpr.class)
                          .withParent(psiElement(AwkSimpleStatement.class))));

  private static final Pattern WHITESPACES = Pattern.compile("\\s+");

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
  public AwkReferenceVariable getReference() {
    return new AwkReferenceVariable(this, getNameTextRange());
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
        return AwkUserVarNameMixin.this.getIcon(0);
      }
    };
  }

  @Override
  public @Nullable Icon getIcon(int flags) {
    return AwkIcons.VARIABLE;
  }

  /**
   *
   * <li>Var = ...
   * <li>Var["key"] = ...
   * <li>Var["key"]
   * <li>split("",Var)
   * <li>delete Var
   */
  public boolean looksLikeDeclaration() {
    AwkUserVarNameStub stub = getStub();
    if (stub != null) {
      return stub.looksLikeDeclaration();
    }

    if (LVALUE_ASSIGN.accepts(this)) {
      return true;
    }

    // TODO can this be done easier???
    if (LVALUE_ASSIGN1.accepts(this)
        && getParent().getParent().getFirstChild().getNextSibling() == null) {
      return true;
    }

    PsiElement p = AwkUtil.findParent(this, AwkGawkFuncCallList.class);
    if (p != null) {
      p = p.getParent();
      ASTNode splitFunc;
      if (p != null
          && (splitFunc = p.getFirstChild().getNode())
              .getElementType()
              .equals(AwkTypes.BUILTIN_FUNC_NAME)
          && splitFunc.getText().equals("split")
          && p.getText().replace(" ", "").equals("split(\"\"," + getName() + ")")) {
        // `split("",Var)` case
        return true;
      }
    }

    // delete A
    String code = getParent().getText();
    if (("delete " + getName()).equals(WHITESPACES.matcher(code).replaceFirst(" "))) {
      return true;
    }

    return false;
  }

  /**
   *
   * <li><code>BEGIN { here }</code>
   * <li><code>function init*() { here }</code>
   */
  public boolean isInsideInitializingContext() {
    AwkUserVarNameStub stub = getStub();
    if (stub != null) {
      return stub.isInsideInitializingContext();
    }

    AwkAction action = PsiTreeUtil.getTopmostParentOfType(this, AwkAction.class);
    if (action == null) {
      return false;
    }

    PsiElement parent = action.getParent();
    if (parent instanceof AwkItem) {
      AwkItem awkItem = (AwkItem) parent;

      AwkPattern pattern = awkItem.getPattern();

      AwkFunctionNameMixin functionName;

      return pattern != null && pattern.getBeginOrEnd() instanceof AwkBeginBlock
          || (functionName = (AwkFunctionNameMixin) awkItem.getFunctionName()) != null
              && functionName.isInitFunction()
              && !functionName
                  .getParameterNamesIncludingLocals()
                  .contains(getName()) /* not local var */;
    }

    return false;
  }

  public boolean isALocalVariableInAFunction() {
    AwkAction action = PsiTreeUtil.getTopmostParentOfType(this, AwkAction.class);
    if (action == null) {
      return false;
    }

    PsiElement parent = action.getParent();
    if (parent instanceof AwkItem) {
      AwkItem awkItem = (AwkItem) parent;
      AwkFunctionNameMixin functionName = (AwkFunctionNameMixin) awkItem.getFunctionName();
      return functionName != null
          && functionName.getParameterNamesIncludingLocals().contains(getName()) /* local var */;
    }

    return false;
  }
}
