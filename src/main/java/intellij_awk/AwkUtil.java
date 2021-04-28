package intellij_awk;

import com.intellij.openapi.project.Project;
import com.intellij.openapi.vfs.VirtualFile;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiManager;
import com.intellij.psi.search.FileTypeIndex;
import com.intellij.psi.search.GlobalSearchScope;
import intellij_awk.psi.*;
import intellij_awk.psi.impl.AwkFunctionNameImpl;
import org.jetbrains.annotations.Nullable;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.function.Predicate;

public class AwkUtil {

  @Nullable
  public static PsiElement findFirstMatchedDeep(PsiElement root, Predicate<PsiElement> predicate) {
    PsiElement[] children = root.getChildren();
    for (PsiElement child : children) {
      if (predicate.test(child)) {
        return child;
      }
      PsiElement matched = findFirstMatchedDeep(child, predicate);
      if (matched != null) {
        return matched;
      }
    }
    return null;
  }

  public static boolean isEnclosedBy(
      PsiElement psiElement, Class<? extends PsiElement> enclosingClass) {
    return isEnclosedBy(psiElement, enclosingClass::isInstance);
  }

  public static boolean isEnclosedBy(PsiElement psiElement, Predicate<PsiElement> predicate) {
    PsiElement parent = psiElement.getParent();
    if (parent instanceof AwkFile) {
      return false;
    }
    return predicate.test(parent) || isEnclosedBy(parent, predicate);
  }

  public static boolean isAwkBegin(PsiElement candidate) {
    if (candidate instanceof AwkBeginOrEnd) {
      AwkBeginOrEnd beginOrEnd = (AwkBeginOrEnd) candidate;
      return AwkTypes.BEGIN.equals(beginOrEnd.getFirstChild().getNode().getElementType());
    }
    return false;
  }

  public static boolean isAwkItemOfBegin(PsiElement candidate) {
    return candidate instanceof AwkItem
        && ((AwkItem) candidate).getPattern() != null
        && isAwkBegin(((AwkItem) candidate).getPattern().getBeginOrEnd());
  }

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