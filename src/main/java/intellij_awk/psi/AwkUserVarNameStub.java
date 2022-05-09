package intellij_awk.psi;

import com.intellij.psi.stubs.StubElement;

public interface AwkUserVarNameStub extends StubElement<AwkUserVarName>, AwkUserVarNameDeclaration {
  String getName();

  boolean looksLikeDeclaration();

  boolean isInsideInitializingContext();
}
