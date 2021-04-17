package intellij_awk.psi.impl;

import com.intellij.icons.AllIcons;
import com.intellij.lang.ASTNode;
import com.intellij.navigation.ItemPresentation;
import com.intellij.psi.PsiElement;
import com.intellij.psi.tree.IElementType;
import intellij_awk.AwkIcons;
import intellij_awk.psi.AwkFunctionName;
import intellij_awk.psi.AwkItem;
import intellij_awk.psi.AwkPattern;
import intellij_awk.psi.AwkTypes;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;

public abstract class AwkItemMixin extends AwkNamedElementImpl implements AwkItem {
  public AwkItemMixin(@NotNull ASTNode node) {
    super(node);
  }

  public boolean isFunction() {
    return getFunctionName() != null;
  }

  @Override
  public void navigate(boolean requestFocus) {
    AwkFunctionName functionName = getFunctionName();
    if (functionName != null) {
      ((AwkFunctionNameMixin) functionName).navigate(requestFocus);
    } else {
      super.navigate(requestFocus);
    }
  }

  public String getItemName() {
    PsiElement nameIdentifier = getNameIdentifier();
    return nameIdentifier != null ? nameIdentifier.getText() : "???";
  }

  public String getName() {
    return getItemName();
  }

  public PsiElement setName(String newName) {
    throw new UnsupportedOperationException("TBD");
  }

  public PsiElement getNameIdentifier() {
    PsiElement nameElement = null;
    AwkFunctionName functionName = getFunctionName();
    if (functionName != null) {
      nameElement = functionName.getFirstChild();
    }
    if (nameElement != null) {
      return nameElement;
    } else {
      AwkPattern pattern = getPattern();
      if (pattern != null) {
        PsiElement firstChild = pattern.getFirstChild();
        IElementType elementType = firstChild.getNode().getElementType();
        if (AwkTypes.BEGIN.equals(elementType) || AwkTypes.END.equals(elementType))
          return firstChild;
      }
    }
    return null;
  }

  public ItemPresentation getPresentation() {
    return new ItemPresentation() {
      @Nullable
      @Override
      public String getPresentableText() {
        return getItemName();
      }

      @Nullable
      @Override
      public String getLocationString() {
        return getContainingFile().getName();
      }

      @Nullable
      @Override
      public Icon getIcon(boolean unused) {
        return isFunction() ? AllIcons.Nodes.Function : AwkIcons.FILE;
      }
    };
  }
}
