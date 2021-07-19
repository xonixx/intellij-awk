package intellij_awk.psi;

import com.intellij.extapi.psi.StubBasedPsiElementBase;
import com.intellij.lang.ASTNode;
import com.intellij.psi.stubs.IStubElementType;
import com.intellij.psi.stubs.StubElement;
import com.intellij.psi.tree.IElementType;
import org.jetbrains.annotations.NotNull;

public class AwkNamedStubBasedPsiElementBase<T extends StubElement>
    extends StubBasedPsiElementBase<T> implements AwkNamedElement {

  @Override
  public String getName() {
    return getNameIdentifier().getText();
  }

  public AwkNamedStubBasedPsiElementBase(@NotNull T stub, @NotNull IStubElementType nodeType) {
    super(stub, nodeType);
  }

  public AwkNamedStubBasedPsiElementBase(@NotNull ASTNode node) {
    super(node);
  }

  public AwkNamedStubBasedPsiElementBase(T stub, IElementType nodeType, ASTNode node) {
    super(stub, nodeType, node);
  }
}
