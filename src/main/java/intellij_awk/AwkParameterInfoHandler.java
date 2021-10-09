package intellij_awk;

import com.intellij.lang.parameterInfo.*;
import com.intellij.openapi.util.TextRange;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiReference;
import intellij_awk.psi.*;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.ArrayList;
import java.util.List;

import static intellij_awk.AwkUtil.findFirstMatchedDeep;

// TODO can we better handle case f(  <caret> 1,2 ) ?
// TODO handle printf
// TODO handle ... last param
public class AwkParameterInfoHandler
    implements ParameterInfoHandler<AwkFunctionCall, AwkParameterInfoHandler.AwkParameterInfo> {

  private @Nullable AwkFunctionCall findElementForParameterInfoContext(
      @NotNull ParameterInfoContext context) {
    return ParameterInfoUtils.findParentOfType(
        context.getFile(), context.getOffset(), AwkFunctionCall.class);
  }

  @Override
  public @Nullable AwkFunctionCall findElementForParameterInfo(
      @NotNull CreateParameterInfoContext context) {
    AwkFunctionCall awkFunctionCall = findElementForParameterInfoContext(context);

    context.setItemsToShow(AwkParameterInfo.resolveFor(awkFunctionCall));

    return awkFunctionCall;
  }

  @Override
  public void showParameterInfo(
      @NotNull AwkFunctionCall element, @NotNull CreateParameterInfoContext context) {
    context.showHint(element, element.getTextOffset(), this);
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
    int funcCallStartOffset = awkFunctionCall.getTextOffset();
    PsiElement lParen;
    int currentParameterIndex =
        funcCallStartOffset == caretPos
            ? -1
            : funcCallList == null /* function call with no args */
                ? ((lParen = findFirstMatchedDeep(awkFunctionCall, AwkTypes.LPAREN)) != null
                        && caretPos > lParen.getTextOffset()
                        && caretPos
                            <= findFirstMatchedDeep(awkFunctionCall, AwkTypes.RPAREN)
                                .getTextOffset()
                    ? 0
                    : -1)
                : ParameterInfoUtils.getCurrentParameterIndex(
                    funcCallList.getNode(), caretPos, AwkTypes.COMMA);
    context.setCurrentParameter(currentParameterIndex);
  }

  @Override
  public void updateUI(AwkParameterInfo p, @NotNull ParameterInfoUIContext context) {
    TextRange range = p.getParameterRange(context.getCurrentParameterIndex());
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
    private final List<String> parameterNames;

    AwkParameterInfo(AwkFunctionNameMixin functionName) {
      this(functionName.getParameterNames());
    }

    public AwkParameterInfo(List<String> parameterNames) {
      this.parameterNames = parameterNames;
    }

    public static AwkParameterInfo[] resolveFor(AwkFunctionCall awkFunctionCall) {
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
            return new AwkParameterInfo[] {new AwkParameterInfo(functionName)};
          }
        }
      } else if (awkFunctionCall instanceof AwkFunctionCallBuiltIn) {
        AwkFunctionCallBuiltIn functionCallBuiltIn = (AwkFunctionCallBuiltIn) awkFunctionCall;
        PsiElement nameElement = functionCallBuiltIn.getBuiltinFuncName();
        if (nameElement == null) {
          nameElement = functionCallBuiltIn.getBuiltinFuncNameGawk();
        }
        if (nameElement == null) {
          throw new IllegalArgumentException("no function name");
        }
        AwkFunctions.ParametersHint parametersHint =
            AwkFunctions.resolveParameterHints(nameElement.getText());
        if (parametersHint.optionalsStarting == null) {
          return new AwkParameterInfo[] {new AwkParameterInfo(parametersHint.parameterNames)};
        } else {
          List<AwkParameterInfo> res = new ArrayList<>();
          for (int i = parametersHint.optionalsStarting;
              i <= parametersHint.parameterNames.size();
              i++) {
            res.add(new AwkParameterInfo(parametersHint.parameterNames.subList(0, i)));
          }
          return res.toArray(new AwkParameterInfo[0]);
        }
      }
      return null;
    }

    public TextRange getParameterRange(int index) {
      if (index < 0 || index >= parameterNames.size()) {
        return TextRange.EMPTY_RANGE;
      }
      int skip = 0;
      for (int i = 0; i < index; i++) {
        skip += parameterNames.get(i).length() + 2;
      }
      return new TextRange(skip, skip + parameterNames.get(index).length());
    }

    public String getPresentText() {
      return parameterNames.isEmpty() ? "<no parameters>" : String.join(", ", parameterNames);
    }

    @Override
    public String toString() {
      return getPresentText();
    }
  }
}
