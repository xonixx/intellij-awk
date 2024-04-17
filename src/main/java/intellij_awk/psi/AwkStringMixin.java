package intellij_awk.psi;

import static com.intellij.openapi.util.text.StringUtil.unquoteString;

import com.intellij.lang.ASTNode;
import com.intellij.openapi.util.TextRange;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiReference;
import intellij_awk.AwkReferenceFunction;
import intellij_awk.AwkUtil;
import java.util.regex.Pattern;
import javax.swing.*;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public abstract class AwkStringMixin extends AwkNamedElementImpl {
  public AwkStringMixin(@NotNull ASTNode node) {
    super(node);
  }

  private static final Pattern stringThatCanBeFunctionName =
      Pattern.compile("\"[A-Za-z_][A-Za-z0-9_]*\"");

  @Override
  public String getName() {
    return getPossibleFunctionName();
  }

  @Nullable
  private String getPossibleFunctionName() {
    String str = getText();
    return canBeFunctionName(str) ? unquoteString(str) : null;
  }

  static boolean canBeFunctionName(String s) {
    return stringThatCanBeFunctionName.matcher(s).matches();
  }

  public PsiElement setName(String newName) {
    return replaceNameNode(AwkElementFactory.createFunctionCallName(getProject(), newName));
  }

  @Override
  public PsiReference getReference() {
    return getPossibleFunctionName() != null && canBeFunctionReference()
        ? new AwkReferenceFunction(this, TextRange.from(1, getTextLength() - 2))
        : null;
  }

  private boolean canBeFunctionReference() {
    return isRhsOfAssignment() || isUserFunctionArgument();
  }

  /** `f("fname")` but not `substr("fname")` (built-in) */
  private boolean isUserFunctionArgument() {
    AwkGawkFuncCallList callList = AwkUtil.findParent(this, AwkGawkFuncCallList.class);
    return callList != null && callList.getParent() instanceof AwkFunctionCallUser;
  }

  /** `a = "fname"` */
  private boolean isRhsOfAssignment() {
    return AwkUtil.isType(AwkUtil.getPrevNotWhitespace(getParent()), AwkTypes.ASSIGN);
  }

  @Override
  public @Nullable Icon getIcon(int flags) {
    return null;
  }
}
