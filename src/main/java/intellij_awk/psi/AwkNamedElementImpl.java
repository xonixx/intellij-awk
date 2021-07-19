package intellij_awk.psi;

import com.intellij.extapi.psi.ASTWrapperPsiElement;
import com.intellij.lang.ASTNode;
import com.intellij.navigation.ItemPresentation;
import com.intellij.openapi.diagnostic.Logger;
import com.intellij.openapi.util.NlsSafe;
import com.intellij.openapi.util.TextRange;
import com.intellij.psi.PsiElement;
import com.intellij.util.IncorrectOperationException;
import intellij_awk.AwkIcons;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;

public abstract class AwkNamedElementImpl extends ASTWrapperPsiElement implements AwkNamedElement {

  //  private static final Logger LOG = Logger.getInstance(AwkNamedElementImpl.class);

  public AwkNamedElementImpl(@NotNull ASTNode node) {
    super(node);
  }

  @Override
  public String getName() {
    return getNameIdentifier().getText();
  }
  /*
    protected PsiElement replaceNameNode(PsiElement newNode) {
      if (newNode != null) {
        replace(newNode);
      } else {
        LOG.warn("Unable to replace renamed node, because it's null");
      }
      return this;
    }
  */

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
        return AwkNamedElementImpl.this.getIcon(1);
      }
    };
  }

  @Override
  public @Nullable Icon getIcon(int flags) {
    return AwkIcons.FILE;
  }
}
