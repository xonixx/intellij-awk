package intellij_awk;

import com.intellij.openapi.util.TextRange;
import com.intellij.psi.*;
import com.intellij.util.IncorrectOperationException;
import intellij_awk.psi.*;
import intellij_awk.psi.impl.AwkItemImpl;
import intellij_awk.psi.impl.AwkUserVarNameImpl;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import static intellij_awk.AwkReferenceVariable.ResolutionMethod.*;

public class AwkReferenceVariable extends PsiReferenceBase<AwkNamedElement>
    implements PsiPolyVariantReference {

  public enum ResolutionMethod {
    /** RESOLVE-ARG */
    FunctionParameter,

    /** RESOLVE-CUR-INIT-DECL */
    InitDeclarationInCurrentFile,

    /** RESOLVE-ALL-INIT-DECL */
    InitDeclarationAll,

    /** RESOLVE-CUR-INIT-VAR */
    InitVariableInCurrentFile,

    /** RESOLVE-CUR-DECL */
    DeclarationInCurrentFile,

    /** RESOLVE-CUR-VAR */
    VariableInCurrentFile
  }

  public AwkReferenceVariable(@NotNull AwkNamedElement element, TextRange rangeInElement) {
    super(element, rangeInElement);
  }

  @Override
  public Resolved.AwkResolvedResult @NotNull [] multiResolve(boolean incompleteCode) {
    List<Resolved.AwkResolvedResult> res = new ArrayList<>();

    Resolved ref = resolveFunctionParameter(FunctionParameter, myElement);
    if (ref == null) {
      ref = resolveInCurrentFile(InitDeclarationInCurrentFile, true, true, myElement);
    }
    if (ref == null) {
      ref = resolveInAllFilesDeclarationsInInit(InitDeclarationAll, myElement);
    }
    if (ref == null) {
      ref = resolveInCurrentFile(InitVariableInCurrentFile, false, true, myElement);
    }
    if (ref == null) {
      ref = resolveInCurrentFile(DeclarationInCurrentFile, true, false, myElement);
    }
    if (ref == null) {
      ref = resolveInCurrentFile(VariableInCurrentFile, false, false, myElement);
    }
    if (ref != null) {
      Resolved.AwkResolvedResult resolvedResult = ref.toResolvedResult();
      if (resolvedResult != null) {
        res.add(resolvedResult);
      }
    }
    return res.toArray(new AwkReferenceVariable.Resolved.AwkResolvedResult[0]);
  }

  private @Nullable Resolved resolveFunctionParameter(
      ResolutionMethod method, AwkNamedElement userVarName) {
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
                  return new Resolved(method, null); // no need to display a reference to itself
                }
                return new Resolved(method, awkUserVarName);
              }
            }
          }
        }
      }
    }
    return null;
  }

  private Resolved resolveInCurrentFile(
      ResolutionMethod method,
      boolean declarations,
      boolean insideInit,
      AwkNamedElement userVarName) {
    AwkFile awkFile = (AwkFile) userVarName.getContainingFile();

    Resolved resolved = null;
    PsiElement varDeclaration =
        AwkUtil.findFirstMatchedDeep(
            awkFile,
            psiElement ->
                psiElement instanceof AwkUserVarName
                    && ((AwkUserVarName) psiElement).getVarName().textMatches(userVarName.getName())
                    && (!declarations || ((AwkUserVarNameMixin) psiElement).looksLikeDeclaration())
                    && (!insideInit
                        || ((AwkUserVarNameMixin) psiElement).isInsideInitializingContext()));
    if (varDeclaration != null) {
      if (varDeclaration == userVarName) {
        resolved = new Resolved(method, null); // no need to display a reference to itself
      } else {
        resolved = new Resolved(method, varDeclaration);
      }
    }

    return resolved;
  }

  private @Nullable Resolved resolveInAllFilesDeclarationsInInit(
      ResolutionMethod method, AwkNamedElement userVarName) {
    Collection<AwkUserVarNameImpl> userVarDeclarations =
        AwkUtil.findUserVarDeclarations(userVarName.getProject(), userVarName.getName());
    Resolved resolved = null;
    if (!userVarDeclarations.isEmpty()) {
      AwkUserVarNameImpl found = userVarDeclarations.iterator().next();
      if (found == userVarName) {
        resolved = new Resolved(method, null); // no need to display a reference to itself
      } else {
        resolved = new Resolved(method, found);
      }
    }
    return resolved;
  }

  /**
   *
   * <li>resolved == null : proceed resolution
   * <li>resolved != null : use as resolved result
   * <li>resolved.value == null : meaning resolved to itself
   */
  public static class Resolved {
    @Nullable private final PsiElement value;
    private final ResolutionMethod method;

    Resolved(ResolutionMethod method, @Nullable PsiElement value) {
      this.method = method;
      this.value = value;
    }

    private AwkResolvedResult toResolvedResult() {
      return value == null ? null : new AwkResolvedResult(method, value);
    }

    public static class AwkResolvedResult extends PsiElementResolveResult {
      public final ResolutionMethod method;

      public AwkResolvedResult(ResolutionMethod method, @NotNull PsiElement element) {
        super(element);
        this.method = method;
      }
    }
  }

  /** Resolves references to a single result, or fails. */
  @Override
  public @Nullable PsiElement resolve() {
    ResolveResult[] resolveResults = multiResolve(false);
    return resolveResults.length == 1 ? resolveResults[0].getElement() : null;
  }

  /** Resolves references to a single result, or fails. */
  public @Nullable AwkReferenceVariable.Resolved.AwkResolvedResult resolveResult() {
    Resolved.AwkResolvedResult[] resolveResults = multiResolve(false);
    return resolveResults.length == 1 ? resolveResults[0] : null;
  }

  @Override
  public PsiElement handleElementRename(@NotNull String newElementName)
      throws IncorrectOperationException {
    return myElement.setName(newElementName);
  }
}
