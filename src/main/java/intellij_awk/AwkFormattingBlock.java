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
import intellij_awk.psi.*;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.ArrayList;
import java.util.List;

public class AwkFormattingBlock extends AbstractBlock {

  private final CodeStyleSettings codeStyleSettings;
  private final SpacingBuilder spacingBuilder;
  private final Indent indent;

  private static final TokenSet IF_FOR_WHILE =
      TokenSet.create(AwkTypes.IF, AwkTypes.FOR, AwkTypes.WHILE);

  protected AwkFormattingBlock(
      @NotNull ASTNode node,
      @Nullable Wrap wrap,
      Indent indent,
      @Nullable Alignment alignment,
      CodeStyleSettings codeStyleSettings,
      SpacingBuilder spacingBuilder) {
    super(node, wrap, alignment);
    this.codeStyleSettings = codeStyleSettings;
    this.spacingBuilder = spacingBuilder;
    this.indent = indent;
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
                calcIndent(child),
                null,
                codeStyleSettings,
                spacingBuilder));
      }
      child = child.getTreeNext();
    }
    return blocks;
  }

  private Indent calcIndent(ASTNode myNode) {
    PsiElement psi = myNode.getPsi();
    PsiElement parent = psi.getParent();

    if (parent instanceof AwkAction
        /* this is not opening '{' or closing '}' of action */
        && !(psi.equals(parent.getFirstChild()) || psi.equals(parent.getLastChild()))) {
      return Indent.getNormalIndent();
    }

    if (parent instanceof AwkExprLst) {
      return Indent.getNormalIndent();
    }

    if (parent instanceof AwkTerminatedStatement
        && IF_FOR_WHILE.contains(parent.getFirstChild().getNode().getElementType())
        && psi instanceof AwkTerminatedStatement
        && !isPrecededByElseOnSameLine(psi)) {
      return Indent.getNormalIndent();
    }

    return Indent.getNoneIndent();
  }

  private boolean isPrecededByElseOnSameLine(PsiElement psi) {
    ASTNode node = psi.getNode();
    ASTNode parent = node.getTreeParent();
    PsiElement prevSibling = AwkUtil.getPrevNotWhitespace(psi);

    if (prevSibling.getNode().getElementType() != AwkTypes.ELSE) {
      return false;
    }

    return getLineColumnRelativeToParent(parent, node).line
        == getLineColumnRelativeToParent(parent, prevSibling.getNode()).line;
  }

  @Override
  public Indent getIndent() {
    return indent;
  }

  @Nullable
  @Override
  public Spacing getSpacing(@Nullable Block child1, @NotNull Block child2) {
    return spacingBuilder.getSpacing(this, child1, child2);
  }

  @Override
  public @NotNull ChildAttributes getChildAttributes(int newChildIndex) {
    PsiElement psi = myNode.getPsi();
    if (psi instanceof AwkFile) {
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
                int indentSize =
                    codeStyleSettings
                        .getCommonSettings(AwkLanguage.INSTANCE)
                        .getIndentOptions()
                        .INDENT_SIZE;
                int colNo = getLineColumnRelativeToParent(myNode, node).column;
                return new ChildAttributes(Indent.getSpaceIndent(colNo + indentSize), null);
              }
            }
          }
        }
      }
      return new ChildAttributes(Indent.getNoneIndent(), null);
    } else if (psi instanceof AwkTerminatedStatementList) {
      return new ChildAttributes(Indent.getNoneIndent(), null);
    }
    return new ChildAttributes(Indent.getNormalIndent(), null);
  }

  private LineColumn getLineColumnRelativeToParent(ASTNode parent, ASTNode child) {
    return StringUtil.offsetToLineColumn(parent.getText(), child.getStartOffsetInParent());
  }

  private static ASTNode getChildBlockNode(List<Block> children, int idx) {
    return ((AwkFormattingBlock) children.get(idx)).myNode;
  }

  @Override
  public boolean isLeaf() {
    return myNode.getFirstChildNode() == null;
  }
}
