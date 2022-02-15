package intellij_awk;

import com.intellij.lang.documentation.AbstractDocumentationProvider;
import com.intellij.openapi.editor.Editor;
import com.intellij.openapi.project.Project;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiFile;
import intellij_awk.psi.*;
import org.jetbrains.annotations.NotNull;
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
      {
        PsiElement builtinFuncName = awkFunctionCallBuiltIn.getBuiltinFuncName();
        if (builtinFuncName != null) {
          String funcName = builtinFuncName.getText();
          String documentation =
              getBuiltInFunctionDocumentation(builtinFuncName.getProject(), "awk::" + funcName);
          return postprocessDocumentation(funcName, documentation, false);
        }
      }
      {
        PsiElement builtinFuncNameGawk = awkFunctionCallBuiltIn.getBuiltinFuncNameGawk();
        if (builtinFuncNameGawk != null) {
          String funcName = builtinFuncNameGawk.getText();
          String documentation =
              getBuiltInFunctionDocumentation(
                  builtinFuncNameGawk.getProject(), "gawk::" + funcName);
          return postprocessDocumentation(funcName, documentation, true);
        }
      }
    } else if (element instanceof AwkBuiltinVarName) {
      AwkBuiltinVarName awkBuiltinVarName = (AwkBuiltinVarName) element;
      {
        PsiElement awkVarName = awkBuiltinVarName.getSpecialVarName();
        if (awkVarName != null) {
          String varName = awkVarName.getText();
          String documentation =
              getBuiltInVariableDocumentation(awkVarName.getProject(), "awk::" + varName);
          return postprocessDocumentation(varName, documentation, false);
        }
      }
      {
        PsiElement gawkVarName = awkBuiltinVarName.getSpecialVarNameGawk();
        if (gawkVarName != null) {
          String varName = gawkVarName.getText();
          String documentation =
              getBuiltInVariableDocumentation(gawkVarName.getProject(), "gawk::" + varName);
          return postprocessDocumentation(varName, documentation, true);
        }
      }
    }
    return null;
  }

  private String postprocessDocumentation(
      String builtInName, @Nullable String documentation, boolean isGawkBuiltIn) {
    if (documentation == null) {
      return "TODO: add documentation for " + builtInName;
    }
    if (documentation.contains("</dt>")) {
      StringBuilder res = new StringBuilder();

      String[] parts =
          documentation.split(Pattern.quote("</dt>"), builtInName.contains("asort") ? 3 : 2);

      for (int i = 0; i < parts.length - 1; i++) {
        res.append(DEFINITION_START)
            .append(parts[i].stripLeading())
            .append(
                isGawkBuiltIn
                    ? "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Gawk-only!</b>"
                    : "")
            .append("</dt>")
            .append(DEFINITION_END);
      }

      res.append(CONTENT_START).append(parts[parts.length - 1].stripLeading()).append(CONTENT_END);

      return res.toString();
    }
    return documentation;
  }

  private String getBuiltInVariableDocumentation(Project project, String varName) {
    AwkFile stdLibFile = getStdLibFile(project);

    PsiElement awkBuiltInVar =
        AwkUtil.findFirstMatchedDeep(
            stdLibFile,
            psiElement -> {
              if (!(psiElement instanceof AwkBuiltinVarName)) return false;
              String psiElemVarName = ((AwkBuiltinVarName) psiElement).getName();
              return psiElemVarName != null && psiElemVarName.equals(varName);
            });

    if (awkBuiltInVar == null) {
      return null;
    }

    PsiElement psiElemWithComment = AwkUtil.findParent(awkBuiltInVar, AwkTerminatedStatement.class);
    // It appears that for
    // {
    //   # comment1
    //   A=1
    //   # comment2
    //   A=2
    // }
    // The comment1 will be above AwkTerminatedStatementList and comment2 inside
    // AwkTerminatedStatement OF A=1 (sic!)
    if (psiElemWithComment.getPrevSibling() == null) {
      psiElemWithComment = psiElemWithComment.getParent();
    } else {
      psiElemWithComment = psiElemWithComment.getPrevSibling().getLastChild();
    }
    return AwkUtil.getDocStringFromCommentBefore(psiElemWithComment);
  }

  @Nullable
  private String getBuiltInFunctionDocumentation(Project project, String funcName) {
    AwkFile stdLibFile = getStdLibFile(project);

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

  private AwkFile getStdLibFile(Project project) {
    if (stdLibFile == null) {
      String text;
      try {
        InputStream stream = getResourceAsStream(STD_LIB_FILE_NAME);
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
    return stdLibFile;
  }

  @Override
  public @Nullable PsiElement getCustomDocumentationElement(
      @NotNull Editor editor,
      @NotNull PsiFile file,
      @Nullable PsiElement contextElement,
      int targetOffset) {
    if (AwkUtil.isType(contextElement, AwkTypes.PRINTF)
        || AwkUtil.isType(contextElement, AwkTypes.EXIT)) {
      return contextElement;
    }
    return super.getCustomDocumentationElement(editor, file, contextElement, targetOffset);
  }

  @Nullable
  private InputStream getResourceAsStream(String name) {
    InputStream stream = AwkDocumentationProvider.class.getClassLoader().getResourceAsStream(name);
    if (stream == null) { // this is for test scope
      stream = AwkDocumentationProvider.class.getResourceAsStream(name);
    }
    return stream;
  }
}
