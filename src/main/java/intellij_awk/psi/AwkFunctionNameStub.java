package intellij_awk.psi;

import com.intellij.psi.stubs.StubElement;

public interface AwkFunctionNameStub extends StubElement<AwkFunctionName> {
    String getName();
    String getSignatureString();
}
