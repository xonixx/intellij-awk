package intellij_awk;

import static intellij_awk.AwkUtil.isType;

import com.intellij.codeInspection.*;
import com.intellij.codeInspection.util.IntentionFamilyName;
import com.intellij.openapi.project.Project;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.PsiReference;
import com.intellij.psi.PsiWhiteSpace;
import com.intellij.psi.search.searches.ReferencesSearch;
import com.intellij.util.Query;
import intellij_awk.psi.*;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import org.jetbrains.annotations.NotNull;

public class AwkInspectionUnusedFunctionParam extends LocalInspectionTool {

  private static final DeleteUnusedFunctionParamQuickFix deleteUnusedFunctionParamQuickFix =
      new DeleteUnusedFunctionParamQuickFix();
  public static final String QUICK_FIX_NAME = "Delete unused parameter";

  @Override
  public @NotNull PsiElementVisitor buildVisitor(
      @NotNull ProblemsHolder holder, boolean isOnTheFly) {
    return new AwkVisitor() {
      @Override
      public void visitItem(@NotNull AwkItem awkItem) {
        AwkParamList paramList = awkItem.getParamList();
        if (paramList != null) {
          List<AwkUserVarName> paramNameList = paramList.getUserVarNameList();
          List<PsiElement> userVars = AwkUtil.findUserVars(awkItem.getAction());
          Set<String> varsInFunctionBody =
              userVars.stream().map(PsiElement::getText).collect(Collectors.toSet());
          for (AwkUserVarName paramName : paramNameList) {
            if (!varsInFunctionBody.contains(paramName.getName())) {
              holder.registerProblem(
                  paramName,
                  "Parameter '" + paramName.getName() + "' is never used",
                  ProblemHighlightType.LIKE_UNUSED_SYMBOL,
                  deleteUnusedFunctionParamQuickFix);
            }
          }
        }
      }
    };
  }

  private static class DeleteUnusedFunctionParamQuickFix implements LocalQuickFix {

    @Override
    public @IntentionFamilyName @NotNull String getFamilyName() {
      return QUICK_FIX_NAME;
    }

    @Override
    public void applyFix(@NotNull Project project, @NotNull ProblemDescriptor descriptor) {
      AwkUserVarNameMixin paramName = (AwkUserVarNameMixin) descriptor.getPsiElement();
      AwkParamList paramList = (AwkParamList) paramName.getParent();
      List<AwkUserVarName> varNameList = paramList.getUserVarNameList();

      int paramIndex = -1;
      for (int i = 0; i < varNameList.size(); i++) {
        AwkUserVarName varName = varNameList.get(i);
        if (varName.equals(paramName)) {
          paramIndex = i;
          break;
        }
      }

      AwkItem awkItem = AwkUtil.findParent(paramName, AwkItem.class);
      AwkFunctionNameMixin functionName = (AwkFunctionNameMixin) awkItem.getFunctionName();

      if (functionName != null) { // we found the function node
        Query<PsiReference> functionCallRefs = ReferencesSearch.search(functionName);
        for (PsiReference functionCallRef_ : functionCallRefs) {
          AwkReferenceFunction functionCallRef = (AwkReferenceFunction) functionCallRef_;
          AwkFunctionCallNameMixin functionCallName =
              (AwkFunctionCallNameMixin) functionCallRef.getElement();

          PsiElement possiblyCallArgs =
              AwkUtil.getNextNotWhitespace(
                  functionCallName.getNextSibling() /* ( */) /* args? || ) */;
          if (possiblyCallArgs instanceof AwkGawkFuncCallList) {
            AwkGawkFuncCallList funcCallList = (AwkGawkFuncCallList) possiblyCallArgs;
            List<AwkExpr> exprList = funcCallList.getExprList();
            if (paramIndex < exprList.size()) {
              AwkExpr expr = exprList.get(paramIndex);
              deleteWithNeighborComma(expr);
            }
          }
        }

        boolean isLastLocalParam = isLastLocalParam(paramName, functionName);
        if (isLastLocalParam) {
          PsiElement possibleLocalsStartMarker = paramName.getPrevSibling();
          if (possibleLocalsStartMarker == null) {
            // apparently, if there is only one func param, the whitespace goes before the param
            // container
            possibleLocalsStartMarker = paramList.getPrevSibling();
          }
          if (AwkUtil.isLocalsMarkingDelimiter(possibleLocalsStartMarker)) {
            possibleLocalsStartMarker.delete();
          }
        }
      }

      deleteWithNeighborComma(paramName);

//      normalizeParamsFormatting(paramList);
    }
  }

  private static boolean isLastLocalParam(
      AwkUserVarNameMixin paramName, AwkFunctionNameMixin functionName) {
    List<String> parameterNames = functionName.getParameterNames();
    List<String> parameterNamesIncludingLocals = functionName.getParameterNamesIncludingLocals();
    Set<String> locals = new HashSet<>(parameterNamesIncludingLocals);
    locals.removeAll(parameterNames);
    String paramNameS = paramName.getName();
    return locals.size() == 1 && locals.contains(paramNameS);
  }

  private static void deleteWithNeighborComma(PsiElement element) {
    PsiElement next = AwkUtil.getNextNotWhitespace(element);
    if (isType(next, AwkTypes.COMMA)) {
      if (next.getPrevSibling() instanceof PsiWhiteSpace) {
        next.getPrevSibling().delete();
      }
      if (next.getNextSibling() instanceof PsiWhiteSpace && !AwkUtil.isLocalsMarkingDelimiter(next.getNextSibling())) {
        next.getNextSibling().delete();
      }
      next.delete();
    } else {
      PsiElement prev = AwkUtil.getPrevNotWhitespace(element);
      if (isType(prev, AwkTypes.COMMA)) {
        prev.delete();
      }
    }
    element.delete();
  }

  /**
   *
   *
   * <pre><code>a,  b, c</code></pre>
   *
   * ->
   *
   * <pre><code>a, b, c</code></pre>
   */
  private static void normalizeParamsFormatting(AwkParamList paramList) {
    // The idea is to substitute each whitespace of two spaces with a single space.
    // Additionally, if we are past locals-marking delimiter, we substitute 2+ spaces with one.
    boolean pastLocalsMarkingDelimiter = false;
    for (PsiElement e = paramList.getFirstChild(); e != null; e = e.getNextSibling()) {
      if (AwkUtil.isLocalsMarkingDelimiter(e)) {
        pastLocalsMarkingDelimiter = true;
        continue;
      }
      if (e instanceof PsiWhiteSpace) {
        PsiWhiteSpace psiWhiteSpace = (PsiWhiteSpace) e;
        int len = psiWhiteSpace.getTextLength();
        if (pastLocalsMarkingDelimiter && len > 1 || len == 2) {
          psiWhiteSpace.replace(AwkElementFactory.createWhiteSpaces(e.getProject(), 1));
        }
      }
    }
  }
}
