package intellij_awk;

import com.intellij.navigation.ChooseByNameContributor;
import com.intellij.navigation.NavigationItem;
import com.intellij.openapi.project.Project;
import intellij_awk.psi.SimpleProperty;
import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.List;

public class AwkChooseByNameContributor implements ChooseByNameContributor {

  @NotNull
  @Override
  public String[] getNames(Project project, boolean includeNonProjectItems) {
    List<SimpleProperty> properties = AwkUtil.findProperties(project);
    List<String> names = new ArrayList<>(properties.size());
    for (SimpleProperty property : properties) {
      if (property.getKey() != null && property.getKey().length() > 0) {
        names.add(property.getKey());
      }
    }
    return names.toArray(new String[names.size()]);
  }

  @NotNull
  @Override
  public NavigationItem[] getItemsByName(
      String name, String pattern, Project project, boolean includeNonProjectItems) {
    // TODO: include non project items
    List<SimpleProperty> properties = AwkUtil.findProperties(project, name);
    return properties.toArray(new NavigationItem[properties.size()]);
  }
}
