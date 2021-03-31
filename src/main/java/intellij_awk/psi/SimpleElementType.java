package intellij_awk.psi;

import com.intellij.psi.tree.IElementType;
import intellij_awk.SimpleLanguage;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;

public class SimpleElementType extends IElementType {

  public SimpleElementType(@NotNull @NonNls String debugName) {
    super(debugName, SimpleLanguage.INSTANCE);
  }
}
