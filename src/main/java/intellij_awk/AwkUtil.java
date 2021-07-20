package intellij_awk;

import com.intellij.codeInsight.completion.InsertHandler;
import com.intellij.codeInsight.lookup.LookupElement;
import com.intellij.openapi.editor.EditorModificationUtil;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.vfs.VirtualFile;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiFile;
import com.intellij.psi.PsiManager;
import com.intellij.psi.PsiWhiteSpace;
import com.intellij.psi.search.FileTypeIndex;
import com.intellij.psi.search.GlobalSearchScope;
import com.intellij.psi.stubs.StubIndex;
import com.intellij.psi.util.PsiTreeUtil;
import intellij_awk.psi.*;
import intellij_awk.psi.impl.AwkFunctionNameImpl;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.function.Predicate;

public class AwkUtil {

  @Nullable
  public static PsiElement findFirstMatchedDeep(PsiElement root, Predicate<PsiElement> predicate) {
    for (PsiElement child = root.getFirstChild(); child != null; child = child.getNextSibling()) {
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

  public static void findAllMatchedDeep(
      @Nullable PsiElement root, Predicate<PsiElement> predicate, Collection<PsiElement> result) {
    if (root == null) return;
    PsiElement[] children = root.getChildren();
    for (PsiElement child : children) {
      if (predicate.test(child)) {
        result.add(child);
      }
      findAllMatchedDeep(child, predicate, result);
    }
  }

  public static boolean isAwkBegin(PsiElement candidate) {
    if (candidate instanceof AwkBeginOrEnd) {
      AwkBeginOrEnd beginOrEnd = (AwkBeginOrEnd) candidate;
      return AwkTypes.BEGIN.equals(beginOrEnd.getFirstChild().getNode().getElementType());
    }
    return false;
  }

  /**
   * Searches the entire project for AWK language files with instances of the AWK function with the
   * given key.
   *
   * @param project current project
   * @param name to check
   * @return matching properties
   */
  public static Collection<AwkFunctionNameImpl> findFunctions(Project project, String name) {
    return findFunctions(project, name, GlobalSearchScope.projectScope(project));
  }

  public static Collection<AwkFunctionNameImpl> findFunctions(
      Project project, String name, GlobalSearchScope scope) {
    return StubIndex.getElements(
        AwkFunctionNameStubElementType.Index.KEY, name, project, scope, AwkFunctionNameImpl.class);
  }

  public static List<AwkFunctionNameImpl> findFunctions(Project project) {
    return findFunctions(project, GlobalSearchScope.projectScope(project));
  }

  public static List<AwkFunctionNameImpl> findFunctions(Project project, GlobalSearchScope scope) {
    Collection<String> allKeys =
        StubIndex.getInstance().getAllKeys(AwkFunctionNameStubElementType.Index.KEY, project);
    List<AwkFunctionNameImpl> result = new ArrayList<>();
    for (String key : allKeys) {
      result.addAll(
          StubIndex.getElements(
              AwkFunctionNameStubElementType.Index.KEY,
              key,
              project,
              scope,
              AwkFunctionNameImpl.class));
    }
    return result;
  }

  public static List<AwkFunctionNameImpl> findFunctionsInFile(
      PsiFile psiFile, @NotNull String name) {
    List<AwkFunctionNameImpl> result = new ArrayList<>();
    if (psiFile instanceof AwkFile) {
      AwkFile awkFile = (AwkFile) psiFile;
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
    return result;
  }

  @NotNull
  private static Collection<VirtualFile> getAwkFiles(Project project) {
    return FileTypeIndex.getFiles(AwkFileType.INSTANCE, GlobalSearchScope.allScope(project));
  }

  public static InsertHandler<LookupElement> insertHandler(String insertString, int caretShift) {
    return (ctx, item) -> {
      ctx.getDocument().insertString(ctx.getSelectionEndOffset(), insertString);
      EditorModificationUtil.moveCaretRelatively(ctx.getEditor(), caretShift);
    };
  }

  public static <T extends PsiElement> T findParent(PsiElement psiElement, Class<T> parentClass) {
    return PsiTreeUtil.getParentOfType(psiElement, parentClass);
  }

  public static PsiElement getPrevNotWhitespace(PsiElement element) {
    while ((element = element.getPrevSibling()) instanceof PsiWhiteSpace)
      ;
    return element;
  }

  /** "\"value\"" -> "value" */
  public static String stringValue(String str) {
    return str == null || str.length() < 2 ? null : str.substring(1, str.length() - 1);
  }
}
