package intellij_awk;

import com.intellij.codeInspection.*;
import com.intellij.codeInspection.util.IntentionFamilyName;
import com.intellij.openapi.project.Project;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.PsiReference;
import com.intellij.psi.PsiWhiteSpace;
import com.intellij.psi.search.searches.ReferencesSearch;
import com.intellij.util.Query;
import intellij_awk.psi.*;
import org.jetbrains.annotations.NotNull;

import java.util.List;

import static intellij_awk.AwkUtil.isType;

public class AwkInspectionUnusedFunctionParams extends LocalInspectionTool {

  private static final DeleteUnusedFunctionParamQuickFix deleteUnusedFunctionParamQuickFix =
      new DeleteUnusedFunctionParamQuickFix();
  public static final String QUICK_FIX_NAME = "Delete unused parameter";

  @Override
  public @NotNull PsiElementVisitor buildVisitor(
      @NotNull ProblemsHolder holder, boolean isOnTheFly) {
    return new AwkVisitor() {
      @Override
      public void visitItem(@NotNull AwkItem awkItem) {
        AwkParamList paramList = awkItem.getParamList();
        if (paramList != null) {
          List<AwkUserVarName> paramNameList = paramList.getUserVarNameList();
          for (AwkUserVarName paramName : paramNameList) {
            List<PsiElement> userVars = AwkUtil.findUserVars(awkItem.getAction());
            for (PsiElement userVar : userVars) {
              if (userVar.getText().equals(paramName.getName())) return;
            }

            holder.registerProblem(
                paramName,
                "Parameter '" + paramName.getName() + "' is never used",
                ProblemHighlightType.LIKE_UNUSED_SYMBOL,
                deleteUnusedFunctionParamQuickFix);
          }
        }
      }
    };
  }

  private static class DeleteUnusedFunctionParamQuickFix implements LocalQuickFix {

    @Override
    public @IntentionFamilyName @NotNull String getFamilyName() {
      return QUICK_FIX_NAME;
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
    PsiElement nextSibling = element.getNextSibling();
    if (nextSibling != null) {
      if (isType(nextSibling, AwkTypes.COMMA)) {
        nextSibling.delete();
      } else if (nextSibling instanceof PsiWhiteSpace) {
        PsiElement nextNextSibling = nextSibling.getNextSibling();
        if (isType(nextNextSibling, AwkTypes.COMMA)) {
          nextSibling.delete();
          nextNextSibling.delete();
        }
      }
    } else {
      PsiElement prevSibling = element.getPrevSibling();
      if (prevSibling != null) {
        if (isType(prevSibling, AwkTypes.COMMA)) {
          prevSibling.delete();
        } else if (prevSibling instanceof PsiWhiteSpace) {
          PsiElement prevPrevSibling = prevSibling.getPrevSibling();
          if (isType(prevPrevSibling, AwkTypes.COMMA)) {
            prevSibling.delete();
            prevPrevSibling.delete();
          }
        }
      }
    }
    element.delete();
  }
}
