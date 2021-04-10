package intellij_awk.psi;

import com.intellij.extapi.psi.PsiFileBase;
import com.intellij.openapi.fileTypes.FileType;
import com.intellij.psi.FileViewProvider;
import intellij_awk.AwkFileType;
import intellij_awk.AwkLanguage;
import org.jetbrains.annotations.NotNull;

public class AwkFile extends PsiFileBase {

  public AwkFile(@NotNull FileViewProvider viewProvider) {
    super(viewProvider, AwkLanguage.INSTANCE);
  }

  @NotNull
  @Override
  public FileType getFileType() {
    return AwkFileType.INSTANCE;
  }

  @Override
  public String toString() {
    return "AWK File";
  }
}
