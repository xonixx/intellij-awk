package intellij_awk.psi;

import com.intellij.extapi.psi.PsiFileBase;
import com.intellij.openapi.fileTypes.FileType;
import com.intellij.psi.FileViewProvider;
import intellij_awk.SimpleFileType;
import intellij_awk.SimpleLanguage;
import org.jetbrains.annotations.NotNull;

public class SimpleFile extends PsiFileBase {

  public SimpleFile(@NotNull FileViewProvider viewProvider) {
    super(viewProvider, SimpleLanguage.INSTANCE);
  }

  @NotNull
  @Override
  public FileType getFileType() {
    return SimpleFileType.INSTANCE;
  }

  @Override
  public String toString() {
    return "Simple File";
  }
}
