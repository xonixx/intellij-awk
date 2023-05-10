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
  public static final TokenSet binaryOps =
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
          NE,
          QUESTION,
          ASSIGN,
          PIPE);

  private static SpacingBuilder createSpaceBuilder(CodeStyleSettings settings) {
    TokenSet ternaryExpr = TokenSet.create(TERNARY_EXPR, TERNARY_PRINT_EXPR);
    return new SpacingBuilder(settings, AwkLanguage.INSTANCE)
        .around(binaryOps)
        .spaces(1)
        .aroundInside(COLON, ternaryExpr)
        .spaces(1)
        .before(ternaryExpr)
        .spaces(1)
        .around(TokenSet.create(INCR, DECR))
        .none()
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
        .after(LBRACKET)
        .none()
        .afterInside(
            LPAREN,
            TokenSet.create(FUNCTION_CALL_USER, FUNCTION_CALL_BUILT_IN, STATEMENT, NON_UNARY_EXPR))
        .none()
        .before(TokenSet.create(RPAREN, RBRACKET, LBRACKET))
        .none()
        .after(NOT)
        .none()
        .between(TokenSet.create(FOR, IF, WHILE), LPAREN)
        .spaces(1)
        .between(DO, STATEMENT) // do {
        .spaces(1)
        .between(STATEMENT, WHILE) // } while
        .spaces(1)
        .between(STATEMENT, ELSE) // } else
        .spaces(1)
        .between(ELSE, STATEMENT) // else if
        .spaces(1)
        .between(RPAREN, TokenSet.create(STATEMENT, ACTION)) // ) {
        .spaces(1)
        //        .before(COMMA) // TODO taking into account function local params
        //        .none()
        //        .after(COMMA)
        //        .spaces(1)
        .after(TokenSet.create(PRINT, PRINTF))
        .spaces(1)
        .between(SIMPLE_PRINT_STATEMENT, OUTPUT_REDIRECTION)
        .spaces(1)
        .after(TokenSet.create(APPEND, PIPE_AMP))
        .spaces(1);
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
