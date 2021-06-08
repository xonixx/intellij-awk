package intellij_awk;

import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import org.jetbrains.annotations.NotNull;

public class AwkRenameTests extends BasePlatformTestCase {

  public void testVars1() { checkByFile("newName"); }
  public void testVars2() { checkByFile("newName"); }
  public void testVars3() { checkByFile("newName"); }
  public void testVars4() { checkByFile("newName"); }


  @Override
  protected String getTestDataPath() {
    return "src/test/testData/rename";
  }

  private void checkByFile(@NotNull String newName) {
    String before = getTestName(true) + ".awk";
    String after = before.replace(".awk", "After.awk");
    myFixture.configureByFile(before);
    myFixture.renameElementAtCaret(newName);
    myFixture.checkResultByFile(after, true);
  }
}
