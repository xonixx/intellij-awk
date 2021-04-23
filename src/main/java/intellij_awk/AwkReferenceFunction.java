package intellij_awk;

import com.intellij.openapi.util.TextRange;
import com.intellij.psi.*;
import intellij_awk.psi.AwkFile;
import intellij_awk.psi.AwkFunctionName;
import intellij_awk.psi.AwkItem;
import intellij_awk.psi.impl.AwkFunctionCallNameImpl;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.ArrayList;
import java.util.List;

public class AwkReferenceFunction extends PsiReferenceBase<AwkFunctionCallNameImpl> implements PsiPolyVariantReference {

  public AwkReferenceFunction(@NotNull AwkFunctionCallNameImpl element, TextRange rangeInElement) {
    super(element, rangeInElement);
  }

  @Override
  public ResolveResult @NotNull [] multiResolve(boolean incompleteCode) {
    List<ResolveResult> res = new ArrayList<>();

    AwkFile awkFile = (AwkFile) myElement.getContainingFile();

    for (PsiElement child : awkFile.getChildren()) {
      if (child instanceof AwkItem) {
        AwkItem awkItem = (AwkItem) child;
        AwkFunctionName functionName = awkItem.getFunctionName();
        if (functionName != null && myElement.getText().equals(functionName.getName())) {
          res.add(new PsiElementResolveResult(functionName));
        }
      }
    }

    return res.toArray(new ResolveResult[0]);
  }

  /** Resolves references to a single result, or fails. */
  @Override
  public @Nullable PsiElement resolve() {
    ResolveResult[] resolveResults = multiResolve(false);
    return resolveResults.length == 1 ? resolveResults[0].getElement() : null;
  }
}
