package intellij_awk;

import com.intellij.application.options.IndentOptionsEditor;
import com.intellij.application.options.SmartIndentOptionsEditor;
import com.intellij.lang.Language;
import com.intellij.psi.codeStyle.CodeStyleSettingsCustomizable;
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
      @NotNull CodeStyleSettingsCustomizable consumer, @NotNull SettingsType settingsType) {}

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
}
