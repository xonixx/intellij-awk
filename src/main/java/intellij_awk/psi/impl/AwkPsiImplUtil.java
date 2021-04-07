package intellij_awk.psi.impl;

import com.intellij.lang.ASTNode;
import com.intellij.navigation.ItemPresentation;
import com.intellij.psi.PsiElement;
import intellij_awk.AwkIcons;
import intellij_awk.SimpleIcons;
import intellij_awk.psi.AwkProperty;
import intellij_awk.psi.SimpleElementFactory;
import intellij_awk.psi.SimpleProperty;
import intellij_awk.psi.SimpleTypes;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;

public class AwkPsiImplUtil {
  public static ItemPresentation getPresentation(final AwkProperty element) {
    return new ItemPresentation() {
      @Nullable
      @Override
      public String getPresentableText() {
        return "TODO";//element.getKey();
      } // TODO

      @Nullable
      @Override
      public String getLocationString() {
        return element.getContainingFile().getName();
      }

      @Nullable
      @Override
      public Icon getIcon(boolean unused) {
        return AwkIcons.FILE;
      }
    };
  }
}
