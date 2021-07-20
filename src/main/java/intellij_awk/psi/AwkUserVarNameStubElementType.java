package intellij_awk.psi;

import com.intellij.psi.stubs.*;
import intellij_awk.AwkLanguage;
import intellij_awk.psi.impl.AwkUserVarNameImpl;
import org.jetbrains.annotations.NotNull;

import java.io.IOException;

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
        parentStub, psi.getName(), ((AwkUserVarNameMixin) psi).looksLikeDeclaration());
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
  }

  @Override
  public @NotNull AwkUserVarNameStub deserialize(
      @NotNull StubInputStream dataStream, StubElement parentStub) throws IOException {
    return new AwkUserVarNameStubImpl(
        parentStub, dataStream.readNameString(), dataStream.readBoolean());
  }

  @Override
  public void indexStub(@NotNull AwkUserVarNameStub stub, @NotNull IndexSink sink) {
    sink.occurrence(
        stub.looksLikeDeclaration() ? IndexVarDeclarations.KEY : IndexVarUsage.KEY, stub.getName());
  }

  public static class IndexVarDeclarations extends StringStubIndexExtension<AwkUserVarNameImpl> {
    public static StubIndexKey<String, AwkUserVarNameImpl> KEY =
        StubIndexKey.createIndexKey(AwkUserVarName.class.getCanonicalName() + "|Declarations");

    @Override
    public @NotNull StubIndexKey<String, AwkUserVarNameImpl> getKey() {
      return KEY;
    }
  }

  public static class IndexVarUsage extends StringStubIndexExtension<AwkUserVarNameImpl> {
    public static StubIndexKey<String, AwkUserVarNameImpl> KEY =
        StubIndexKey.createIndexKey(AwkUserVarName.class.getCanonicalName() + "|Usage");

    @Override
    public @NotNull StubIndexKey<String, AwkUserVarNameImpl> getKey() {
      return KEY;
    }
  }
}
