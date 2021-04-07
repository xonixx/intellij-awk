package intellij_awk.psi;

import com.intellij.psi.tree.IElementType;
import intellij_awk.AwkLanguage;
import intellij_awk.SimpleLanguage;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;

public class AwkElementType extends IElementType {

  public AwkElementType(@NotNull @NonNls String debugName) {
    super(debugName, AwkLanguage.INSTANCE);
  }
}
