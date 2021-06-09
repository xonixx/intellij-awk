package intellij_awk.psi;

import com.intellij.psi.tree.IElementType;
import intellij_awk.AwkLanguage;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;

public class AwkTokenType extends IElementType {

  public AwkTokenType(@NotNull @NonNls String debugName) {
    super(debugName, AwkLanguage.INSTANCE);
  }

  @Override
  public String toString() {
    return "AwkTokenType." + super.toString();
  }
}
