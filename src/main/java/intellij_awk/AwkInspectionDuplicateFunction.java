package intellij_awk;

import com.intellij.codeInspection.LocalInspectionTool;
import com.intellij.codeInspection.ProblemHighlightType;
import com.intellij.codeInspection.ProblemsHolder;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.PsiFile;
import intellij_awk.psi.AwkFunctionNameMixin;
import intellij_awk.psi.AwkItem;
import intellij_awk.psi.AwkVisitor;
import intellij_awk.psi.impl.AwkFunctionNameImpl;
import java.util.Collection;
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
          PsiFile containingFile = functionName.getContainingFile();
          Collection<AwkFunctionNameImpl> functionsWithSameName =
              AwkUtil.findFunctionsInFile(containingFile, functionName.getText());
          if (functionsWithSameName.size() > 1) {
            holder.registerProblem(
                functionName,
                "Function '"
                    + functionName.getName()
                    + "' is already defined in "
                    + containingFile.getName(),
                ProblemHighlightType.GENERIC_ERROR);
          }
        }
      }
    };
  }
}
