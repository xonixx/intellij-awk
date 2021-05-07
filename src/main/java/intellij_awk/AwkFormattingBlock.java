package intellij_awk;

import com.intellij.formatting.*;
import com.intellij.lang.ASTNode;
import com.intellij.psi.TokenType;
import com.intellij.psi.formatter.common.AbstractBlock;
import intellij_awk.psi.AwkAction;
import intellij_awk.psi.AwkTypes;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.ArrayList;
import java.util.List;

public class AwkFormattingBlock extends AbstractBlock {

  private final SpacingBuilder spacingBuilder;

  protected AwkFormattingBlock(
      @NotNull ASTNode node,
      @Nullable Wrap wrap,
      @Nullable Alignment alignment,
      SpacingBuilder spacingBuilder) {
    super(node, wrap, alignment);
    this.spacingBuilder = spacingBuilder;
  }

  @Override
  protected List<Block> buildChildren() {
    List<Block> blocks = new ArrayList<>();
    ASTNode child = myNode.getFirstChildNode();
    while (child != null) {
      if (child.getElementType() != TokenType.WHITE_SPACE
          && child.getElementType() != AwkTypes.NEWLINE) {
        Block block =
            new AwkFormattingBlock(
                child,
                Wrap.createWrap(WrapType.NONE, false),
                Alignment.createAlignment(),
                spacingBuilder);
        blocks.add(block);
      }
      child = child.getTreeNext();
    }
    return blocks;
  }

  @Override
  public Indent getIndent() {
    return Indent.getNoneIndent();
  }

  @Nullable
  @Override
  public Spacing getSpacing(@Nullable Block child1, @NotNull Block child2) {
    return spacingBuilder.getSpacing(this, child1, child2);
  }

  @Override
  protected @Nullable Indent getChildIndent() {
    return myNode instanceof AwkAction ? Indent.getNormalIndent() : null;
  }

  @Override
  public boolean isLeaf() {
    return myNode.getFirstChildNode() == null;
  }
}
