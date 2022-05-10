package intellij_awk;

import com.intellij.codeInspection.*;
import com.intellij.codeInspection.util.IntentionFamilyName;
import com.intellij.openapi.project.Project;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.PsiReference;
import com.intellij.psi.search.searches.ReferencesSearch;
import com.intellij.psi.util.PsiTreeUtil;
import com.intellij.util.Query;
import intellij_awk.psi.*;
import org.jetbrains.annotations.NotNull;

import java.util.function.Consumer;

public class AwkInspectionEnforceGlobalVariableNaming extends LocalInspectionTool {

  private static final DeleteUnusedGlobalVariableQuickFix uppercaseGlobalVariableNameQuickFix =
      new DeleteUnusedGlobalVariableQuickFix();
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

  private static class DeleteUnusedGlobalVariableQuickFix implements LocalQuickFix {

    @Override
    public @IntentionFamilyName @NotNull String getFamilyName() {
      return QUICK_FIX_NAME;
    }

    @Override
    public void applyFix(@NotNull Project project, @NotNull ProblemDescriptor descriptor) {
      PsiElement psiElement = descriptor.getPsiElement();
      ReferencesSearch.search(psiElement)
          .forEach(
              (Consumer<? super PsiReference>)
                  psiReference -> deleteDeclarationStatement(psiReference.getElement()));
      deleteDeclarationStatement(psiElement);
    }

    private void deleteDeclarationStatement(PsiElement psiElement) {
      //      PsiTreeUtil.getParentOfType(
      //              psiElement, AwkTerminatedStatement.class, AwkUnterminatedStatement.class)
      //          .delete();
    }
  }
}
