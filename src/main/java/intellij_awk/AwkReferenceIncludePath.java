package intellij_awk;

import com.intellij.openapi.util.TextRange;
import com.intellij.openapi.vfs.VirtualFile;
import com.intellij.psi.*;
import com.intellij.util.IncorrectOperationException;
import intellij_awk.psi.impl.AwkNamedElementImpl;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public class AwkReferenceIncludePath extends PsiReferenceBase<AwkNamedElementImpl>
    implements PsiPolyVariantReference {

  private static final String AWK_EXT = ".awk";

  public AwkReferenceIncludePath(@NotNull AwkNamedElementImpl element, TextRange rangeInElement) {
    super(element, rangeInElement);
  }

  @Override
  public ResolveResult @NotNull [] multiResolve(boolean incompleteCode) {
    String importText = myElement.getText();
    if (importText.length() < 2) {
      return ResolveResult.EMPTY_ARRAY;
    }
    String path = importText.substring(1, importText.length() - 1);
    if (!path.endsWith(AWK_EXT)) {
      path = path + AWK_EXT;
    }
    VirtualFile virtualFile = myElement.getContainingFile().getOriginalFile().getVirtualFile();
    VirtualFile includedFile = null;

    VirtualFile parent = virtualFile;
    while ((parent = parent.findFileByRelativePath("..")) != null) {
      includedFile = parent.findFileByRelativePath(path);
      if (includedFile != null) {
        break;
      }
    }
    if (includedFile == null) {
      return ResolveResult.EMPTY_ARRAY;
    }

    PsiFile psiFile = PsiManager.getInstance(myElement.getProject()).findFile(includedFile);

    return new ResolveResult[] {new PsiElementResolveResult(psiFile)};
  }

  /** Resolves references to a single result, or fails. */
  @Override
  public @Nullable PsiElement resolve() {
    ResolveResult[] resolveResults = multiResolve(false);
    return resolveResults.length == 1 ? resolveResults[0].getElement() : null;
  }

  @Override
  public PsiElement handleElementRename(@NotNull String newElementName)
      throws IncorrectOperationException {
    return myElement.setName(newElementName);
  }
}
