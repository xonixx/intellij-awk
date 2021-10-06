package intellij_awk;

import com.intellij.lang.parameterInfo.CreateParameterInfoContext;
import com.intellij.lang.parameterInfo.ParameterInfoHandler;
import com.intellij.lang.parameterInfo.ParameterInfoUIContext;
import com.intellij.lang.parameterInfo.UpdateParameterInfoContext;
import intellij_awk.psi.AwkFunctionCall;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public class AwkParameterInfoHandler implements ParameterInfoHandler<AwkFunctionCall,AwkParameterInfo> {
    @Override
    public @Nullable AwkFunctionCall findElementForParameterInfo(@NotNull CreateParameterInfoContext context) {
        return null;
    }

    @Override
    public void showParameterInfo(@NotNull AwkFunctionCall element, @NotNull CreateParameterInfoContext context) {

    }

    @Override
    public @Nullable AwkFunctionCall findElementForUpdatingParameterInfo(@NotNull UpdateParameterInfoContext context) {
        return null;
    }

    @Override
    public void updateParameterInfo(@NotNull AwkFunctionCall awkFunctionCall, @NotNull UpdateParameterInfoContext context) {

    }

    @Override
    public void updateUI(AwkParameterInfo p, @NotNull ParameterInfoUIContext context) {

    }
}
