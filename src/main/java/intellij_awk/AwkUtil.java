package intellij_awk;

import com.intellij.openapi.project.Project;
import com.intellij.openapi.vfs.VirtualFile;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiManager;
import com.intellij.psi.search.FileTypeIndex;
import com.intellij.psi.search.GlobalSearchScope;
import intellij_awk.psi.AwkFile;
import intellij_awk.psi.AwkFunctionName;
import intellij_awk.psi.AwkItem;
import intellij_awk.psi.impl.AwkFunctionNameImpl;

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
  public static List<AwkFunctionNameImpl> findFunctions(Project project, String name) {
    List<AwkFunctionNameImpl> result = new ArrayList<>();
    Collection<VirtualFile> virtualFiles =
        FileTypeIndex.getFiles(AwkFileType.INSTANCE, GlobalSearchScope.allScope(project));
    for (VirtualFile virtualFile : virtualFiles) {
      AwkFile awkFile = (AwkFile) PsiManager.getInstance(project).findFile(virtualFile);
      if (awkFile != null) {

        for (PsiElement child : awkFile.getChildren()) {

          if (child instanceof AwkItem) {
            AwkItem awkItem = (AwkItem) child;

            AwkFunctionName functionName = awkItem.getFunctionName();
            if (functionName != null && name.equals(functionName.getName())) {
              result.add((AwkFunctionNameImpl) functionName);
            }
          }
        }
      }
    }
    return result;
  }

  public static List<AwkFunctionNameImpl> findFunctions(Project project) {
    List<AwkFunctionNameImpl> result = new ArrayList<>();
    Collection<VirtualFile> virtualFiles =
        FileTypeIndex.getFiles(AwkFileType.INSTANCE, GlobalSearchScope.allScope(project));
    for (VirtualFile virtualFile : virtualFiles) {
      AwkFile awkFile = (AwkFile) PsiManager.getInstance(project).findFile(virtualFile);
      if (awkFile != null) {

        for (PsiElement child : awkFile.getChildren()) {

          if (child instanceof AwkItem) {
            AwkItem awkItem = (AwkItem) child;

            AwkFunctionName functionName = awkItem.getFunctionName();
            if (functionName != null) {
              result.add((AwkFunctionNameImpl) functionName);
            }
          }
        }
      }
    }
    return result;
  }
}
