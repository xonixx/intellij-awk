package intellij_awk.psi;

import com.intellij.psi.stubs.StubElement;

public interface AwkUserVarNameStub extends StubElement<AwkUserVarName> {
  String getName();

  boolean looksLikeDeclaration();

  boolean isInsideInitializingContext();
}
