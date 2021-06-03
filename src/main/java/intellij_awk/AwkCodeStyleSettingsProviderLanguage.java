package intellij_awk;

import com.intellij.application.options.IndentOptionsEditor;
import com.intellij.application.options.SmartIndentOptionsEditor;
import com.intellij.lang.Language;
import com.intellij.psi.codeStyle.CodeStyleSettingsCustomizable;
import com.intellij.psi.codeStyle.CommonCodeStyleSettings;
import com.intellij.psi.codeStyle.LanguageCodeStyleSettingsProvider;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public class AwkCodeStyleSettingsProviderLanguage extends LanguageCodeStyleSettingsProvider {

  @NotNull
  @Override
  public Language getLanguage() {
    return AwkLanguage.INSTANCE;
  }

  @Override
  public void customizeSettings(
      @NotNull CodeStyleSettingsCustomizable consumer, @NotNull SettingsType settingsType) {

    // TODO for some reason this doesn't work - we want to hide some standard fields
    /*if (settingsType == SettingsType.INDENT_SETTINGS) {
      consumer.showStandardOptions("INDENT_SIZE");
    }*/
  }

  @Override
  public String getCodeSample(@NotNull SettingsType settingsType) {
    return "BEGIN {\n"
        + "    if (5>2) {\n"
        + "        print \"Hello world\"\n"
        + "    }\n"
        + "}\n"
        + "\n"
        + "function inc(i) {\n"
        + "    return i+1\n"
        + "}\n";
  }

  @Override
  public @Nullable IndentOptionsEditor getIndentOptionsEditor() {
    return new SmartIndentOptionsEditor();
  }

  @Override
  protected void customizeDefaults(
      @NotNull CommonCodeStyleSettings commonSettings,
      CommonCodeStyleSettings.@NotNull IndentOptions indentOptions) {
    indentOptions.INDENT_SIZE = 4;
  }
}
