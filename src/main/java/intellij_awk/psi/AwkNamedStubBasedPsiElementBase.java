package intellij_awk.psi;

import com.intellij.extapi.psi.StubBasedPsiElementBase;
import com.intellij.lang.ASTNode;
import com.intellij.psi.stubs.IStubElementType;
import com.intellij.psi.stubs.StubElement;
import org.jetbrains.annotations.NotNull;

public class AwkNamedStubBasedPsiElementBase<T extends StubElement>
    extends StubBasedPsiElementBase<T> implements AwkNamedElement {

  @Override
  public String getName() {
    return getNameIdentifier().getText();
  }

  @Override
  public String toString() {
    return getClass().getSimpleName() + "(" + getNode().getElementType() + ")";
  }

  public AwkNamedStubBasedPsiElementBase(@NotNull T stub, @NotNull IStubElementType nodeType) {
    super(stub, nodeType);
  }

  public AwkNamedStubBasedPsiElementBase(@NotNull ASTNode node) {
    super(node);
  }
}
