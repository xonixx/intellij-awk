package intellij_awk;

import com.intellij.codeInspection.LocalInspectionTool;
import com.intellij.codeInspection.LocalQuickFix;
import com.intellij.codeInspection.ProblemDescriptor;
import com.intellij.codeInspection.ProblemsHolder;
import com.intellij.codeInspection.util.IntentionFamilyName;
import com.intellij.openapi.project.Project;
import com.intellij.psi.PsiElementVisitor;
import intellij_awk.psi.AwkUserVarName;
import intellij_awk.psi.AwkUserVarNameMixin;
import intellij_awk.psi.AwkVisitor;
import org.jetbrains.annotations.NotNull;

public class AwkInspectionUnusedGlobalVariable extends LocalInspectionTool {

  private static final DeleteUnusedGlobalVariableQuickFix deleteUnusedGlobalVariableQuickFix =
      new DeleteUnusedGlobalVariableQuickFix();
  public static final String QUICK_FIX_NAME = "Delete unused global variable";

  @Override
  public @NotNull PsiElementVisitor buildVisitor(
      @NotNull ProblemsHolder holder, boolean isOnTheFly) {
    return new AwkVisitor() {
      @Override
      public void visitUserVarName(@NotNull AwkUserVarName userVarName) {
        AwkUserVarNameMixin userVarNameMixin = (AwkUserVarNameMixin) userVarName;
        if (userVarNameMixin.isDeclaration()) {
          
        }

        /*
                AwkFunctionNameMixin functionName = (AwkFunctionNameMixin) awkItem.getFunctionName();
                if (functionName != null) {
                  Query<PsiReference> functionReferences = ReferencesSearch.search(functionName);
                  if (!functionReferences.iterator().hasNext()) {
                    holder.registerProblem(
                        functionName,
                        "Function '" + functionName.getName() + "()' is never used",
                        ProblemHighlightType.LIKE_UNUSED_SYMBOL,
                            deleteUnusedGlobalVariableQuickFix);
                  }
                }
        */
      }
    };
  }

  private static class DeleteUnusedGlobalVariableQuickFix implements LocalQuickFix {

    @Override
    public @IntentionFamilyName @NotNull String getFamilyName() {
      return QUICK_FIX_NAME;
    }

    @Override
    public void applyFix(@NotNull Project project, @NotNull ProblemDescriptor descriptor) {
      //      AwkUtil.findParent(descriptor.getPsiElement(), AwkItem.class).delete();
    }
  }
}
