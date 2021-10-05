package intellij_awk.psi;

import com.intellij.openapi.project.Project;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiFileFactory;
import intellij_awk.AwkFileType;
import intellij_awk.AwkUtil;

public class AwkElementFactory {

  public static AwkFunctionCallName createFunctionCallName(Project project, String name) {
    return createAwkPsiElement(project, name + "()", AwkFunctionCallName.class);
  }

  public static AwkFunctionName createFunctionName(Project project, String name) {
    return createAwkPsiElement(project, "function " + name + "(){}", AwkFunctionName.class);
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

  public static <T extends PsiElement> T createAwkPsiElement(
      Project project, String text, Class<T> klass) {
    return (T) AwkUtil.findFirstMatchedDeep(createFile(project, text), klass::isInstance);
  }

  public static AwkFile createFile(Project project, String text) {
    return (AwkFile)
        PsiFileFactory.getInstance(project)
            .createFileFromText("dummy.awk", AwkFileType.INSTANCE, text);
  }
}
