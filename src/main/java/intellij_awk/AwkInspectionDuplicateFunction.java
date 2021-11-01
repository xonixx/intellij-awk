package intellij_awk;

import com.intellij.codeInspection.LocalInspectionTool;
import com.intellij.codeInspection.ProblemHighlightType;
import com.intellij.codeInspection.ProblemsHolder;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.PsiReference;
import com.intellij.psi.search.searches.ReferencesSearch;
import com.intellij.util.Query;
import intellij_awk.psi.AwkFunctionNameMixin;
import intellij_awk.psi.AwkItem;
import intellij_awk.psi.AwkVisitor;
import org.jetbrains.annotations.NotNull;

public class AwkInspectionDuplicateFunction extends LocalInspectionTool {

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
                ProblemHighlightType.LIKE_UNUSED_SYMBOL);
          }
        }
      }
    };
  }
}
