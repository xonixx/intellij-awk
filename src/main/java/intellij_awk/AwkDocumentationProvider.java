package intellij_awk;

import com.intellij.lang.documentation.AbstractDocumentationProvider;
import com.intellij.openapi.util.NlsSafe;
import com.intellij.psi.PsiElement;
import intellij_awk.psi.AwkFunctionCallBuiltIn;
import org.jetbrains.annotations.Nullable;

import static com.intellij.lang.documentation.DocumentationMarkup.*;

public class AwkDocumentationProvider extends AbstractDocumentationProvider {
  @Override
  public @Nullable @NlsSafe String generateDoc(
      PsiElement element, @Nullable PsiElement originalElement) {
    if (element instanceof AwkFunctionCallBuiltIn) {
      AwkFunctionCallBuiltIn awkFunctionCallBuiltIn = (AwkFunctionCallBuiltIn) element;
      PsiElement builtinFuncName = awkFunctionCallBuiltIn.getBuiltinFuncName();
      if (builtinFuncName != null) {
        String awkFuncName = builtinFuncName.getText();
        if ("gsub".equals(awkFuncName)) {
          return DEFINITION_START
              + "gsub(regexp, replacement [, target])"
              + DEFINITION_END
              + CONTENT_START
              + "content"
              + CONTENT_END;
        }
      }
    }
    return null;
  }
}
