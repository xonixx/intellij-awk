package intellij_awk;

import com.intellij.lang.parameterInfo.*;
import com.intellij.openapi.util.TextRange;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiFile;
import com.intellij.psi.PsiReference;
import intellij_awk.psi.*;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.List;

// TODO handle the case f(1, 2,<cursor>) - for this, prob, need to adjust grammar with pins
// TODO can we better handle case f(  <caret> 1,2 ) ?
public class AwkParameterInfoHandler
    implements ParameterInfoHandler<AwkFunctionCall, AwkParameterInfoHandler.AwkParameterInfo> {

  private @Nullable AwkFunctionCall findElementForParameterInfoContext(
      @NotNull ParameterInfoContext context) {
    PsiFile file = context.getFile();
    int offset = context.getOffset();

    PsiElement elementAtCaret = file.findElementAt(offset);

    // TODO redo with com.intellij.lang.parameterInfo.ParameterInfoUtils.findParentOfType
    return AwkUtil.findParent(elementAtCaret, AwkFunctionCall.class);
  }

  @Override
  public @Nullable AwkFunctionCall findElementForParameterInfo(
      @NotNull CreateParameterInfoContext context) {
    AwkFunctionCall awkFunctionCall = findElementForParameterInfoContext(context);

    AwkParameterInfo awkParameterInfo = AwkParameterInfo.resolveFor(awkFunctionCall);
    context.setItemsToShow(awkParameterInfo == null ? null : new Object[] {awkParameterInfo});

    return awkFunctionCall;
  }

  @Override
  public void showParameterInfo(
      @NotNull AwkFunctionCall element, @NotNull CreateParameterInfoContext context) {
    context.showHint(element, element.getTextRange().getStartOffset(), this);
  }

  @Override
  public @Nullable AwkFunctionCall findElementForUpdatingParameterInfo(
      @NotNull UpdateParameterInfoContext context) {
    return findElementForParameterInfoContext(context);
  }

  @Override
  public void updateParameterInfo(
      @NotNull AwkFunctionCall awkFunctionCall, @NotNull UpdateParameterInfoContext context) {
    if (context.getParameterOwner() != awkFunctionCall) {
      context.removeHint();
      return;
    }
    AwkGawkFuncCallList funcCallList = awkFunctionCall.getGawkFuncCallList();
    int caretPos = context.getOffset();
    int funcCallStartOffset = awkFunctionCall.getTextRange().getStartOffset();
    PsiElement lParen =
        AwkUtil.findFirstMatchedDeep(
            awkFunctionCall, psiElement -> AwkUtil.isType(psiElement, AwkTypes.LPAREN));
    PsiElement rParen =
        AwkUtil.findFirstMatchedDeep(
            awkFunctionCall, psiElement -> AwkUtil.isType(psiElement, AwkTypes.RPAREN));
    int currentParameterIndex =
        funcCallStartOffset == caretPos
            ? -1
            : funcCallList == null /* function call with no args */
                ? (caretPos > lParen.getTextOffset() && caretPos <= rParen.getTextOffset() ? 0 : -1)
                : ParameterInfoUtils.getCurrentParameterIndex(
                    funcCallList.getNode(), caretPos, AwkTypes.COMMA);
    context.setCurrentParameter(currentParameterIndex);
  }

  @Override
  public void updateUI(AwkParameterInfo p, @NotNull ParameterInfoUIContext context) {
    TextRange range = p.getArgumentRange(context.getCurrentParameterIndex());
    context.setupUIComponentPresentation(
        p.getPresentText(),
        range.getStartOffset(),
        range.getEndOffset(),
        !context.isUIComponentEnabled(),
        false,
        false,
        context.getDefaultParameterColor() /*.brighter()*/
        /*if (p.valid) context.defaultParameterColor.brighter() else context.defaultParameterColor*/ );
  }

  static class AwkParameterInfo {
    private final List<String> argumentNames;

    AwkParameterInfo(AwkFunctionNameMixin functionName) {
      argumentNames = functionName.getArgumentNames();
    }

    public static AwkParameterInfo resolveFor(AwkFunctionCall awkFunctionCall) {
      if (awkFunctionCall instanceof AwkFunctionCallUser) {
        AwkFunctionCallUser functionCallUser = (AwkFunctionCallUser) awkFunctionCall;
        AwkFunctionCallNameMixin functionCallName =
            (AwkFunctionCallNameMixin) functionCallUser.getFunctionCallName();
        PsiReference reference = functionCallName.getReference();
        if (reference instanceof AwkReferenceFunction) {
          AwkReferenceFunction referenceFunction = (AwkReferenceFunction) reference;
          PsiElement psiElement = referenceFunction.resolve();
          if (psiElement instanceof AwkFunctionNameMixin) {
            AwkFunctionNameMixin functionName = (AwkFunctionNameMixin) psiElement;
            return new AwkParameterInfo(functionName);
          }
        }
      }
      return null;
    }

    public TextRange getArgumentRange(int index) {
      if (index < 0 || index >= argumentNames.size()) {
        return TextRange.EMPTY_RANGE;
      }
      int skip = 0;
      for (int i = 0; i < index; i++) {
        skip += argumentNames.get(i).length() + 2;
      }
      return new TextRange(skip, skip + argumentNames.get(index).length());
    }

    public String getPresentText() {
      return argumentNames.isEmpty() ? "<no parameters>" : String.join(", ", argumentNames);
    }

    @Override
    public String toString() {
      return getPresentText();
    }
  }
}
