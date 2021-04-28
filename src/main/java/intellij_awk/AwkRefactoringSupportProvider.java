package intellij_awk;

import com.intellij.lang.refactoring.RefactoringSupportProvider;
import com.intellij.psi.PsiElement;
import intellij_awk.psi.AwkFunctionCallName;
import intellij_awk.psi.AwkFunctionName;
import intellij_awk.psi.AwkUserVarName;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public class AwkRefactoringSupportProvider extends RefactoringSupportProvider {

  @Override
  public boolean isMemberInplaceRenameAvailable(
      @NotNull PsiElement elementToRename, @Nullable PsiElement context) {
    return elementToRename instanceof AwkFunctionName
        || elementToRename instanceof AwkFunctionCallName
        || elementToRename instanceof AwkUserVarName;
  }
}
