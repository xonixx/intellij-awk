package intellij_awk;

import com.intellij.codeInspection.LocalInspectionTool;
import com.intellij.codeInspection.ProblemsHolder;
import com.intellij.psi.PsiElementVisitor;
import intellij_awk.psi.*;
import org.jetbrains.annotations.NotNull;

import java.util.List;

public class AwkInspectionUnusedFunctionParams extends LocalInspectionTool {

  @Override
  public @NotNull PsiElementVisitor buildVisitor(
      @NotNull ProblemsHolder holder, boolean isOnTheFly) {
    return new AwkVisitor() {
      @Override
      public void visitItem(@NotNull AwkItem awkItem) {
        AwkParamList paramList = awkItem.getParamList();
        if (paramList != null) {
          List<AwkUserVarName> userVarNameList = paramList.getUserVarNameList();
          for (AwkUserVarName varName : userVarNameList) {
            AwkUserVarNameMixin varNameMixin = (AwkUserVarNameMixin) varName;
            AwkReferenceVariable reference = varNameMixin.getReference();
            if (reference != null && reference.multiResolve(false).length == 0) {
              holder.registerProblem(
                  varNameMixin, "Parameter '" + varNameMixin.getName() + "' is never used");
            }
          }
        }
      }
    };
  }

  private void bbb() {
    aaa("sadf");
  }

  private void aaa(String a) {}
}
