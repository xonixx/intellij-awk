package intellij_awk;

import com.intellij.codeInspection.*;
import com.intellij.codeInspection.util.IntentionFamilyName;
import com.intellij.openapi.project.Project;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.PsiNamedElement;
import com.intellij.psi.PsiReference;
import com.intellij.psi.search.searches.ReferencesSearch;
import com.intellij.util.Query;
import intellij_awk.psi.*;
import org.jetbrains.annotations.NotNull;

import java.util.List;
import java.util.Set;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import static intellij_awk.AwkUtil.isType;

/**
 *
 *
 * <ul>
 *   <li>Always define locals starting with a lower case letter
 *   <li>Always define globals as MixedCase starting an Uppercase letter
 * </ul>
 */
public class AwkInspectionVariablesNaming extends LocalInspectionTool {

  private static final DeleteUnusedFunctionParamQuickFix deleteUnusedFunctionParamQuickFix =
      new DeleteUnusedFunctionParamQuickFix();
  public static final String QUICK_FIX_DECLARE_LOCAL = "Declare as local variable";
  private static final Pattern lcLetterFirst = Pattern.compile("^[a-z]");

  @Override
  public @NotNull PsiElementVisitor buildVisitor(
      @NotNull ProblemsHolder holder, boolean isOnTheFly) {
    return new AwkVisitor() {
      @Override
      public void visitItem(@NotNull AwkItem awkItem) {
        if (awkItem.getFunction() != null) {
          AwkParamList paramList = awkItem.getParamList();
          List<AwkUserVarName> paramNameList =
              paramList == null ? List.of() : paramList.getUserVarNameList();
          Set<String> paramNames =
              paramNameList.stream().map(PsiNamedElement::getName).collect(Collectors.toSet());
          List<PsiElement> varsInFuncBody = AwkUtil.findUserVars(awkItem.getAction());

          for (PsiElement psiElement : varsInFuncBody) {
            String varName = psiElement.getText();
            if (startsWithLowercaseLetter(varName) && !paramNames.contains(varName)) {
              holder.registerProblem(
                  psiElement,
                  "Variable '"
                      + varName
                      + "' name starts with lowercase, so this variable should be local",
                  ProblemHighlightType.WARNING /*,
                      deleteUnusedFunctionParamQuickFix*/);
            }
          }

          /*for (AwkUserVarName paramName : paramNameList) {
            List<PsiElement> userVars = AwkUtil.findUserVars(awkItem.getAction());
            for (PsiElement userVar : userVars) {
              if (userVar.getText().equals(paramName.getName())) {
                return;
              }
            }

            holder.registerProblem(
                paramName,
                "Parameter '" + paramName.getName() + "' is never used",
                ProblemHighlightType.LIKE_UNUSED_SYMBOL,
                deleteUnusedFunctionParamQuickFix);
          }*/
        }
      }
    };
  }

  private boolean startsWithLowercaseLetter(String string) {
    return lcLetterFirst.matcher(string).matches();
  }

  private static class DeleteUnusedFunctionParamQuickFix implements LocalQuickFix {

    @Override
    public @IntentionFamilyName @NotNull String getFamilyName() {
      return QUICK_FIX_DECLARE_LOCAL;
    }

    @Override
    public void applyFix(@NotNull Project project, @NotNull ProblemDescriptor descriptor) {
      AwkUserVarNameMixin paramName = (AwkUserVarNameMixin) descriptor.getPsiElement();
      AwkParamList paramList = (AwkParamList) paramName.getParent();
      List<AwkUserVarName> varNameList = paramList.getUserVarNameList();

      int paramIndex = -1;
      for (int i = 0; i < varNameList.size(); i++) {
        AwkUserVarName varName = varNameList.get(i);
        if (varName.equals(paramName)) {
          paramIndex = i;
          break;
        }
      }

      AwkItem awkItem = AwkUtil.findParent(paramName, AwkItem.class);
      AwkFunctionNameMixin functionName = (AwkFunctionNameMixin) awkItem.getFunctionName();

      if (functionName != null) {
        Query<PsiReference> functionCallRefs = ReferencesSearch.search(functionName);
        for (PsiReference functionCallRef_ : functionCallRefs) {
          AwkReferenceFunction functionCallRef = (AwkReferenceFunction) functionCallRef_;
          AwkFunctionCallNameMixin functionCallName =
              (AwkFunctionCallNameMixin) functionCallRef.getElement();

          PsiElement possiblyCallArgs =
              AwkUtil.getNextNotWhitespace(
                  functionCallName.getNextSibling() /* ( */) /* args? || ) */;
          if (possiblyCallArgs instanceof AwkGawkFuncCallList) {
            AwkGawkFuncCallList funcCallList = (AwkGawkFuncCallList) possiblyCallArgs;
            List<AwkExpr> exprList = funcCallList.getExprList();
            if (paramIndex < exprList.size()) {
              AwkExpr expr = exprList.get(paramIndex);
              deleteWithNeighborComma(expr);
            }
          }
        }
      }

      deleteWithNeighborComma(paramName);
    }
  }

  private static void deleteWithNeighborComma(PsiElement element) {
    PsiElement next = AwkUtil.getNextNotWhitespace(element);
    if (isType(next, AwkTypes.COMMA)) {
      next.delete();
    } else {
      PsiElement prev = AwkUtil.getPrevNotWhitespace(element);
      if (isType(prev, AwkTypes.COMMA)) {
        prev.delete();
      }
    }
    element.delete();
  }
}
