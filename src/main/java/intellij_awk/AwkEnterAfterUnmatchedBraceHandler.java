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

    System.out.println("text="+text);
    System.out.println("offset="+offset);

    String rest = text.subSequence(offset, text.length()).toString();
    System.out.println("rest="+rest);

    String code = "BEGIN{"+rest+"}";

    System.out.println("code="+code);

    AwkFile awkFile = (AwkFile)
            PsiFileFactory.getInstance(file.getProject())
                    .createFileFromText("dummy.awk", AwkFileType.INSTANCE, code);

    AwkStatement awkStatement = (AwkStatement) AwkUtil.findFirstMatchedDeep(awkFile, AwkStatement.class::isInstance);

    if (awkStatement == null) {
      return Pair.create(null, CharArrayUtil.shiftForwardUntil(text, offset, "\n"));
    }

    System.out.println("zzz:"+CharArrayUtil.shiftForwardUntil(text, offset, "\n")+":"+(offset + awkStatement.getTextLength()+1));
    System.out.println("awkStatement="+awkStatement.getTextLength());
    System.out.println("awkStatement="+awkStatement.getText());


//    int pos = offset + awkStatement.getTextLength();
    int pos = offset + (awkStatement.getText().trim()).length();

    System.out.println("res="+text.subSequence(0, pos) + "<here>" + text.subSequence(pos, text.length()));

    return Pair.create(null, pos);
  }
}
