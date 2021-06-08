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
import java.util.List;

public class AwkReferenceVariable extends PsiReferenceBase<AwkUserVarNameImpl>
    implements PsiPolyVariantReference {

  public AwkReferenceVariable(@NotNull AwkUserVarNameImpl element, TextRange rangeInElement) {
    super(element, rangeInElement);
  }

  @Override
  public ResolveResult @NotNull [] multiResolve(boolean incompleteCode) {
    List<ResolveResult> res = new ArrayList<>();

    Resolved ref = resolveFunctionArgument(myElement);
    if (ref == null) {
      ref = resolveGlobalVariable(myElement);
    }
    if (ref == null) {
      ref = resolveImplicitGlobalVar(myElement);
    }
    if (ref != null && ref.value != null) {
      res.add(new PsiElementResolveResult(ref.value));
    }
    return res.toArray(new ResolveResult[0]);
  }

  private Resolved resolveImplicitGlobalVar(AwkUserVarNameImpl userVarName) {
    PsiElement parent = userVarName;
    while (true) {
      parent = parent.getParent();
      if (parent == null || parent instanceof AwkFile) {
        break;
      }
      if (parent instanceof AwkItemImpl) {
        AwkItemImpl awkItem = (AwkItemImpl) parent;
        if (awkItem.getFunctionName() != null) {
          Resolved resolved = resolveInAction(awkItem.getAction(), userVarName);
          if (resolved != null) {
            return resolved;
          }
        }
      }
    }
    return null;
  }

  private @Nullable Resolved resolveFunctionArgument(AwkUserVarNameImpl userVarName) {
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

  private Resolved resolveGlobalVariable(AwkUserVarNameImpl userVarName) {
    AwkFile awkFile = (AwkFile) userVarName.getContainingFile();

    for (PsiElement child : awkFile.getChildren()) {
      if (child instanceof AwkItem) {
        AwkItem awkItem = (AwkItem) child;
        AwkPattern pattern = awkItem.getPattern();
        if (pattern != null) {
          if (AwkUtil.isAwkBegin(pattern.getBeginOrEnd())) {
            Resolved resolved = resolveInAction(awkItem.getAction(), userVarName);
            if (resolved != null) {
              return resolved;
            }
          }
        }
      }
    }

    return null;
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

  private @Nullable Resolved resolveInAction(AwkAction action, AwkUserVarNameImpl userVarName) {
    PsiElement varDeclaration =
        AwkUtil.findFirstMatchedDeep(
            action,
            psiElement ->
                psiElement instanceof AwkUserVarName
                    && ((AwkUserVarName) psiElement)
                        .getVarName()
                        .textMatches(userVarName.getName()));
    if (varDeclaration != null) {
      if (varDeclaration == userVarName) {
        return new Resolved(null); // no need to display a reference to itself
      }
      return new Resolved(varDeclaration);
    }

    return null;
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
