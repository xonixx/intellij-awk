package intellij_awk;

import com.intellij.codeInspection.ProblemsHolder;
import com.intellij.psi.search.GlobalSearchScope;
import intellij_awk.psi.AwkVisitor;
import org.jetbrains.annotations.NotNull;

public class AwkInspectionUtil {
  public static final AwkVisitor DISABLE_INSPECTION = new AwkVisitor();

  static AwkVisitor disableInspectionOnFileOutsideProject(
      @NotNull ProblemsHolder holder, @NotNull AwkVisitor visitor) {
    if (GlobalSearchScope.projectScope(holder.getProject())
        .contains(holder.getFile().getVirtualFile())) {
      return visitor;
    }
    return DISABLE_INSPECTION;
  }
}
