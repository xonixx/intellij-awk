package intellij_awk;

import com.intellij.codeInspection.*;
import com.intellij.psi.PsiElementVisitor;
import intellij_awk.psi.*;
import java.util.List;
import org.jetbrains.annotations.NotNull;

public class AwkInspectionDuplicateFunctionParam extends LocalInspectionTool {

  @Override
  public @NotNull PsiElementVisitor buildVisitor(
      @NotNull ProblemsHolder holder, boolean isOnTheFly) {
    return new AwkVisitor() {
      @Override
      public void visitItem(@NotNull AwkItem awkItem) {
        AwkParamList paramList = awkItem.getParamList();
        if (paramList != null) {
          List<AwkUserVarName> paramNameList = paramList.getUserVarNameList();
        }
      }
    };
  }
}
