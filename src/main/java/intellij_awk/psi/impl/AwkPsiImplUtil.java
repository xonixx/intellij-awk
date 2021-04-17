package intellij_awk.psi.impl;

import com.intellij.icons.AllIcons;
import com.intellij.navigation.ItemPresentation;
import com.intellij.psi.PsiElement;
import com.intellij.psi.tree.IElementType;
import intellij_awk.AwkIcons;
import intellij_awk.psi.AwkItem;
import intellij_awk.psi.AwkPattern;
import intellij_awk.psi.AwkTypes;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;

public class AwkPsiImplUtil {
  public static boolean isFunction(AwkItem awkItem) {
    return awkItem.getFuncName() != null || awkItem.getVarName() != null;
  }

  public static String getItemName(AwkItem awkItem) {
    PsiElement nameIdentifier = getNameIdentifier(awkItem);
    return nameIdentifier != null ? nameIdentifier.getText() : "???";
  }

  public static String getName(AwkItem awkItem) {
    return getItemName(awkItem);
  }

  public static PsiElement setName(AwkItem awkItem, String newName) {
    throw new UnsupportedOperationException("TBD");
  }

  public static PsiElement getNameIdentifier(AwkItem awkItem) {
    PsiElement nameElement = awkItem.getFuncName();
    if (nameElement == null) {
      nameElement = awkItem.getVarName();
    }
    if (nameElement != null) {
      return nameElement;
    } else {
      AwkPattern pattern = awkItem.getPattern();
      if (pattern != null) {
        PsiElement firstChild = pattern.getFirstChild();
        IElementType elementType = firstChild.getNode().getElementType();
        if (AwkTypes.BEGIN.equals(elementType) || AwkTypes.END.equals(elementType))
          return firstChild;
      }
    }
    return null;
  }

  public static ItemPresentation getPresentation(final AwkItem awkItem) {
    return new ItemPresentation() {
      @Nullable
      @Override
      public String getPresentableText() {
        return awkItem.getItemName();
      }

      @Nullable
      @Override
      public String getLocationString() {
        return awkItem.getContainingFile().getName();
      }

      @Nullable
      @Override
      public Icon getIcon(boolean unused) {
        return awkItem.isFunction() ? AllIcons.Nodes.Function : AwkIcons.FILE;
      }
    };
  }
}
