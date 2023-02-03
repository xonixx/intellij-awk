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

    @Override
    public void invoke(@NotNull Project project, Editor editor, PsiFile file)
        throws IncorrectOperationException {
      PsiElement psiElement = file.findElementAt(editor.getCaretModel().getOffset());
      //      System.out.println("INVOKE: " + psiElement.getText());

      AwkFunctionCallUser funcCall = AwkUtil.findParent(psiElement, AwkFunctionCallUser.class);
      AwkFunctionCallName funcCallName = funcCall.getFunctionCallName();

      AwkItem awkItem = AwkUtil.findParent(funcCallName, AwkItem.class);

      TemplateManager templateManager = TemplateManager.getInstance(project);
      Template template = templateManager.createTemplate("", "");
      template.setToReformat(true);
      template.addTextSegment("\nfunction " + funcCallName.getName() + "(");

      List<AwkExpr> exprList = funcCall.getGawkFuncCallList().getExprList();
      int exprListSize = exprList.size();
      for (int i = 0; i < exprListSize; i++) {
        AwkExpr awkExpr = exprList.get(i);
        String name = null;
        if (awkExpr instanceof AwkNonUnaryExpr) {
          AwkNonUnaryExpr nonUnaryExpr = (AwkNonUnaryExpr) awkExpr;
          AwkLvalue lvalue = nonUnaryExpr.getLvalue();
          if (lvalue != null && lvalue.getExpr() == null) {
            AwkUserVarName userVarName = lvalue.getUserVarName();
            if (userVarName != null) {
              name = userVarName.getName();
            }
          }
          if (name == null) {
            PsiElement number = nonUnaryExpr.getNumber();
            if (number != null) {
              String text = number.getText();
              if (Pattern.compile("\\d+").matcher(text).matches()) {
                name = "i" + text;
              }
            }
          }
//          PsiElement string = nonUnaryExpr.getString();

        }
        if (name == null) {
          name = "arg" + i;
        }

        template.addVariable(new ConstantNode(name), true);
        if (i < exprListSize - 1) template.addTextSegment(", ");
        //        System.out.println("EXPR: " + awkExpr);
      }

      template.addTextSegment("){}");
      //      template.addTextSegment("\n\n");
      //      template.addTextSegment(myFunctionText.getName() + "(");
      editor.getCaretModel().moveToOffset(awkItem.getTextRange().getEndOffset());
      templateManager.startTemplate(editor, template);
    }

    @Override
    public boolean startInWriteAction() {
      return true;
    }

    @Override
    public void applyFix(@NotNull Project project, @NotNull ProblemDescriptor descriptor) {
      /*AwkFunctionCallName awkFunctionCallName = (AwkFunctionCallName) descriptor.getPsiElement();
      AwkItem awkItem = AwkUtil.findParent(awkFunctionCallName, AwkItem.class);
      PsiElement parent = awkItem.getParent();
      parent.addAfter(
          AwkElementFactory.createFunctionItem(awkItem.getProject(), awkFunctionCallName.getName()),
          awkItem);
      parent.addAfter(AwkElementFactory.createNewline(awkItem.getProject()), awkItem);*/
    }
  }
}
