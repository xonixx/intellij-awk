package intellij_awk;

import com.intellij.codeInspection.*;
import com.intellij.codeInspection.util.IntentionFamilyName;
import com.intellij.openapi.project.Project;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.PsiReference;
import com.intellij.psi.search.GlobalSearchScope;
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

    if (GlobalSearchScope.projectScope(holder.getProject())
        .contains(holder.getFile().getVirtualFile())) {
      return new AwkVisitor() {
        @Override
        public void visitItem(@NotNull AwkItem awkItem) {
          AwkFunctionNameMixin functionName = (AwkFunctionNameMixin) awkItem.getFunctionName();
          if (functionName != null && !existNonRecursiveReferences(functionName)) {
            holder.registerProblem(
                functionName,
                "Function '" + functionName.getName() + "()' is never used",
                ProblemHighlightType.LIKE_UNUSED_SYMBOL,
                deleteUnusedFunctionQuickFix);
          }
        }
      };
    }
    return new AwkVisitor();
  }

  private boolean existNonRecursiveReferences(AwkFunctionNameMixin functionName) {
    Query<PsiReference> functionReferences = ReferencesSearch.search(functionName);
    for (PsiReference functionReference : functionReferences) {
      if (!isRecursive(functionReference.getElement(), functionName)) {
        return true;
      }
    }
    return false;
  }

  private boolean isRecursive(PsiElement functionCall, AwkFunctionNameMixin functionName) {
    return AwkUtil.findParent(functionCall, AwkItem.class)
        .equals(AwkUtil.findParent(functionName, AwkItem.class));
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
}
