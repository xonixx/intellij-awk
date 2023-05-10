package intellij_awk;

import static intellij_awk.psi.AwkTypes.*;

import com.intellij.formatting.*;
import com.intellij.lang.ASTNode;
import com.intellij.openapi.util.TextRange;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiFile;
import com.intellij.psi.codeStyle.CodeStyleSettings;
import com.intellij.psi.tree.TokenSet;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public class AwkFormattingModelBuilder implements FormattingModelBuilder {

  private static SpacingBuilder createSpaceBuilder(CodeStyleSettings settings) {
    return new SpacingBuilder(settings, AwkLanguage.INSTANCE)
        .around(
            TokenSet.create(
                MUL,
                MUL_ASSIGN,
                DIV,
                DIV_ASSIGN,
                POW,
                POW_ASSIGN,
                ADD,
                ADD_ASSIGN,
                SUB,
                SUB_ASSIGN,
                MOD,
                MOD_ASSIGN,
                AND,
                OR,
                MATCH,
                NO_MATCH,
                GT,
                LT,
                GE,
                LE,
                EQ,
                QUESTION,
                COLON,
                ASSIGN))
        .spaces(1)
        .after(UNARY_ADD_SUB)
        .none()
        .afterInside(SEMICOLON, STATEMENT_FOR_CONDITIONS)
        .spaces(1)
        .beforeInside(SEMICOLON, STATEMENT_FOR_CONDITIONS)
        .none()
        .after(TokenSet.create(DOLLAR, AT))
        .none()
        .after(TokenSet.create(LOAD, NAMESPACE, INCLUDE))
        .spaces(1)
        .after(TokenSet.create(LPAREN, LBRACKET))
        .none()
        .before(TokenSet.create(RPAREN, RBRACKET))
        .none()
        .after(NOT)
        .none();
  }

  @Override
  public @NotNull FormattingModel createModel(@NotNull FormattingContext formattingContext) {
    PsiElement element = formattingContext.getPsiElement();
    CodeStyleSettings settings = formattingContext.getCodeStyleSettings();

    return FormattingModelProvider.createFormattingModelForPsiFile(
        element.getContainingFile(),
        new AwkFormattingBlock(
            element.getNode(),
            Wrap.createWrap(WrapType.NONE, false),
            Indent.getNoneIndent(),
            null,
            settings,
            createSpaceBuilder(settings)),
        settings);
  }

  @Nullable
  @Override
  public TextRange getRangeAffectingIndent(PsiFile file, int offset, ASTNode elementAtOffset) {
    return null;
  }
}
