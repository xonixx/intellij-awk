package intellij_awk;

import com.intellij.codeInspection.*;
import com.intellij.codeInspection.util.IntentionFamilyName;
import com.intellij.openapi.project.Project;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.PsiReference;
import com.intellij.psi.ResolveResult;
import intellij_awk.psi.AwkFunctionCallName;
import intellij_awk.psi.AwkVisitor;
import org.jetbrains.annotations.NotNull;

public class AwkInspectionUnresolvedFunction extends LocalInspectionTool {

  private static final CreateNewFunctionQuickFix CREATE_NEW_FUNCTION_QUICK_FIX =
      new CreateNewFunctionQuickFix();
  public static final String QUICK_FIX_NAME = "Create new function with this name";

  @Override
  public @NotNull PsiElementVisitor buildVisitor(
      @NotNull ProblemsHolder holder, boolean isOnTheFly) {
    return new AwkVisitor() {
      @Override
      public void visitFunctionCallName(@NotNull AwkFunctionCallName functionCallName) {
        PsiReference reference = functionCallName.getReference();
        if (reference instanceof AwkReferenceFunction) {
          AwkReferenceFunction referenceFunction = (AwkReferenceFunction) reference;
          ResolveResult[] resolveResults = referenceFunction.multiResolve(false);
          if (resolveResults.length == 0) {
            holder.registerProblem(
                functionCallName,
                "Cannot resolve function '" + functionCallName.getName() + "'",
                ProblemHighlightType.GENERIC_ERROR,
                CREATE_NEW_FUNCTION_QUICK_FIX);
          }
        }
      }
    };
  }

  private static class CreateNewFunctionQuickFix implements LocalQuickFix {

    @Override
    public @IntentionFamilyName @NotNull String getFamilyName() {
      return QUICK_FIX_NAME;
    }

    @Override
    public void applyFix(@NotNull Project project, @NotNull ProblemDescriptor descriptor) {
      throw new UnsupportedOperationException("TODO");
    }
  }
}
