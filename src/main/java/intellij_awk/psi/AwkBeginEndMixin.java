package intellij_awk.psi;

import com.intellij.lang.ASTNode;
import intellij_awk.AwkIcons;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;

public class AwkBeginEndMixin extends AwkNamedElementImpl {
  public AwkBeginEndMixin(@NotNull ASTNode node) {
    super(node);
  }

  @Override
  public @Nullable Icon getIcon(int flags) {
    return this instanceof AwkBeginBlock
        ? AwkIcons.BEGIN
        : this instanceof AwkEndBlock ? AwkIcons.END : super.getIcon(flags);
  }
}
