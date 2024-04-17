package intellij_awk;

import com.intellij.testFramework.fixtures.BasePlatformTestCase;

public class AwkRenameTests extends BasePlatformTestCase {

  public void testVars1() { checkByFile(); }
  public void testVars2() { checkByFile(); }
  public void testVars3() { checkByFile(); }
  public void testVars4() { checkByFile(); }
  public void testVars5() { checkByFile(); }
  public void testVars6() { checkByFile(); }
  public void testVars7() { checkByFile(); }
  public void testFunc1() { checkByFile(); }
  public void testFuncRef() { checkByFile(); }
  public void testIndirect1() { checkByFile(); }

  @Override
  protected String getTestDataPath() {
    return "src/test/testData/rename";
  }

  private void checkByFile() {
    String before = getTestName(true) + ".awk";
    String after = before.replace(".awk", "After.awk");
    myFixture.configureByFile(before);
    myFixture.renameElementAtCaret("newName");
    myFixture.checkResultByFile(after, true);
  }
}
