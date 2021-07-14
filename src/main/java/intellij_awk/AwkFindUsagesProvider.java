package intellij_awk;

import com.intellij.lang.HelpID;
import com.intellij.lang.cacheBuilder.DefaultWordsScanner;
import com.intellij.lang.cacheBuilder.WordsScanner;
import com.intellij.lang.findUsages.FindUsagesProvider;
import com.intellij.psi.ElementDescriptionUtil;
import com.intellij.psi.PsiElement;
import com.intellij.psi.tree.TokenSet;
import com.intellij.usageView.UsageViewLongNameLocation;
import com.intellij.usageView.UsageViewNodeTextLocation;
import intellij_awk.psi.AwkFunctionName;
import intellij_awk.psi.AwkTypes;
import intellij_awk.psi.AwkUserVarName;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public class AwkFindUsagesProvider implements FindUsagesProvider {

  @Nullable
  @Override
  public WordsScanner getWordsScanner() {
    return new DefaultWordsScanner(
        new AwkLexerAdapter(),
        TokenSet.create(AwkTypes.VAR_NAME, AwkTypes.FUNC_NAME),
        TokenSet.create(AwkTypes.COMMENT),
        TokenSet.create(AwkTypes.STRING));
  }

  @Override
  public boolean canFindUsagesFor(@NotNull PsiElement psiElement) {
    return psiElement instanceof AwkFunctionName || psiElement instanceof AwkUserVarName;
  }

  @Nullable
  @Override
  public String getHelpId(@NotNull PsiElement psiElement) {
    return HelpID.FIND_OTHER_USAGES;
  }

  @NotNull
  @Override
  public String getType(@NotNull PsiElement psiElement) {
    if (psiElement instanceof AwkFunctionName) {
      return "function";
    } else if (psiElement instanceof AwkUserVarName) {
      return "variable";
    } else {
      return "???";
    }
  }

  /*  @NotNull
  @Override
  public String getType(@NotNull PsiElement element) {
    return ElementDescriptionUtil.getElementDescription(element, UsageViewTypeLocation.INSTANCE);
  }*/

  @NotNull
  @Override
  public String getDescriptiveName(@NotNull PsiElement element) {
    return ElementDescriptionUtil.getElementDescription(
        element, UsageViewLongNameLocation.INSTANCE);
  }

  @NotNull
  @Override
  public String getNodeText(@NotNull PsiElement element, boolean useFullName) {
    return ElementDescriptionUtil.getElementDescription(
        element, UsageViewNodeTextLocation.INSTANCE);
  }
}
