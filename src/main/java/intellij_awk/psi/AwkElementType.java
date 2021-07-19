package intellij_awk.psi;

import com.intellij.psi.stubs.IStubElementType;
import com.intellij.psi.tree.IElementType;
import intellij_awk.AwkLanguage;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;

public class AwkElementType extends IElementType {

  public AwkElementType(@NotNull @NonNls String debugName) {
    super(debugName, AwkLanguage.INSTANCE);
  }

  public static IStubElementType<?, ?> getStubBasedElementType(String name) {
    switch (name) {
      case "FUNCTION_NAME":
        return new AwkFunctionNameStubElementType();
      default:
        throw new IllegalArgumentException(name);
    }
  }
}
