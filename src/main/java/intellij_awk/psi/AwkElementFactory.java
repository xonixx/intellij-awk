package intellij_awk.psi;

import com.intellij.openapi.project.Project;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiFileFactory;
import com.intellij.psi.PsiWhiteSpace;
import com.intellij.psi.tree.IElementType;
import intellij_awk.AwkFileType;
import intellij_awk.AwkUtil;

public class AwkElementFactory {

  public static AwkFunctionCallName createFunctionCallName(Project project, String name) {
    return createAwkPsiElement(project, name + "()", AwkFunctionCallName.class);
  }

  public static AwkFunctionName createFunctionName(Project project, String name) {
    return createAwkPsiElement(project, "function " + name + "(){}", AwkFunctionName.class);
  }

  public static AwkItem createFunctionItem(Project project, String name) {
    return createAwkPsiElement(project, "function " + name + "(){}", AwkItem.class);
  }

  public static AwkUserVarName createUserVarName(Project project, String name) {
    return createAwkPsiElement(project, "{ " + name + "= 1 }", AwkUserVarName.class);
  }

  public static AwkIncludePath createIncludePath(Project project, String name) {
    return createAwkPsiElement(project, "@include \"" + name + "\"", AwkIncludePath.class);
  }

  public static AwkParamList createParamList(Project project, String paramsAsText) {
    return createAwkPsiElement(project, "function f(" + paramsAsText + "){}", AwkParamList.class);
  }

  public static PsiWhiteSpace createWhiteSpaces(Project project, int n) {
    String whitespaces = " ".repeat(n);
    return createAwkPsiElement(project, "a" + whitespaces + "b", PsiWhiteSpace.class);
  }

  public static PsiElement createNewline(Project project) {
    return createAwkPsiElement(project, "1\n1", AwkTypes.NEWLINE);
  }

  public static <T extends PsiElement> T createAwkPsiElement(
      Project project, String text, Class<T> klass) {
    return (T) AwkUtil.findFirstMatchedDeep(createFile(project, text), klass::isInstance);
  }

  public static <T extends PsiElement> T createAwkPsiElement(
      Project project, String text, IElementType elementType) {
    return (T) AwkUtil.findFirstMatchedDeep(createFile(project, text), elementType);
  }

  public static AwkFile createFile(Project project, String text) {
    return (AwkFile)
        PsiFileFactory.getInstance(project)
            .createFileFromText("dummy.awk", AwkFileType.INSTANCE, text);
  }
}
