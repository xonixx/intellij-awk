package intellij_awk;

import com.intellij.openapi.util.TextRange;
import com.intellij.psi.*;
import com.intellij.util.IncorrectOperationException;
import intellij_awk.psi.AwkNamedElement;
import intellij_awk.psi.impl.AwkFunctionNameImpl;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class AwkReferenceFunction extends PsiReferenceBase<AwkNamedElement>
    implements PsiPolyVariantReference {

  public AwkReferenceFunction(@NotNull AwkNamedElement element, TextRange rangeInElement) {
    super(element, rangeInElement);
  }

  @Override
  public ResolveResult @NotNull [] multiResolve(boolean incompleteCode) {
    List<ResolveResult> res = new ArrayList<>();

    String funcName = myElement.getName();

    // should resolve to single function if defined in same file where used
    Collection<AwkFunctionNameImpl> functionNames =
        AwkUtil.findFunctionsInFile(myElement.getContainingFile(), funcName);

    if (functionNames.isEmpty()) {
      functionNames = AwkUtil.findFunctions(myElement.getProject(), funcName);
    }

    for (AwkFunctionNameImpl functionName : functionNames) {
      res.add(new PsiElementResolveResult(functionName));
      break; // only reference first found function to prevent erroneous unused function error
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
