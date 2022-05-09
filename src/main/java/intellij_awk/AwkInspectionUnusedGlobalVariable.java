package intellij_awk;

import com.intellij.codeInspection.*;
import com.intellij.codeInspection.util.IntentionFamilyName;
import com.intellij.openapi.project.Project;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.PsiReference;
import com.intellij.psi.search.searches.ReferencesSearch;
import com.intellij.util.Query;
import intellij_awk.psi.*;
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
          Query<PsiReference> references = ReferencesSearch.search(userVarNameMixin);
          if (!references.iterator().hasNext()
              && userVarNameMixin.getReference().resolve() == null) {
            holder.registerProblem(
                userVarNameMixin,
                "Global variable '" + userVarNameMixin.getName() + "' is never used",
                ProblemHighlightType.LIKE_UNUSED_SYMBOL,
                deleteUnusedGlobalVariableQuickFix);
          }
        }
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
      PsiElement statement =
          AwkUtil.findParent(descriptor.getPsiElement(), AwkTerminatedStatement.class);
      if (statement == null) {
        statement = AwkUtil.findParent(descriptor.getPsiElement(), AwkUnterminatedStatement.class);
      }
      statement.delete();
    }
  }
}
