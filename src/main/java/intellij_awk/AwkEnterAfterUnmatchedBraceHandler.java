package intellij_awk;

import com.intellij.codeInsight.editorActions.enter.EnterAfterUnmatchedBraceHandler;
import com.intellij.openapi.util.Pair;
import com.intellij.psi.*;
import com.intellij.util.text.CharArrayUtil;
import intellij_awk.psi.AwkFile;
import org.jetbrains.annotations.NotNull;

public class AwkEnterAfterUnmatchedBraceHandler extends EnterAfterUnmatchedBraceHandler {
  @Override
  public boolean isApplicable(@NotNull PsiFile file, int caretOffset) {
    return file instanceof AwkFile;
  }

  @Override
  protected Pair<PsiElement, Integer> calculateOffsetToInsertClosingBrace(
      @NotNull PsiFile file, @NotNull CharSequence text, int offset) {
    return Pair.create(null, CharArrayUtil.shiftForwardUntil(text, offset, "\n"));
  }
}
