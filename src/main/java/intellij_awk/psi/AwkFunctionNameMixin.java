package intellij_awk.psi;

import com.intellij.lang.ASTNode;
import com.intellij.navigation.ItemPresentation;
import com.intellij.psi.PsiElement;
import com.intellij.psi.stubs.IStubElementType;
import intellij_awk.AwkIcons;
import intellij_awk.AwkUtil;
import java.util.ArrayList;
import java.util.List;
import javax.swing.*;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public abstract class AwkFunctionNameMixin
    extends AwkNamedStubBasedPsiElementBase<AwkFunctionNameStub> implements AwkFunctionName {

  public AwkFunctionNameMixin(@NotNull ASTNode node) {
    super(node);
  }

  public AwkFunctionNameMixin(
      @NotNull AwkFunctionNameStub stub, @NotNull IStubElementType nodeType) {
    super(stub, nodeType);
  }

  public PsiElement getNamePsiElement() {
    PsiElement funcName = getFuncName();
    return funcName != null ? funcName : getVarName();
  }

  @Override
  public String getName() {
    AwkFunctionNameStub awkFunctionNameStub = getStub();
    if (awkFunctionNameStub != null) {
      return awkFunctionNameStub.getName();
    }
    return super.getName();
  }

  public PsiElement setName(String newName) {
    return replaceNameNode(AwkElementFactory.createFunctionName(getProject(), newName));
  }

  public ItemPresentation getPresentation() {
    return new ItemPresentation() {
      @Nullable
      @Override
      public String getPresentableText() {
        return getName() + getSignatureString();
      }

      @Override
      public String getLocationString() {
        return getContainingFile().getName();
      }

      @Override
      public Icon getIcon(boolean unused) {
        return AwkIcons.FUNCTION;
      }
    };
  }

  @Override
  public @Nullable Icon getIcon(int flags) {
    return AwkIcons.FUNCTION;
  }

  public String getSignatureString() {
    AwkFunctionNameStub awkFunctionNameStub = getStub();
    if (awkFunctionNameStub != null) {
      return awkFunctionNameStub.getSignatureString();
    }
    return "(" + String.join(", ", getParameterNames()) + ")";
  }

  /** @return parameter names excluding "local" */
  public List<String> getParameterNames() {
    List<String> result = new ArrayList<>();
    AwkItem awkItem = (AwkItem) getParent();
    AwkParamList awkParamList = awkItem.getParamList();
    if_block:
    if (awkParamList != null) {
      PsiElement prevSibling = awkParamList.getPrevSibling();
      if (AwkUtil.isWhitespaceBeforeLocals(prevSibling)) { // all args are local
        break if_block;
      }
      PsiElement psiElement = awkParamList.getFirstChild();
      while (psiElement != null) {
        if (psiElement instanceof AwkUserVarName) {
          result.add(psiElement.getText());
        } else if (AwkUtil.isWhitespaceBeforeLocals(psiElement)) { // locals started
          break;
        }
        psiElement = psiElement.getNextSibling();
      }
    }
    return result;
  }

  public List<String> getParameterNamesIncludingLocals() {
    List<String> result = new ArrayList<>();
    AwkItem awkItem = (AwkItem) getParent();
    AwkParamList awkParamList = awkItem.getParamList();
    if (awkParamList != null) {
      PsiElement psiElement = awkParamList.getFirstChild();
      while (psiElement != null) {
        if (psiElement instanceof AwkUserVarName) {
          result.add(psiElement.getText());
        }
        psiElement = psiElement.getNextSibling();
      }
    }
    return result;
  }

  public boolean isInitFunction() {
    return getName().startsWith("init");
  }
}
