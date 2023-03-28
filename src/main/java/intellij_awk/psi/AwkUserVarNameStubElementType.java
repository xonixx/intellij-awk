package intellij_awk.psi;

import com.intellij.psi.stubs.*;
import intellij_awk.AwkLanguage;
import intellij_awk.psi.impl.AwkUserVarNameImpl;
import java.io.IOException;
import org.jetbrains.annotations.NotNull;

public class AwkUserVarNameStubElementType
    extends /*TODO ILightStubElementType*/ IStubElementType<AwkUserVarNameStub, AwkUserVarName> {
  public AwkUserVarNameStubElementType() {
    super("USER_VAR_NAME", AwkLanguage.INSTANCE);
  }

  @Override
  public AwkUserVarName createPsi(@NotNull AwkUserVarNameStub stub) {
    return new AwkUserVarNameImpl(stub, this);
  }

  @Override
  public @NotNull AwkUserVarNameStub createStub(
      @NotNull AwkUserVarName psi, StubElement<?> parentStub) {
    return new AwkUserVarNameStubImpl(
        parentStub,
        psi.getName(),
        ((AwkUserVarNameMixin) psi).looksLikeDeclaration(),
        ((AwkUserVarNameMixin) psi).isInsideInitializingContext());
  }

  @Override
  public @NotNull String getExternalId() {
    return "awk.userVarName";
  }

  @Override
  public void serialize(@NotNull AwkUserVarNameStub stub, @NotNull StubOutputStream dataStream)
      throws IOException {
    dataStream.writeName(stub.getName());
    dataStream.writeBoolean(stub.looksLikeDeclaration());
    dataStream.writeBoolean(stub.isInsideInitializingContext());
  }

  @Override
  public @NotNull AwkUserVarNameStub deserialize(
      @NotNull StubInputStream dataStream, StubElement parentStub) throws IOException {
    return new AwkUserVarNameStubImpl(
        parentStub,
        dataStream.readNameString(),
        dataStream.readBoolean(),
        dataStream.readBoolean());
  }

  @Override
  public void indexStub(@NotNull AwkUserVarNameStub stub, @NotNull IndexSink sink) {
    if (stub.isDeclaration()) {
      sink.occurrence(IndexUserVarDeclarations.KEY, stub.getName());
    }
  }

  public static class IndexUserVarDeclarations
      extends StringStubIndexExtension<AwkUserVarNameImpl> {
    public static StubIndexKey<String, AwkUserVarNameImpl> KEY =
        StubIndexKey.createIndexKey(AwkUserVarName.class.getCanonicalName() + "_DeclInit");

    @Override
    public @NotNull StubIndexKey<String, AwkUserVarNameImpl> getKey() {
      return KEY;
    }
  }
}
