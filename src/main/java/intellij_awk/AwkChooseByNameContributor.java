package intellij_awk;

import com.intellij.navigation.ChooseByNameContributor;
import com.intellij.navigation.NavigationItem;
import com.intellij.openapi.project.Project;
import intellij_awk.psi.impl.AwkFunctionNameImpl;
import org.jetbrains.annotations.NotNull;

import java.util.Collection;

public class AwkChooseByNameContributor implements ChooseByNameContributor {

  @Override
  public String @NotNull [] getNames(Project project, boolean includeNonProjectItems) {
    // TODO: include non project items
    return AwkUtil.findFunctionNames(project).toArray(new String[0]);
  }

  @Override
  public NavigationItem @NotNull [] getItemsByName(
      String name, String pattern, Project project, boolean includeNonProjectItems) {
    // TODO: include non project items
    Collection<AwkFunctionNameImpl> functions = AwkUtil.findFunctions(project, name);
    return functions.toArray(new NavigationItem[0]);
  }
}
