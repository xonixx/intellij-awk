package intellij_awk;

import com.intellij.formatting.*;
import com.intellij.lang.ASTNode;
import com.intellij.openapi.util.text.LineColumn;
import com.intellij.openapi.util.text.StringUtil;
import com.intellij.psi.PsiElement;
import com.intellij.psi.TokenType;
import com.intellij.psi.codeStyle.CodeStyleSettings;
import com.intellij.psi.formatter.common.AbstractBlock;
import com.intellij.psi.tree.TokenSet;
import intellij_awk.psi.AwkFile;
import intellij_awk.psi.AwkTypes;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.ArrayList;
import java.util.List;

public class AwkFormattingBlock extends AbstractBlock {

  private final CodeStyleSettings codeStyleSettings;
  private final SpacingBuilder spacingBuilder;

  private static final @NotNull TokenSet IF_FOR_WHILE =
      TokenSet.create(AwkTypes.IF, AwkTypes.FOR, AwkTypes.WHILE);

  protected AwkFormattingBlock(
      @NotNull ASTNode node,
      @Nullable Wrap wrap,
      @Nullable Alignment alignment,
      CodeStyleSettings codeStyleSettings,
      SpacingBuilder spacingBuilder) {
    super(node, wrap, alignment);
    this.codeStyleSettings = codeStyleSettings;
    this.spacingBuilder = spacingBuilder;
  }

  @Override
  protected List<Block> buildChildren() {
    List<Block> blocks = new ArrayList<>();
    ASTNode child = myNode.getFirstChildNode();
    while (child != null) {
      if (child.getElementType() != TokenType.WHITE_SPACE
          && child.getElementType() != AwkTypes.NEWLINE) {
        blocks.add(
            new AwkFormattingBlock(
                child,
                Wrap.createWrap(WrapType.NONE, false),
                null,
                codeStyleSettings,
                spacingBuilder));
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
        // correct AST yet and is rather a flat token list in a awk file node
        List<Block> children = buildChildren();
        int blockIndex = newChildIndex - 1;
        ASTNode prevNode = getChildBlockNode(children, blockIndex);
        PsiElement errOrDummyBlockElt;
        if (prevNode.getElementType() == AwkTypes.RPAREN
            || (errOrDummyBlockElt = prevNode.getPsi().getLastChild()) != null
                && errOrDummyBlockElt.getNode().getElementType() == AwkTypes.RPAREN) {

          // search corresponding LPAREN and then keyword before it
          while (--blockIndex > 0) {
            ASTNode node = getChildBlockNode(children, blockIndex);
            if (node.getElementType() == AwkTypes.LPAREN) {
              node = getChildBlockNode(children, blockIndex - 1);
              if (IF_FOR_WHILE.contains(node.getElementType())) {
                LineColumn column =
                    StringUtil.offsetToLineColumn(
                        this.myNode.getText(), node.getStartOffsetInParent());
                int indentSize =
                    codeStyleSettings
                        .getCommonSettings(AwkLanguage.INSTANCE)
                        .getIndentOptions()
                        .INDENT_SIZE;
                return new ChildAttributes(Indent.getSpaceIndent(column.column + indentSize), null);
              }
            }
          }
        }
      }
      return new ChildAttributes(Indent.getNoneIndent(), null);
    }
    return new ChildAttributes(Indent.getNormalIndent(), null);
  }

  private static ASTNode getChildBlockNode(List<Block> children, int idx) {
    return ((AwkFormattingBlock) children.get(idx)).myNode;
  }

  @Override
  public boolean isLeaf() {
    return myNode.getFirstChildNode() == null;
  }
}
