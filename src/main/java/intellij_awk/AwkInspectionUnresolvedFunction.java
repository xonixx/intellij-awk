package intellij_awk;

import com.intellij.codeInsight.intention.IntentionAction;
import com.intellij.codeInsight.template.Template;
import com.intellij.codeInsight.template.TemplateManager;
import com.intellij.codeInsight.template.impl.ConstantNode;
import com.intellij.codeInspection.*;
import com.intellij.codeInspection.util.IntentionFamilyName;
import com.intellij.codeInspection.util.IntentionName;
import com.intellij.openapi.editor.Editor;
import com.intellij.openapi.project.Project;
import com.intellij.psi.*;
import com.intellij.util.IncorrectOperationException;
import intellij_awk.psi.*;
import org.apache.commons.lang.StringEscapeUtils;
import org.jetbrains.annotations.NotNull;

import java.util.List;
import java.util.regex.Pattern;

public class AwkInspectionUnresolvedFunction extends LocalInspectionTool {

  private static final CreateNewFunctionQuickFix CREATE_NEW_FUNCTION_QUICK_FIX =
      new CreateNewFunctionQuickFix();
  public static final String QUICK_FIX_NAME = "Create new function with this name";

  @Override
  public @NotNull PsiElementVisitor buildVisitor(
      @NotNull ProblemsHolder holder, boolean isOnTheFly) {
    return new AwkVisitor() {
      @Override
      public void visitFunctionCallName(@NotNull AwkFunctionCallName functionCallName) {
        PsiReference reference = functionCallName.getReference();
        if (reference instanceof AwkReferenceFunction) {
          AwkReferenceFunction referenceFunction = (AwkReferenceFunction) reference;
          ResolveResult[] resolveResults = referenceFunction.multiResolve(false);
          if (resolveResults.length == 0) {
            holder.registerProblem(
                functionCallName,
                "Cannot resolve function '" + functionCallName.getName() + "'",
                ProblemHighlightType.GENERIC_ERROR,
                CREATE_NEW_FUNCTION_QUICK_FIX);
          }
        }
      }
    };
  }

  private static class CreateNewFunctionQuickFix implements LocalQuickFix, IntentionAction {

    private static final Pattern digits = Pattern.compile("\\d+");
    private static final Pattern nonDigits = Pattern.compile("\\D");
    private static final Pattern wordsWithSpaces = Pattern.compile("[a-zA-Z][a-zA-Z0-9 ]*");

    @Override
    public @IntentionName @NotNull String getText() {
      return getName();
    }

    @Override
    public @IntentionFamilyName @NotNull String getFamilyName() {
      return QUICK_FIX_NAME;
    }

    @Override
    public boolean isAvailable(@NotNull Project project, Editor editor, PsiFile file) {
      return true;
    }

    static class NameSequencer {
      final String prefix;
      int i = -1;

      NameSequencer(String prefix) {
        this.prefix = prefix;
      }

      String nextName() {
        return 0 == ++i ? prefix : prefix + i;
      }
    }

    @Override
    public void invoke(@NotNull Project project, Editor editor, PsiFile file)
        throws IncorrectOperationException {
      PsiElement psiElement = file.findElementAt(editor.getCaretModel().getOffset());

      AwkFunctionCallUser funcCall = AwkUtil.findParent(psiElement, AwkFunctionCallUser.class);
      AwkFunctionCallName funcCallName = funcCall.getFunctionCallName();

      AwkItem awkItem = AwkUtil.findParent(funcCallName, AwkItem.class);

      TemplateManager templateManager = TemplateManager.getInstance(project);
      Template template = templateManager.createTemplate("", "");
      template.setToReformat(true);
      template.addTextSegment("\nfunction " + funcCallName.getName() + "(");

      AwkGawkFuncCallList gawkFuncCallList = funcCall.getGawkFuncCallList();
      List<AwkExpr> exprList = gawkFuncCallList != null ? gawkFuncCallList.getExprList() : List.of();

      NameSequencer strNames = new NameSequencer("s");
      NameSequencer argsNames = new NameSequencer("arg");

      int exprListSize = exprList.size();
      for (int i = 0; i < exprListSize; i++) {
        AwkExpr awkExpr = exprList.get(i);
        String name = null;
        if (awkExpr instanceof AwkNonUnaryExpr) {
          AwkNonUnaryExpr nonUnaryExpr = (AwkNonUnaryExpr) awkExpr;
          AwkLvalue lvalue = nonUnaryExpr.getLvalue();
          if (lvalue != null && lvalue.getExpr() == null && lvalue.getExprLstList().isEmpty()) {
            AwkUserVarName userVarName = lvalue.getUserVarName();
            if (userVarName != null) {
              name = Util.lcFirst(userVarName.getName());
            }
          }
          if (name == null) {
            PsiElement number = nonUnaryExpr.getNumber();
            if (number != null && number.getText().equals(nonUnaryExpr.getText())) {
              String text = number.getText();
              if (digits.matcher(text).matches()) {
                name = "i" + text;
              } else {
                name = "f" + nonDigits.matcher(text).replaceAll("");
              }
            }
          }
          if (name == null) {
            PsiElement string = nonUnaryExpr.getString();
            if (string != null && string.getText().equals(nonUnaryExpr.getText())) {
              String text = string.getText();
              name = text.substring(1, text.length() - 1);
              if (wordsWithSpaces.matcher(name).matches()) {
                name = Util.stringToCamelCase(name);
              } else {
                name = strNames.nextName();
              }
            }
          }
        }
        if (name == null) {
          name = argsNames.nextName();
        }

        template.addVariable(new ConstantNode(name), true);
        if (i < exprListSize - 1) {
          template.addTextSegment(", ");
        }
      }

      template.addTextSegment(") {");
      template.addEndVariable();
      template.addTextSegment("}");
      editor.getCaretModel().moveToOffset(awkItem.getTextRange().getEndOffset());
      templateManager.startTemplate(editor, template);
    }

    @Override
    public boolean startInWriteAction() {
      return true;
    }

    @Override
    public void applyFix(@NotNull Project project, @NotNull ProblemDescriptor descriptor) {}
  }
}
