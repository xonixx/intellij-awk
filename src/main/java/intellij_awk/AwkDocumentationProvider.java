package intellij_awk;

import com.intellij.lang.documentation.AbstractDocumentationProvider;
import com.intellij.openapi.project.Project;
import com.intellij.psi.PsiElement;
import intellij_awk.psi.*;
import org.jetbrains.annotations.Nullable;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.regex.Pattern;

import static com.intellij.lang.documentation.DocumentationMarkup.*;

public class AwkDocumentationProvider extends AbstractDocumentationProvider {
  public static final String STD_LIB_FILE_NAME = "std.awk";
  private AwkFile stdLibFile;

  @Override
  public @Nullable String generateDoc(PsiElement element, @Nullable PsiElement originalElement) {
    if (element instanceof AwkFunctionCallBuiltIn) {
      AwkFunctionCallBuiltIn awkFunctionCallBuiltIn = (AwkFunctionCallBuiltIn) element;
      PsiElement builtinFuncName = awkFunctionCallBuiltIn.getBuiltinFuncName();
      if (builtinFuncName != null) {
        String funcName = builtinFuncName.getText();
        String documentation =
            getBuiltInFunctionDocumentation(builtinFuncName.getProject(), "awk::" + funcName);
        if (documentation != null) {
          return postprocessDocumentation(funcName, documentation, false);
        } else {
          return "TODO: add documentation for " + funcName;
        }
      }
      PsiElement builtinFuncNameGawk = awkFunctionCallBuiltIn.getBuiltinFuncNameGawk();
      if (builtinFuncNameGawk != null) {
        String funcName = builtinFuncNameGawk.getText();
        String documentation =
            getBuiltInFunctionDocumentation(builtinFuncNameGawk.getProject(), "gawk::" + funcName);
        if (documentation != null) {
          return postprocessDocumentation(funcName, documentation, true);
        } else {
          return "TODO: add documentation for " + funcName;
        }
      }
    }
    return null;
  }

  private String postprocessDocumentation(
      String funcName, String documentation, boolean isGawkFunction) {
    if (documentation.contains("</dt>")) {
      StringBuilder res = new StringBuilder();

      String[] parts =
          documentation.split(Pattern.quote("</dt>"), funcName.contains("asort") ? 3 : 2);

      for (int i = 0; i < parts.length - 1; i++) {
        res.append(DEFINITION_START)
            .append(parts[i].stripLeading())
            .append(isGawkFunction ? "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Gawk-only!</b>" : "")
            .append("</dt>")
            .append(DEFINITION_END);
      }

      res.append(CONTENT_START).append(parts[parts.length - 1].stripLeading()).append(CONTENT_END);

      return res.toString();
    }
    return documentation;
  }

  @Nullable
  private String getBuiltInFunctionDocumentation(Project project, String funcName) {
    if (stdLibFile == null) {
      String text;
      try {
        InputStream stream =
            AwkDocumentationProvider.class
                .getClassLoader()
                .getResourceAsStream("/" + STD_LIB_FILE_NAME);
        if (stream != null) {
          text = new String(stream.readAllBytes(), StandardCharsets.UTF_8);
        } else {
          throw new IllegalStateException(STD_LIB_FILE_NAME + " is absent!");
        }
      } catch (IOException e) {
        throw new RuntimeException(e);
      }
      stdLibFile = AwkElementFactory.createFile(project, text);
    }

    PsiElement awkItemOfFunction =
        AwkUtil.findFirstMatchedDeep(
            stdLibFile,
            psiElement -> {
              if (!(psiElement instanceof AwkItem)) return false;
              AwkFunctionName functionName = ((AwkItem) psiElement).getFunctionName();
              return functionName != null && funcName.equals(functionName.getName());
            });

    if (awkItemOfFunction == null) {
      return null;
    }

    return AwkUtil.getDocStringFromCommentBefore(awkItemOfFunction);
  }
}
