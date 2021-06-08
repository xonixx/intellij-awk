package intellij_awk;

import com.intellij.openapi.command.WriteCommandAction;
import com.intellij.psi.PsiFile;
import com.intellij.psi.codeStyle.CodeStyleManager;
import com.intellij.psi.impl.DebugUtil;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;

import java.util.List;

public class AwkAutoFormatTests extends BasePlatformTestCase {

  public void testFile1() { checkByFile(); }
  public void testFile2() { checkByFile(); }
  public void testFile2_1() { checkByFile(); }
  public void testFile3() { checkByFile(); }
  public void testFile4() { checkByFile(); }
  public void testFile4_1() { checkByFile(); }
  public void testFile5() { checkByFile(); }
  public void testFile6() { checkByFile(); }
  public void testFile7() { checkByFile(); }
  public void testFile8() { checkByFile(); }
  public void testFile9() { checkByFile(); }
  public void testFile10() { checkByFile(); }
  public void testFile11() { checkByFile(); }
  public void testFile12() { checkByFile(); }
  public void testFile13() { checkByFile(); }

  @Override
  protected String getTestDataPath() {
    return "src/test/testData/auto_format";
  }

  private void checkByFile() {
    String before = getTestName(true) + ".awk";
    String after = before.replace(".awk", "After.awk");
    myFixture.configureByFile(before);

    WriteCommandAction.runWriteCommandAction(
        getProject(),
        () -> {
          PsiFile psiFile = myFixture.getFile();
          CodeStyleManager.getInstance(getProject())
              .reformatText(psiFile, List.of(psiFile.getTextRange()));
        });

    try {
      myFixture.checkResultByFile(after, true);
    } catch (Throwable t) {
//      System.out.println(DebugUtil.psiToString(myFixture.getFile(), false, true));
      throw t;
    }
  }
}
