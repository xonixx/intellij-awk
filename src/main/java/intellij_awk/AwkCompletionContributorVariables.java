package intellij_awk;

import com.intellij.codeInsight.completion.*;
import com.intellij.codeInsight.lookup.LookupElementBuilder;
import com.intellij.psi.PsiElement;
import com.intellij.util.ProcessingContext;
import intellij_awk.psi.*;
import intellij_awk.psi.impl.AwkFunctionNameMixin;
import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.List;

import static com.intellij.patterns.PlatformPatterns.psiElement;

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

  public AwkCompletionContributorVariables() {
    extend(
        CompletionType.BASIC,
        psiElement().inside(AwkExpr.class),
        new CompletionProvider<>() {
          public void addCompletions(
              @NotNull CompletionParameters parameters,
              @NotNull ProcessingContext context,
              @NotNull CompletionResultSet resultSet) {

            final PsiElement psiElement = parameters.getPosition();
            {
              AwkItem awkItem = AwkUtil.findParent(psiElement, AwkItem.class);
              if (awkItem != null) {
                AwkParamList paramList = awkItem.getParamList();
                if (paramList != null) {
                  AwkFunctionNameMixin functionName =
                      (AwkFunctionNameMixin) awkItem.getFunctionName();
                  List<String> args = functionName.getArgumentNamesIncludingLocals();
                  for (String arg : args) {
                    resultSet.addElement(
                        LookupElementBuilder.create(arg).withIcon(AwkIcons.PARAMETER));
                  }
                }
              }
            }

            AwkFile awkFile = (AwkFile) psiElement.getContainingFile();

            for (PsiElement child : awkFile.getChildren()) {
              if (child instanceof AwkItem) {
                AwkItem awkItem = (AwkItem) child;
                AwkPattern pattern = awkItem.getPattern();
                if (pattern != null) {
                  if (AwkUtil.isAwkBegin(pattern.getBeginOrEnd())) {

                    ArrayList<PsiElement> globalVars = new ArrayList<>();
                    AwkUtil.findAllMatchedDeep(
                        awkItem.getAction(), psiEl -> psiEl instanceof AwkUserVarName, globalVars);
                    for (PsiElement globalVar : globalVars) {
                      resultSet.addElement(
                          LookupElementBuilder.create(globalVar.getText())
                              .withIcon(AwkIcons.VARIABLE));
                    }
                  }
                }
              }
            }

            for (String builtInVariable : builtInVariables) {
              resultSet.addElement(
                  LookupElementBuilder.create(builtInVariable)
                      .withBoldness(true)
                      .withItemTextItalic(true)
                      .withIcon(AwkIcons.VARIABLE));
            }
          }
        });
  }
}
