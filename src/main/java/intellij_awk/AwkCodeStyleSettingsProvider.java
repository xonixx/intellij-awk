package intellij_awk;

import com.intellij.application.options.CodeStyleAbstractConfigurable;
import com.intellij.application.options.CodeStyleAbstractPanel;
import com.intellij.application.options.TabbedLanguageCodeStylePanel;
import com.intellij.psi.codeStyle.CodeStyleConfigurable;
import com.intellij.psi.codeStyle.CodeStyleSettings;
import com.intellij.psi.codeStyle.CodeStyleSettingsProvider;
import com.intellij.psi.codeStyle.CustomCodeStyleSettings;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public class AwkCodeStyleSettingsProvider extends CodeStyleSettingsProvider {

  @Override
  public CustomCodeStyleSettings createCustomSettings(CodeStyleSettings settings) {
    return new AwkCodeStyleSettings(settings);
  }

  @Nullable
  @Override
  public String getConfigurableDisplayName() {
    return AwkLanguage.INSTANCE.getDisplayName();
  }

  @NotNull
  public CodeStyleConfigurable createConfigurable(
      @NotNull CodeStyleSettings settings, @NotNull CodeStyleSettings modelSettings) {
    return new CodeStyleAbstractConfigurable(
        settings, modelSettings, getConfigurableDisplayName()) {
      @Override
      protected CodeStyleAbstractPanel createPanel(CodeStyleSettings settings) {
        return new AwkCodeStyleMainPanel(getCurrentSettings(), settings);
      }
    };
  }

  private static class AwkCodeStyleMainPanel extends TabbedLanguageCodeStylePanel {

    public AwkCodeStyleMainPanel(CodeStyleSettings currentSettings, CodeStyleSettings settings) {
      super(AwkLanguage.INSTANCE, currentSettings, settings);
    }

    @Override
    protected void initTabs(CodeStyleSettings settings) {
      addIndentOptionsTab(settings);
    }
  }
}
