package intellij_awk.psi.impl;

import com.intellij.lang.ASTNode;
import com.intellij.navigation.ItemPresentation;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiWhiteSpace;
import intellij_awk.AwkIcons;
import intellij_awk.AwkUtil;
import intellij_awk.psi.*;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;
import java.util.ArrayList;
import java.util.List;

public abstract class AwkFunctionNameMixin extends AwkNamedElementImpl implements AwkFunctionName {
  public AwkFunctionNameMixin(@NotNull ASTNode node) {
    super(node);
  }

  public PsiElement setName(String newName) {
    return replaceNameNode(AwkElementFactory.createFunctionName(getProject(), newName));
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
        return AwkIcons.FUNCTION;
      }
    };
  }

  @Override
  public @Nullable Icon getIcon(int flags) {
    return AwkIcons.FUNCTION;
  }

  /** @return argument names excluding "local" */
  public List<String> getArgumentNames() {
    List<String> result = new ArrayList<>();
    AwkItem awkItem = (AwkItem) getParent();
    AwkParamList awkParamList =
        (AwkParamList) AwkUtil.findFirstMatchedDeep(awkItem, AwkParamList.class::isInstance);
    if (awkParamList != null) {
      for (PsiElement psiElement : awkParamList.getChildren()) {
        if (psiElement instanceof AwkUserVarName) {
          result.add(psiElement.getText());
        } else if (psiElement instanceof PsiWhiteSpace) {
          if (psiElement.getTextLength() >= 3) { // locals started
            break;
          }
        }
      }
    }
    return result;
  }
}
