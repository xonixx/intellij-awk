package intellij_awk;

import com.intellij.codeInspection.*;
import com.intellij.codeInspection.util.IntentionFamilyName;
import com.intellij.openapi.project.Project;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.PsiReference;
import com.intellij.psi.search.searches.ReferencesSearch;
import intellij_awk.psi.AwkUserVarName;
import intellij_awk.psi.AwkUserVarNameMixin;
import intellij_awk.psi.AwkVisitor;
import org.jetbrains.annotations.NotNull;

import java.util.function.Consumer;

public class AwkInspectionEnforceGlobalVariableNaming extends LocalInspectionTool {

  private static final UppercaseGlobalVariableNameQuickFix uppercaseGlobalVariableNameQuickFix =
      new UppercaseGlobalVariableNameQuickFix();
  public static final String QUICK_FIX_NAME = "Uppercase global variable name";

  @Override
  public @NotNull PsiElementVisitor buildVisitor(
      @NotNull ProblemsHolder holder, boolean isOnTheFly) {
    return new AwkVisitor() {
      @Override
      public void visitUserVarName(@NotNull AwkUserVarName userVarName) {
        AwkUserVarNameMixin userVarNameMixin = (AwkUserVarNameMixin) userVarName;
        if (userVarNameMixin.isDeclaration()
            && Util.startsWithLowercaseLetter(userVarNameMixin.getName())) {
          if (userVarNameMixin.getReference().resolve() == null) { // is top declaration
            holder.registerProblem(
                userVarNameMixin,
                "Global variable name '" + userVarNameMixin.getName() + "' is in lowercase",
                ProblemHighlightType.WARNING,
                uppercaseGlobalVariableNameQuickFix);
          }
        }
      }
    };
  }

  private static class UppercaseGlobalVariableNameQuickFix implements LocalQuickFix {

    @Override
    public @IntentionFamilyName @NotNull String getFamilyName() {
      return QUICK_FIX_NAME;
    }

    @Override
    public void applyFix(@NotNull Project project, @NotNull ProblemDescriptor descriptor) {
      PsiElement psiElement = descriptor.getPsiElement();
      AwkUserVarNameMixin userVarNameMixin = (AwkUserVarNameMixin) psiElement;
      // TODO shall we do smth more clever like 'aaa_bbb' -> 'AaaBbb'?
      String newName = Util.ucFirst(userVarNameMixin.getName());
      ReferencesSearch.search(psiElement)
          .forEach(
              (Consumer<? super PsiReference>)
                  psiReference -> psiReference.handleElementRename(newName));
      userVarNameMixin.setName(newName);
    }
  }
}
