package intellij_awk;

import com.intellij.formatting.*;
import com.intellij.lang.ASTNode;
import com.intellij.openapi.util.text.LineColumn;
import com.intellij.openapi.util.text.StringUtil;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiErrorElement;
import com.intellij.psi.TokenType;
import com.intellij.psi.formatter.common.AbstractBlock;
import intellij_awk.psi.AwkAction;
import intellij_awk.psi.AwkFile;
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
                child, Wrap.createWrap(WrapType.NONE, false), null, spacingBuilder);
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
  public @NotNull ChildAttributes getChildAttributes(int newChildIndex) {
    if (myNode.getPsi() instanceof AwkFile) {
      if (newChildIndex > 0) {
        // handle if(1)<ENTER>, while(1)<ENTER> etc
        // below is hacky code, because in presence of uncompleted if(1) the file is not parsed to
        // correct AST yet
        List<Block> children = buildChildren();
        AwkFormattingBlock block = (AwkFormattingBlock) children.get(newChildIndex - 1);
        ASTNode prevNode = block.myNode;
        PsiElement errElt;
        if (prevNode.getElementType() == AwkTypes.RPAREN
            || prevNode instanceof PsiErrorElement
                && (errElt = ((PsiErrorElement) prevNode).getFirstChild()) != null
                && errElt.getNode().getElementType() == AwkTypes.RPAREN) {
          //          return new ChildAttributes(Indent.getNormalIndent(), null);
          //          return new ChildAttributes(Indent.getSpaceIndent(10), null);
          // search corresponding LPAREN
          ASTNode node = prevNode;
          while ((node = node.getTreePrev()) != null) {
            if (node.getElementType() == AwkTypes.LPAREN) {
              LineColumn column =
                  StringUtil.offsetToLineColumn(
                      this.myNode.getText(), node.getStartOffsetInParent());
              return new ChildAttributes(Indent.getSpaceIndent(column.column), null);
              //              break;
            }
          }
        }
      }
      return new ChildAttributes(Indent.getNoneIndent(), null);
    }
    return new ChildAttributes(Indent.getNormalIndent(), null);
  }

  @Override
  public boolean isLeaf() {
    return myNode.getFirstChildNode() == null;
  }
}
