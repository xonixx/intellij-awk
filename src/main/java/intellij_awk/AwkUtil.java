package intellij_awk;

import com.intellij.codeInsight.completion.InsertHandler;
import com.intellij.codeInsight.lookup.Lookup;
import com.intellij.codeInsight.lookup.LookupElement;
import com.intellij.lang.ASTNode;
import com.intellij.openapi.editor.EditorModificationUtil;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.vfs.VirtualFile;
import com.intellij.psi.PsiComment;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiFile;
import com.intellij.psi.PsiWhiteSpace;
import com.intellij.psi.search.FileTypeIndex;
import com.intellij.psi.search.GlobalSearchScope;
import com.intellij.psi.stubs.StubIndex;
import com.intellij.psi.tree.IElementType;
import com.intellij.psi.util.PsiTreeUtil;
import intellij_awk.psi.*;
import intellij_awk.psi.impl.AwkFunctionNameImpl;
import intellij_awk.psi.impl.AwkUserVarNameImpl;
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

  @Nullable
  public static PsiElement findFirstMatchedDeep(PsiElement root, IElementType elementType) {
    return findFirstMatchedDeep(root, psiElement -> isType(psiElement, elementType));
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

  public static Collection<AwkUserVarNameImpl> findUserVarDeclarations(Project project, String name) {
    return StubIndex.getElements(
        AwkUserVarNameStubElementType.IndexUserVarDeclarations.KEY,
        name,
        project,
        GlobalSearchScope.projectScope(project),
        AwkUserVarNameImpl.class);
  }

  public static Collection<AwkFunctionNameImpl> findFunctions(
      Project project, String name, GlobalSearchScope scope) {
    return StubIndex.getElements(
        AwkFunctionNameStubElementType.Index.KEY, name, project, scope, AwkFunctionNameImpl.class);
  }

  public static List<AwkFunctionNameImpl> findFunctions(Project project) {
    Collection<String> allKeys = findFunctionNames(project);
    List<AwkFunctionNameImpl> result = new ArrayList<>();
    for (String key : allKeys) {
      result.addAll(
          StubIndex.getElements(
              AwkFunctionNameStubElementType.Index.KEY,
              key,
              project,
              GlobalSearchScope.projectScope(project),
              AwkFunctionNameImpl.class));
    }
    return result;
  }

  /** Let's only consider variable declarations in initializing context */
  public static List<AwkUserVarNameImpl> findGlobalVars(Project project) {
    Collection<String> allKeys = findGlobalVarNames(project);
    List<AwkUserVarNameImpl> result = new ArrayList<>();
    for (String key : allKeys) {
      result.addAll(
          StubIndex.getElements(
              AwkUserVarNameStubElementType.IndexUserVarDeclarations.KEY,
              key,
              project,
              GlobalSearchScope.projectScope(project),
              AwkUserVarNameImpl.class));
    }
    return result;
  }

  @NotNull
  public static Collection<String> findFunctionNames(Project project) {
    return StubIndex.getInstance().getAllKeys(AwkFunctionNameStubElementType.Index.KEY, project);
  }

  /** Let's only consider variable declarations in initializing context */
  @NotNull
  public static Collection<String> findGlobalVarNames(Project project) {
    return StubIndex.getInstance()
        .getAllKeys(
            AwkUserVarNameStubElementType.IndexUserVarDeclarations.KEY,
            project);
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

  public static InsertHandler<LookupElement> insertHandler(
      InsertHandler<LookupElement> replaceCherInsertHandler,
      InsertHandler<LookupElement> insertHandler) {

    return (ctx, item) ->
        (ctx.getCompletionChar() == Lookup.REPLACE_SELECT_CHAR
                ? replaceCherInsertHandler
                : insertHandler)
            .handleInsert(ctx, item);
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
    while ((element = element.getPrevSibling()) instanceof PsiWhiteSpace
        || isLineContinuation(element))
      ;
    return element;
  }

  public static PsiElement getNextNotWhitespace(PsiElement element) {
    while ((element = element.getNextSibling()) instanceof PsiWhiteSpace
        || isLineContinuation(element))
      ;
    return element;
  }

  /** Line continuation is '\' followed by newline */
  public static boolean isLineContinuation(PsiElement element) {
    return element instanceof PsiComment && element.textMatches("\\\n");
  }

  /** "\"value\"" -> "value" */
  public static String stringValue(String str) {
    return str == null || str.length() < 2 ? null : str.substring(1, str.length() - 1);
  }

  @NotNull
  public static List<PsiElement> findUserVars(PsiElement psiElement) {
    List<PsiElement> userVars = new ArrayList<>();
    findAllMatchedDeep(psiElement, psiEl -> psiEl instanceof AwkUserVarNameMixin, userVars);
    return userVars;
  }

  public static boolean isNotType(PsiElement psiElement, IElementType elementType) {
    return !isType(psiElement, elementType);
  }

  public static boolean isType(PsiElement psiElement, IElementType elementType) {
    if (psiElement == null) {
      return false;
    }
    ASTNode node = psiElement.getNode();
    return node != null && elementType.equals(node.getElementType());
  }

  @NotNull
  public static String getDocStringFromCommentBefore(PsiElement psiElement) {
    if (psiElement == null) {
      return "";
    }
    StringBuilder sb = new StringBuilder();
    PsiElement e = psiElement;
    while ((e = e.getPrevSibling()) instanceof PsiComment || isType(e, AwkTypes.NEWLINE)) {
      String text = e.getText();
      if (text.startsWith("#")) {
        text = text.substring(1).stripLeading();
      }
      sb.insert(0, text);
    }
    return sb.toString();
  }
}
