package intellij_awk;

import com.intellij.navigation.ChooseByNameContributor;
import com.intellij.navigation.NavigationItem;
import com.intellij.openapi.project.Project;
import intellij_awk.psi.impl.AwkUserVarNameImpl;
import java.util.Collection;
import org.jetbrains.annotations.NotNull;

public class AwkChooseByNameContributorGlobalVars implements ChooseByNameContributor {

  @Override
  public String @NotNull [] getNames(Project project, boolean includeNonProjectItems) {
    // TODO: include non project items
    return AwkUtil.findGlobalVarNames(project).toArray(new String[0]);
  }

  @Override
  public NavigationItem @NotNull [] getItemsByName(
      String name, String pattern, Project project, boolean includeNonProjectItems) {
    // TODO: include non project items
    Collection<AwkUserVarNameImpl> globalVars = AwkUtil.findUserVarDeclarations(project, name);
    return globalVars.isEmpty()
        ? NavigationItem.EMPTY_NAVIGATION_ITEM_ARRAY
        : new NavigationItem[] {globalVars.iterator().next()};
  }
}
