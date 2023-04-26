package intellij_awk;

import com.intellij.codeInspection.*;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.PsiNamedElement;
import intellij_awk.psi.*;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.stream.Collectors;
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

          Map<String, List<AwkUserVarName>> paramsByName =
              paramNameList.stream().collect(Collectors.groupingBy(PsiNamedElement::getName));

          for (Entry<String, List<AwkUserVarName>> entry : paramsByName.entrySet()) {
            if (entry.getValue().size() > 1) {
              for (AwkUserVarName awkUserVarName : entry.getValue()) {
                holder.registerProblem(
                    awkUserVarName,
                    "parameter '" + entry.getKey() + "' is already defined",
                    ProblemHighlightType.GENERIC_ERROR);
              }
            }
          }
        }
      }
    };
  }
}
