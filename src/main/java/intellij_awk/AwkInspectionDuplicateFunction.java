package intellij_awk;

import com.intellij.codeInspection.LocalInspectionTool;
import com.intellij.codeInspection.ProblemHighlightType;
import com.intellij.codeInspection.ProblemsHolder;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.PsiFile;
import intellij_awk.psi.AwkVisitor;
import intellij_awk.psi.impl.AwkFunctionNameImpl;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.stream.Collectors;
import org.jetbrains.annotations.NotNull;

public class AwkInspectionDuplicateFunction extends LocalInspectionTool {

  @Override
  public @NotNull PsiElementVisitor buildVisitor(
      @NotNull ProblemsHolder holder, boolean isOnTheFly) {
    return new AwkVisitor() {
      @Override
      public void visitFile(@NotNull PsiFile awkFile) {
        // TODO what about same function in other files?
        List<AwkFunctionNameImpl> functionsInFile = AwkUtil.findFunctionsInFile(awkFile);

        Map<String, List<AwkFunctionNameImpl>> functionsByName =
            functionsInFile.stream()
                .collect(
                    Collectors.groupingBy(
                        awkFunctionName -> awkFunctionName.getNamePsiElement().getText()));

        for (Entry<String, List<AwkFunctionNameImpl>> entry : functionsByName.entrySet()) {
          if (entry.getValue().size() > 1) {
            String functionName = entry.getKey();
            for (AwkFunctionNameImpl awkFunctionName : entry.getValue()) {
              holder.registerProblem(
                  awkFunctionName,
                  "Function '" + functionName + "' is already defined in " + awkFile.getName(),
                  ProblemHighlightType.GENERIC_ERROR);
            }
          }
        }
      }
    };
  }
}
