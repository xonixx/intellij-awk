package intellij_awk;

import com.intellij.openapi.util.TextRange;
import com.intellij.psi.*;
import com.intellij.util.IncorrectOperationException;
import intellij_awk.psi.impl.AwkFunctionNameImpl;
import intellij_awk.psi.AwkNamedElementImpl;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.ArrayList;
import java.util.List;

public class AwkReferenceFunction extends PsiReferenceBase<AwkNamedElementImpl>
    implements PsiPolyVariantReference {

  public AwkReferenceFunction(@NotNull AwkNamedElementImpl element, TextRange rangeInElement) {
    super(element, rangeInElement);
  }

  @Override
  public ResolveResult @NotNull [] multiResolve(boolean incompleteCode) {
    List<ResolveResult> res = new ArrayList<>();

    List<AwkFunctionNameImpl> functionNames =
        AwkUtil.findFunctions(myElement.getProject(), myElement.getText());

    for (AwkFunctionNameImpl functionName : functionNames) {
      res.add(new PsiElementResolveResult(functionName));
    }

    return res.toArray(new ResolveResult[0]);
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
