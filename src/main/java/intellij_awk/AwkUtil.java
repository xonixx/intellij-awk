package intellij_awk;

import com.intellij.openapi.project.Project;
import com.intellij.openapi.vfs.VirtualFile;
import com.intellij.psi.PsiManager;
import com.intellij.psi.search.FileTypeIndex;
import com.intellij.psi.search.GlobalSearchScope;
import com.intellij.psi.util.PsiTreeUtil;
import intellij_awk.psi.AwkFile;
import intellij_awk.psi.AwkItem;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class AwkUtil {

  /**
   * Searches the entire project for Simple language files with instances of the Simple property
   * with the given key.
   *
   * @param project current project
   * @param name to check
   * @return matching properties
   */
  public static List<AwkItem> findFunctions(Project project, String name) {
    List<AwkItem> result = new ArrayList<>();
    Collection<VirtualFile> virtualFiles =
        FileTypeIndex.getFiles(AwkFileType.INSTANCE, GlobalSearchScope.allScope(project));
    for (VirtualFile virtualFile : virtualFiles) {
      AwkFile awkFile = (AwkFile) PsiManager.getInstance(project).findFile(virtualFile);
      if (awkFile != null) {
        AwkItem[] awkItems = PsiTreeUtil.getChildrenOfType(awkFile, AwkItem.class);
        if (awkItems != null) {
          for (AwkItem awkItem : awkItems) {
            if (awkItem.isFunction() && awkItem.getItemName().equals(name)) {
              result.add(awkItem);
            }
          }
        }
      }
    }
    return result;
  }

  public static List<AwkItem> findFunctions(Project project) {
    List<AwkItem> result = new ArrayList<>();
    Collection<VirtualFile> virtualFiles =
        FileTypeIndex.getFiles(AwkFileType.INSTANCE, GlobalSearchScope.allScope(project));
    for (VirtualFile virtualFile : virtualFiles) {
      AwkFile awkFile = (AwkFile) PsiManager.getInstance(project).findFile(virtualFile);
      if (awkFile != null) {
        AwkItem[] awkItems = PsiTreeUtil.getChildrenOfType(awkFile, AwkItem.class);
        if (awkItems != null) {
          for (AwkItem awkItem : awkItems) {
            if (awkItem.isFunction()) {
              result.add(awkItem);
            }
          }
        }
      }
    }
    return result;
  }
}
