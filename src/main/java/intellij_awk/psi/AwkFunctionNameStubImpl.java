package intellij_awk.psi;

import com.intellij.psi.stubs.IStubElementType;
import com.intellij.psi.stubs.StubBase;
import com.intellij.psi.stubs.StubElement;
import org.jetbrains.annotations.Nullable;

public class AwkFunctionNameStubImpl extends StubBase<AwkFunctionName>
    implements AwkFunctionNameStub {

  private final String name;

  public AwkFunctionNameStubImpl(@Nullable StubElement parent, String name) {
    super(parent, (IStubElementType<?, ?>) AwkTypes.FUNCTION_NAME);
    this.name = name;
  }

  @Override
  public String getName() {
    return name;
  }
}
