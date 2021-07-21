package intellij_awk;

import com.intellij.openapi.util.TextRange;
import com.intellij.psi.*;
import com.intellij.util.IncorrectOperationException;
import intellij_awk.psi.*;
import intellij_awk.psi.impl.AwkItemImpl;
import intellij_awk.psi.impl.AwkUserVarNameImpl;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class AwkReferenceVariable extends PsiReferenceBase<AwkNamedElement>
    implements PsiPolyVariantReference {

  public AwkReferenceVariable(@NotNull AwkNamedElement element, TextRange rangeInElement) {
    super(element, rangeInElement);
  }

  @Override
  public ResolveResult @NotNull [] multiResolve(boolean incompleteCode) {
    List<ResolveResult> res = new ArrayList<>();

    // resolve current function argument
    Resolved ref = resolveFunctionArgument(myElement);
    if (ref == null) {
      // resolve `Var = ...` and `split("",Var)` in current file TODO shall this be inside begin?
      ref = resolveGlobalVariableInCurrentFile(myElement);
    }
    if (ref == null) {
      // resolve `Var = ...` and `split("",Var)` in other files (= in all files)
      ref = resolveGlobalVariableInProjectFiles(true, myElement);
    }
    if (ref == null) {
      // resolve `Var` across all files
      ref = resolveGlobalVariableInProjectFiles(false, myElement);
    }
    if (ref != null && ref.value != null) {
      res.add(new PsiElementResolveResult(ref.value));
    }
    return res.toArray(new ResolveResult[0]);
  }

  private @Nullable Resolved resolveFunctionArgument(AwkNamedElement userVarName) {
    PsiElement parent = userVarName;
    while (true) {
      parent = parent.getParent();
      if (parent == null || parent instanceof AwkFile) {
        break;
      }
      if (parent instanceof AwkItemImpl) {
        AwkItemImpl awkItem = (AwkItemImpl) parent;
        if (awkItem.getFunctionName() != null) {
          AwkParamList paramList = awkItem.getParamList();
          if (paramList != null) {
            List<AwkUserVarName> userVarNameList = paramList.getUserVarNameList();
            for (AwkUserVarName awkUserVarName : userVarNameList) {
              PsiElement varName = awkUserVarName.getVarName();
              if (varName.textMatches(userVarName.getName())) {
                if (awkUserVarName == userVarName) {
                  return new Resolved(null); // no need to display a reference to itself
                }
                return new Resolved(awkUserVarName);
              }
            }
          }
        }
      }
    }
    return null;
  }

  private Resolved resolveGlobalVariableInCurrentFile(AwkNamedElement userVarName) {
    AwkFile awkFile = (AwkFile) userVarName.getContainingFile();

    Resolved resolved = null;
    PsiElement varDeclaration =
        AwkUtil.findFirstMatchedDeep(
            awkFile,
            psiElement ->
                psiElement instanceof AwkUserVarName
                    && ((AwkUserVarName) psiElement).getVarName().textMatches(userVarName.getName())
                    && ((AwkUserVarNameMixin) psiElement).looksLikeDeclaration());
    if (varDeclaration != null) {
      if (varDeclaration == userVarName) {
        resolved = new Resolved(null); // no need to display a reference to itself
      } else {
        resolved = new Resolved(varDeclaration);
      }
    }

    return resolved;
  }

  private @Nullable Resolved resolveGlobalVariableInProjectFiles(
      boolean searchDeclarations, AwkNamedElement userVarName) {
    Collection<AwkUserVarNameImpl> userVarDeclarations =
        AwkUtil.findUserVars(searchDeclarations, userVarName.getProject(), userVarName.getName());
    Resolved resolved = null;
    if (!userVarDeclarations.isEmpty()) {
      AwkUserVarNameImpl found = userVarDeclarations.iterator().next();
      if (found == userVarName) {
        resolved = new Resolved(null); // no need to display a reference to itself
      } else {
        resolved = new Resolved(found);
      }
    }
    return resolved;
  }

  /**
   *
   * <li>resolved == null : proceed resolution
   * <li>resolved != null : use as resolved result
   */
  private static class Resolved {
    private final PsiElement value;

    public Resolved(PsiElement value) {
      this.value = value;
    }
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
