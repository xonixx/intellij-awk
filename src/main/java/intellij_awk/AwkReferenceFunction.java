package intellij_awk;

import com.intellij.openapi.util.TextRange;
import com.intellij.psi.*;
import com.intellij.util.IncorrectOperationException;
import intellij_awk.psi.AwkNamedElement;
import intellij_awk.psi.impl.AwkFunctionNameImpl;

import java.util.*;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

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

    Set<PsiFile> seenFiles = new HashSet<>();

    for (AwkFunctionNameImpl functionName : functionNames) {
      PsiFile file = functionName.getContainingFile();
      // only reference first found function in file, all others will be dups
      if (seenFiles.contains(file)) {
        continue;
      }
      seenFiles.add(file);
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

  /**
   * See: <a
   * href="https://intellij-support.jetbrains.com/hc/en-us/community/posts/206116059-ReferencesSearch-PsiPolyVariantReferences">link</a>
   */
  @Override
  public boolean isReferenceTo(@NotNull PsiElement element) {
    PsiManager manager = getElement().getManager();
    return Arrays.stream(multiResolve(false))
        .anyMatch(
            resolveResult -> manager.areElementsEquivalent(resolveResult.getElement(), element));
  }

  @Override
  public PsiElement handleElementRename(@NotNull String newElementName)
      throws IncorrectOperationException {
    return myElement.setName(newElementName);
  }
}
