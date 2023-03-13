package intellij_awk;

import com.intellij.codeInspection.*;
import com.intellij.psi.PsiElementVisitor;
import intellij_awk.psi.AwkIncludePath;
import intellij_awk.psi.AwkVisitor;
import org.jetbrains.annotations.NotNull;

public class AwkInspectionUnresolvedInclude extends LocalInspectionTool {
  // TODO implement quick fix that should work with respect to AWKPATH
  // (https://www.gnu.org/software/gawk/manual/html_node/AWKPATH-Variable.html)
  @Override
  public @NotNull PsiElementVisitor buildVisitor(
      @NotNull ProblemsHolder holder, boolean isOnTheFly) {
    return new AwkVisitor() {
      @Override
      public void visitIncludePath(@NotNull AwkIncludePath awkIncludePath) {
        if (awkIncludePath.getReference().resolve() == null) {
          holder.registerProblem(
              awkIncludePath, "Cannot resolve include path", ProblemHighlightType.GENERIC_ERROR);
        }
      }
    };
  }
}
