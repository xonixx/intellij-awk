package intellij_awk;

import com.intellij.openapi.fileTypes.LanguageFileType;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;

public class AwkFileType extends LanguageFileType {

  public static final AwkFileType INSTANCE = new AwkFileType();

  private AwkFileType() {
    super(AwkLanguage.INSTANCE);
  }

  @NotNull
  @Override
  public String getName() {
    return "AWK File";
  }

  @NotNull
  @Override
  public String getDescription() {
    return "AWK language file";
  }

  @NotNull
  @Override
  public String getDefaultExtension() {
    return "awk";
  }

  @Nullable
  @Override
  public Icon getIcon() {
    return AwkIcons.FILE;
  }
}
