package intellij_awk;

import com.intellij.codeInsight.editorActions.enter.EnterAfterUnmatchedBraceHandler;
import com.intellij.openapi.util.Pair;
import com.intellij.psi.*;
import com.intellij.util.text.CharArrayUtil;
import intellij_awk.psi.AwkFile;
import intellij_awk.psi.AwkStatement;
import org.jetbrains.annotations.NotNull;

public class AwkEnterAfterUnmatchedBraceHandler extends EnterAfterUnmatchedBraceHandler {
  @Override
  public boolean isApplicable(@NotNull PsiFile file, int caretOffset) {
    return file instanceof AwkFile;
  }

  @Override
  protected Pair<PsiElement, Integer> calculateOffsetToInsertClosingBrace(
      @NotNull PsiFile file, @NotNull CharSequence text, int offset) {

    String rest = text.subSequence(offset, text.length()).toString();

    // The idea is that to understand where to put the closing `}` we need to recognize the longest
    // statement that goes right after `{`. Since the AWK PSI tree can be broken due to incomplete
    // code, the only reliable way to do so is to (re-)parse the rest of the file (after `{`) and
    // take the first statement.
    String code = "BEGIN{" + rest + "}";

    AwkFile awkFile =
        (AwkFile)
            PsiFileFactory.getInstance(file.getProject())
                .createFileFromText("dummy.awk", AwkFileType.INSTANCE, code);

    AwkStatement awkStatement =
        (AwkStatement) AwkUtil.findFirstMatchedDeep(awkFile, AwkStatement.class::isInstance);

    if (awkStatement == null) {
      return Pair.create(null, CharArrayUtil.shiftForwardUntil(text, offset, "\n"));
    }

    //    System.out.println("awkStatement="+awkStatement.getTextLength());
    //    System.out.println("awkStatement="+awkStatement.getText());

    int pos;
    PsiElement possiblyComment = AwkUtil.getNextNotWhitespace(awkStatement);
    if (possiblyComment instanceof PsiComment) {
      // {<caret>print 123 # comment
      // here    ^_______^ is statement
      pos =
          offset
              + (possiblyComment.getTextRange().getEndOffset()
                  - awkStatement.getTextRange().getStartOffset());
    } else {
      // why not just `offset + awkStatement.getTextLength();` ?
      // it's because due to the peculiarity of grammar the recognized `if` statement can have the
      // final newline as part of it
      pos = offset + (awkStatement.getText().trim()).length();
    }

    //    System.out.println(
    //        "res=" + text.subSequence(0, pos) + "<here>" + text.subSequence(pos, text.length()));

    return Pair.create(null, pos);
  }
}
