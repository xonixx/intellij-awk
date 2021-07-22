package intellij_awk;

import com.intellij.codeInsight.completion.*;
import com.intellij.codeInsight.lookup.LookupElementBuilder;
import com.intellij.psi.PsiElement;
import com.intellij.util.ProcessingContext;
import intellij_awk.psi.*;
import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.List;

import static com.intellij.patterns.PlatformPatterns.psiElement;
import static com.intellij.patterns.StandardPatterns.not;
import static com.intellij.patterns.StandardPatterns.or;

public class AwkCompletionContributorVariables extends CompletionContributor {

  private static final String[] builtInVariables =
      new String[] {
        "ARGC",
        "ARGV",
        "CONVFMT",
        "ENVIRON",
        "FILENAME",
        "FNR",
        "FS",
        "NF",
        "NR",
        "OFMT",
        "OFS",
        "ORS",
        "RLENGTH",
        "RS",
        "RSTART",
        "SUBSEP"
      };

  private static final String[] gawkVariables =
      new String[] {
        "BINMODE",
        "FIELDWIDTHS",
        "FPAT",
        "IGNORECASE",
        "LINT",
        "PREC",
        "ROUNDMODE",
        "TEXTDOMAIN",
        "ARGIND",
        "ERRNO",
        "FUNCTAB",
        "PROCINFO",
        "RT",
        "SYMTAB"
      };

  public AwkCompletionContributorVariables() {
    extend(
        CompletionType.BASIC,
        or(
            psiElement().inside(AwkExpr.class),
            not(psiElement().inside(AwkParamList.class))
                .andOr(psiElement(AwkTypes.SPECIAL_VAR_NAME), psiElement(AwkTypes.VAR_NAME))),
        new CompletionProvider<>() {
          public void addCompletions(
              @NotNull CompletionParameters parameters,
              @NotNull ProcessingContext context,
              @NotNull CompletionResultSet resultSet) {

            final PsiElement psiElement = parameters.getPosition();

            addFunctionArguments(resultSet, psiElement);

            addGlobalVars(resultSet, psiElement);

            addBuiltIns(resultSet);
          }
        });
  }

  private void addFunctionArguments(@NotNull CompletionResultSet resultSet, PsiElement psiElement) {
    AwkItem awkItem = AwkUtil.findParent(psiElement, AwkItem.class);
    if (awkItem != null) {
      AwkParamList paramList = awkItem.getParamList();
      if (paramList != null) {
        AwkFunctionNameMixin functionName = (AwkFunctionNameMixin) awkItem.getFunctionName();
        List<String> args = functionName.getArgumentNamesIncludingLocals();
        for (String arg : args) {
          resultSet.addElement(LookupElementBuilder.create(arg).withIcon(AwkIcons.PARAMETER));
        }
      }
    }
  }

  private void addGlobalVars(@NotNull CompletionResultSet resultSet, PsiElement psiElement) {
    AwkFile awkFile = (AwkFile) psiElement.getContainingFile();

    for (PsiElement child : awkFile.getChildren()) {
      if (child instanceof AwkItem) {
        AwkItem awkItem = (AwkItem) child;
        AwkPattern pattern = awkItem.getPattern();
        if (pattern != null) {
          if (pattern.getBeginOrEnd() instanceof AwkBeginBlock) {

            ArrayList<PsiElement> globalVars = new ArrayList<>();
            AwkUtil.findAllMatchedDeep(
                awkItem.getAction(), psiEl -> psiEl instanceof AwkUserVarName, globalVars);
            for (PsiElement globalVar : globalVars) {
              resultSet.addElement(
                  LookupElementBuilder.create(globalVar.getText()).withIcon(AwkIcons.VARIABLE));
            }
          }
        }
      }
    }
  }

  private void addBuiltIns(@NotNull CompletionResultSet resultSet) {
    for (String builtInVariable : builtInVariables) {
      resultSet.addElement(
          LookupElementBuilder.create(builtInVariable)
              .withBoldness(true)
              .withItemTextItalic(true)
              .withIcon(AwkIcons.VARIABLE));
    }
    for (String builtInVariable : gawkVariables) {
      resultSet.addElement(
          LookupElementBuilder.create(builtInVariable)
              .withBoldness(true)
              .withItemTextItalic(true)
              .withIcon(AwkIcons.VARIABLE));
    }
  }
}
