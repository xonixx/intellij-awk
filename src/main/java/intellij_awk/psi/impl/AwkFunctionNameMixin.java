package intellij_awk.psi.impl;

import com.intellij.lang.ASTNode;
import com.intellij.navigation.ItemPresentation;
import com.intellij.psi.PsiComment;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiWhiteSpace;
import intellij_awk.AwkIcons;
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
    return "(" + String.join(", ", getArgumentNames()) + ")";
  }

  /** @return argument names excluding "local" */
  public List<String> getArgumentNames() {
    List<String> result = new ArrayList<>();
    AwkItem awkItem = (AwkItem) getParent();
    AwkParamList awkParamList = awkItem.getParamList();
    if_block:
    if (awkParamList != null) {
      PsiElement prevSibling = awkParamList.getPrevSibling();
      if (isWhitespaceBeforeLocals(prevSibling)) { // all args are local
        break if_block;
      }
      PsiElement psiElement = awkParamList.getFirstChild();
      while (psiElement != null) {
        if (psiElement instanceof AwkUserVarName) {
          result.add(psiElement.getText());
        } else if (isWhitespaceBeforeLocals(psiElement)) { // locals started
          break;
        }
        psiElement = psiElement.getNextSibling();
      }
    }
    return result;
  }

  public List<String> getArgumentNamesIncludingLocals() {
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

  private boolean isWhitespaceBeforeLocals(PsiElement psiElement) {
    if (psiElement instanceof PsiWhiteSpace || psiElement instanceof PsiComment) {
      return psiElement instanceof PsiWhiteSpace && psiElement.getTextLength() >= 3
          || psiElement instanceof PsiComment && psiElement.textMatches("\\\n")
          || isWhitespaceBeforeLocals(psiElement.getPrevSibling());
    }

    return false;
  }
}
