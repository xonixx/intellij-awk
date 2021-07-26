package intellij_awk.psi;

import com.intellij.psi.stubs.*;
import intellij_awk.AwkLanguage;
import intellij_awk.psi.impl.AwkFunctionNameImpl;
import org.jetbrains.annotations.NotNull;

import java.io.IOException;

public class AwkFunctionNameStubElementType
    extends /*TODO ILightStubElementType*/ IStubElementType<AwkFunctionNameStub, AwkFunctionName> {
  public AwkFunctionNameStubElementType() {
    super("FUNCTION_NAME", AwkLanguage.INSTANCE);
  }

  @Override
  public AwkFunctionName createPsi(@NotNull AwkFunctionNameStub stub) {
    return new AwkFunctionNameImpl(stub, this);
  }

  @Override
  public @NotNull AwkFunctionNameStub createStub(
      @NotNull AwkFunctionName psi, StubElement<?> parentStub) {
    return new AwkFunctionNameStubImpl(
        parentStub, psi.getName(), ((AwkFunctionNameMixin) psi).getSignatureString());
  }

  @Override
  public @NotNull String getExternalId() {
    return "awk.functionName";
  }

  @Override
  public void serialize(@NotNull AwkFunctionNameStub stub, @NotNull StubOutputStream dataStream)
      throws IOException {
    dataStream.writeName(stub.getName());
    dataStream.writeUTFFast(stub.getSignatureString());
  }

  @Override
  public @NotNull AwkFunctionNameStub deserialize(
      @NotNull StubInputStream dataStream, StubElement parentStub) throws IOException {
    return new AwkFunctionNameStubImpl(
        parentStub, dataStream.readNameString(), dataStream.readUTFFast());
  }

  @Override
  public void indexStub(@NotNull AwkFunctionNameStub stub, @NotNull IndexSink sink) {
    sink.occurrence(Index.KEY, stub.getName());
  }

  public static class Index extends StringStubIndexExtension<AwkFunctionNameImpl> {
    public static StubIndexKey<String, AwkFunctionNameImpl> KEY =
        StubIndexKey.createIndexKey(AwkFunctionName.class.getCanonicalName());

    @Override
    public @NotNull StubIndexKey<String, AwkFunctionNameImpl> getKey() {
      return KEY;
    }
  }
}
