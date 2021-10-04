package intellij_awk;

import com.intellij.codeInspection.*;
import com.intellij.codeInspection.util.IntentionFamilyName;
import com.intellij.openapi.project.Project;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.PsiReference;
import com.intellij.psi.search.searches.ReferencesSearch;
import com.intellij.util.Query;
import intellij_awk.psi.AwkFunctionNameMixin;
import intellij_awk.psi.AwkItem;
import intellij_awk.psi.AwkVisitor;
import org.jetbrains.annotations.NotNull;

public class AwkInspectionUnusedFunction extends LocalInspectionTool {

  private static final DeleteUnusedFunctionQuickFix deleteUnusedFunctionQuickFix =
      new DeleteUnusedFunctionQuickFix();
  public static final String QUICK_FIX_NAME = "Delete unused function";

  @Override
  public @NotNull PsiElementVisitor buildVisitor(
      @NotNull ProblemsHolder holder, boolean isOnTheFly) {
    return new AwkVisitor() {
      @Override
      public void visitItem(@NotNull AwkItem awkItem) {
        AwkFunctionNameMixin functionName = (AwkFunctionNameMixin) awkItem.getFunctionName();
        if (functionName != null) {
          Query<PsiReference> functionReferences = ReferencesSearch.search(functionName);
          if (!functionReferences.iterator().hasNext()) {
            holder.registerProblem(
                functionName,
                "Function '" + functionName.getName() + "()' is never used",
                ProblemHighlightType.LIKE_UNUSED_SYMBOL,
                deleteUnusedFunctionQuickFix);
          }
        }
      }
    };
  }

  private static class DeleteUnusedFunctionQuickFix implements LocalQuickFix {

    @Override
    public @IntentionFamilyName @NotNull String getFamilyName() {
      return QUICK_FIX_NAME;
    }

    @Override
    public void applyFix(@NotNull Project project, @NotNull ProblemDescriptor descriptor) {
      AwkUtil.findParent(descriptor.getPsiElement(), AwkItem.class).delete();
    }
  }

  private void unused1() {}
}
