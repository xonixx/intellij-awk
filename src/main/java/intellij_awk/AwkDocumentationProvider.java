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
        String awkFuncName = builtinFuncName.getText();
        String documentation =
            getBuiltInFunctionDocumentation(builtinFuncName.getProject(), "awk::" + awkFuncName);
        if (documentation != null) {
          return postprocessDocumentation(documentation);
        } else {
          return "TODO: add documentation for " + awkFuncName;
        }
      }
      PsiElement builtinFuncNameGawk = awkFunctionCallBuiltIn.getBuiltinFuncNameGawk();
      if (builtinFuncNameGawk != null) {
        String awkFuncName = builtinFuncNameGawk.getText();
        String documentation =
            getBuiltInFunctionDocumentation(builtinFuncNameGawk.getProject(), "awk::" + awkFuncName);
        if (documentation != null) {
          return postprocessDocumentation(documentation);
        } else {
          return "TODO: add documentation for " + awkFuncName;
        }
      }
    }
    return null;
  }

  private String postprocessDocumentation(String documentation) {
    if (documentation.contains("</dt>")) {
      String[] parts = documentation.split(Pattern.quote("</dt>"), 2);
      return DEFINITION_START
          + parts[0].stripLeading()
          + DEFINITION_END
          + CONTENT_START
          + parts[1].stripLeading()
          + CONTENT_END;
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
