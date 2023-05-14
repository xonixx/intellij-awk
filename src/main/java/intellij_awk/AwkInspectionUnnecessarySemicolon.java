package intellij_awk;

import com.intellij.codeInspection.*;
import com.intellij.codeInspection.util.IntentionFamilyName;
import com.intellij.openapi.project.Project;
import com.intellij.psi.PsiElementVisitor;
import intellij_awk.psi.AwkSemicolonPsi;
import intellij_awk.psi.AwkVisitor;
import org.jetbrains.annotations.NotNull;

public class AwkInspectionUnnecessarySemicolon extends LocalInspectionTool {

  private static final DeleteUnnecessarySemicolonQuickFix deleteUnnecessarySemicolonQuickFix =
      new DeleteUnnecessarySemicolonQuickFix();
  public static final String QUICK_FIX_NAME = "Remove unnecessary semicolon";

  @Override
  public @NotNull PsiElementVisitor buildVisitor(
      @NotNull ProblemsHolder holder, boolean isOnTheFly) {

    return new AwkVisitor() {
      @Override
      public void visitSemicolonPsi(@NotNull AwkSemicolonPsi semicolonPsi) {
        /*holder.registerProblem(
            functionName,
            "Unnecessary semicolon ';'",
            ProblemHighlightType.LIKE_UNUSED_SYMBOL,
            deleteUnnecessarySemicolonQuickFix);*/
      }
    };
  }

  private static class DeleteUnnecessarySemicolonQuickFix implements LocalQuickFix {

    @Override
    public @IntentionFamilyName @NotNull String getFamilyName() {
      return QUICK_FIX_NAME;
    }

    @Override
    public void applyFix(@NotNull Project project, @NotNull ProblemDescriptor descriptor) {
      descriptor.getPsiElement().delete();
    }
  }
}
