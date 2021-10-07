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

public class AwkParameterInfoHandler
    implements ParameterInfoHandler<AwkFunctionCall, AwkParameterInfoHandler.AwkParameterInfo> {

  private @Nullable AwkFunctionCall findElementForParameterInfoContext(
      @NotNull ParameterInfoContext context) {
    PsiFile file = context.getFile();
    int offset = context.getOffset();

    PsiElement elementAtCaret = file.findElementAt(offset);

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
    int currentParameterIndex =
        awkFunctionCall.getTextRange().getStartOffset() == context.getOffset()
            ? -1
            : ParameterInfoUtils.getCurrentParameterIndex(
                /*TODO*/ awkFunctionCall.getGawkFuncCallList().getNode(),
                context.getOffset(),
                AwkTypes.COMMA);
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
        context.getDefaultParameterColor().brighter()
        /*if (p.valid) context.defaultParameterColor.brighter() else context.defaultParameterColor*/ );
  }

  static class AwkParameterInfo {
    private final AwkFunctionNameMixin functionName;
    private final List<String> argumentNames;

    AwkParameterInfo(AwkFunctionNameMixin functionName) {
      this.functionName = functionName;
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
            //            List<String> argumentNames = functionName.getArgumentNames();
            return new AwkParameterInfo(functionName);
          }
        }
      }
      return null;
    }

    public TextRange getArgumentRange(int currentParameterIndex) {
      int skip = 0;
      for (int i = 0; i < currentParameterIndex && i < argumentNames.size(); i++) {
        skip += argumentNames.get(i).length() + 2;
      }
      return new TextRange(skip, skip + argumentNames.get(currentParameterIndex).length());
    }

    public String getPresentText() {
      return String.join(", ", argumentNames);
    }
  }
}
