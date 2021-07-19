package intellij_awk;

import com.intellij.navigation.ChooseByNameContributor;
import com.intellij.navigation.NavigationItem;
import com.intellij.openapi.project.Project;
import intellij_awk.psi.impl.AwkFunctionNameImpl;
import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class AwkChooseByNameContributor implements ChooseByNameContributor {

  @NotNull
  @Override
  public String[] getNames(Project project, boolean includeNonProjectItems) {
    List<AwkFunctionNameImpl> functions = AwkUtil.findFunctions(project);
    List<String> names = new ArrayList<>(functions.size());
    for (AwkFunctionNameImpl function : functions) {
      String name = function.getName();
      if (name != null && name.length() > 0) {
        names.add(name);
      }
    }
    return names.toArray(new String[names.size()]);
  }

  @NotNull
  @Override
  public NavigationItem[] getItemsByName(
      String name, String pattern, Project project, boolean includeNonProjectItems) {
    // TODO: include non project items
    Collection<AwkFunctionNameImpl> functions = AwkUtil.findFunctions(project, name);
    return functions.toArray(new NavigationItem[0]);
  }
}
