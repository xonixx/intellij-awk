package intellij_awk;

import com.intellij.openapi.command.WriteCommandAction;
import com.intellij.psi.codeStyle.CodeStyleManager;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;

public class AwkAutoFormatTests extends BasePlatformTestCase {

  public void testFile1() {
    checkByFile();
  }

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
          CodeStyleManager.getInstance(getProject()).reformat(myFixture.getFile());
        });

    myFixture.checkResultByFile(after, true);
  }
}
