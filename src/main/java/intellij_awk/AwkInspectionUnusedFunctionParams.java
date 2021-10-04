package intellij_awk;

import com.intellij.codeInspection.*;
import com.intellij.codeInspection.util.IntentionFamilyName;
import com.intellij.openapi.project.Project;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiElementVisitor;
import intellij_awk.psi.*;
import org.jetbrains.annotations.NotNull;

import java.util.List;

public class AwkInspectionUnusedFunctionParams extends LocalInspectionTool {

  private static final DeleteUnusedFunctionParamQuickFix deleteUnusedFunctionParamQuickFix =
      new DeleteUnusedFunctionParamQuickFix();

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
      return "Delete unused function param";
    }

    @Override
    public void applyFix(@NotNull Project project, @NotNull ProblemDescriptor descriptor) {
      AwkUserVarNameMixin paramName = (AwkUserVarNameMixin) descriptor.getPsiElement();
      paramName.delete();
    }
  }

  private void bbb() {
    aaa("sadf");
  }

  private void aaa(String a) {}
}
