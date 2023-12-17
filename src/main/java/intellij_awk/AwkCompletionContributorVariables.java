package intellij_awk;

import static com.intellij.patterns.PlatformPatterns.psiElement;
import static com.intellij.patterns.StandardPatterns.*;

import com.intellij.codeInsight.completion.*;
import com.intellij.codeInsight.lookup.LookupElementBuilder;
import com.intellij.psi.PsiElement;
import com.intellij.util.ProcessingContext;
import intellij_awk.psi.*;
import intellij_awk.psi.impl.AwkUserVarNameImpl;
import java.util.ArrayList;
import java.util.List;
import org.jetbrains.annotations.NotNull;

public class AwkCompletionContributorVariables extends AwkCompletionContributorBase {

  public AwkCompletionContributorVariables() {
    extend(
        CompletionType.BASIC,
        notInsideERE(
            or(
                psiElement().inside(AwkExpr.class),
                psiElement().inside(AwkPrintExpr.class),
                not(psiElement().inside(AwkParamList.class))
                    .andOr(psiElement(AwkTypes.SPECIAL_VAR_NAME), psiElement(AwkTypes.VAR_NAME)))),
        new CompletionProvider<>() {
          public void addCompletions(
              @NotNull CompletionParameters parameters,
              @NotNull ProcessingContext context,
              @NotNull CompletionResultSet resultSet) {

            resultSet = adjustPrefix(resultSet, parameters);

            final PsiElement psiElement = parameters.getPosition();

            addFunctionParametersAndVarsInBody(resultSet, psiElement);

            addGlobalVarsInCurrentFile(resultSet, psiElement);

            addGlobalVarsInProject(resultSet, psiElement);

            boolean isInsideString = INSIDE_STRING.accepts(parameters.getPosition());

            if (!isInsideString) {
              addBuiltIns(resultSet);
            }
          }
        });
  }

  private void addFunctionParametersAndVarsInBody(
      @NotNull CompletionResultSet resultSet, PsiElement psiElement) {
    AwkItem awkItem = AwkUtil.findParent(psiElement, AwkItem.class);
    if (awkItem != null) {
      AwkParamList paramList = awkItem.getParamList();
      AwkFunctionNameMixin functionName = (AwkFunctionNameMixin) awkItem.getFunctionName();
      AwkAction action = awkItem.getAction();
      if (paramList != null) {
        List<String> params = functionName.getParameterNamesIncludingLocals();
        for (String param : params) {
          resultSet.addElement(LookupElementBuilder.create(param).withIcon(AwkIcons.PARAMETER));
        }
      }
      if (action != null) {
        List<PsiElement> varsInBody = AwkUtil.findUserVars(action);
        for (PsiElement var : varsInBody) {
          resultSet.addElement(
              LookupElementBuilder.create(var.getText()).withIcon(AwkIcons.VARIABLE));
        }
      }
    }
  }

  private void addGlobalVarsInCurrentFile(
      @NotNull CompletionResultSet resultSet, PsiElement psiElement) {
    AwkFile awkFile = (AwkFile) psiElement.getContainingFile();

    ArrayList<PsiElement> globalVars = new ArrayList<>();
    AwkUtil.findAllMatchedDeep(
        awkFile,
        psiEl ->
            psiEl instanceof AwkUserVarNameMixin
                && !((AwkUserVarNameMixin) psiEl).isALocalVariableInAFunction(),
        globalVars);

    for (PsiElement globalVar : globalVars) {
      resultSet.addElement(
          LookupElementBuilder.create(globalVar.getText()).withIcon(AwkIcons.VARIABLE));
    }
  }

  private void addGlobalVarsInProject(
      @NotNull CompletionResultSet resultSet, PsiElement psiElement) {
    List<AwkUserVarNameImpl> projectGlobalVars = AwkUtil.findGlobalVars(psiElement.getProject());

    int textOffset = psiElement.getTextOffset();

    for (AwkUserVarNameImpl projectGlobalVar : projectGlobalVars) {
      /*
      We need this if because when we query live AST, it returns var name at cursor with IntellijIdeaRulezzz suffix.
      When we query index - the var at caret returns as is, thus polluting the autocompletion with the name of current
      string being completed.
      */
      if (textOffset != projectGlobalVar.getTextOffset()) {
        resultSet.addElement(
            LookupElementBuilder.create(projectGlobalVar.getText()).withIcon(AwkIcons.VARIABLE));
      }
    }
  }

  private void addBuiltIns(@NotNull CompletionResultSet resultSet) {
    for (String builtInVariable : AwkVariables.builtInVariables) {
      resultSet.addElement(
          LookupElementBuilder.create(builtInVariable)
              .withBoldness(true)
              .withItemTextItalic(true)
              .withIcon(AwkIcons.VARIABLE));
    }
    for (String builtInVariable : AwkVariables.gawkVariables) {
      resultSet.addElement(
          LookupElementBuilder.create(builtInVariable)
              .withBoldness(true)
              .withItemTextItalic(true)
              .withIcon(AwkIcons.VARIABLE));
    }
  }
}
