package intellij_awk;

import com.intellij.testFramework.fixtures.BasePlatformTestCase;

public class AwkAutoIndentTests extends BasePlatformTestCase {

  public void testFile1() { checkByFile(); }
  public void testFile2() { checkByFile(); }
  public void testFile3() { checkByFile(); }
  public void testFile4() { checkByFile(); }
  public void testFile5() { checkByFile(); }
  public void testFile6() { checkByFile(); }
  public void testFile7() { checkByFile(); }
  public void testFile8() { checkByFile(); }
  public void testFile8_1() { checkByFile(); }
  public void testFile9() { checkByFile(); }
  public void testFile10() { checkByFile(); }
  public void testFile11() { checkByFile(); }
  public void testFile12_0() { checkByFile(); }
  public void testFile12_1() { checkByFile(); }
  public void testFile13() { checkByFile(); }

  public void testGawk_switch1(){ checkByFile(); }
  public void testGawk_switch2(){ checkByFile(); }
  public void testGawk_switch3(){ checkByFile(); }
  public void testGawk_switch4(){ checkByFile(); }
  public void testGawk_switch5(){ checkByFile(); }
  public void testGawk_switch6(){ checkByFile(); }


  @Override
  protected String getTestDataPath() {
    return "src/test/testData/auto_indent";
  }

  private void checkByFile() {
    String before = getTestName(true) + ".awk";
    String after = before.replace(".awk", "After.awk");
    myFixture.configureByFile(before);
    myFixture.type('\n');
    myFixture.checkResultByFile(after, true);
  }
}
