package intellij_awk.psi;

import com.intellij.psi.stubs.IStubElementType;
import com.intellij.psi.stubs.StubBase;
import com.intellij.psi.stubs.StubElement;
import org.jetbrains.annotations.Nullable;

public class AwkUserVarNameStubImpl extends StubBase<AwkUserVarName> implements AwkUserVarNameStub {

  private final String name;
  private final boolean looksLikeDeclaration;
  private final boolean insideInitializingContext;

  public AwkUserVarNameStubImpl(
      @Nullable StubElement parent,
      String name,
      boolean looksLikeDeclaration,
      boolean insideInitializingContext) {
    super(parent, (IStubElementType<?, ?>) AwkTypes.USER_VAR_NAME);
    this.name = name;
    this.looksLikeDeclaration = looksLikeDeclaration;
    this.insideInitializingContext = insideInitializingContext;
  }

  @Override
  public String getName() {
    return name;
  }

  @Override
  public boolean looksLikeDeclaration() {
    return looksLikeDeclaration;
  }

  @Override
  public boolean isInsideInitializingContext() {
    return insideInitializingContext;
  }
}
