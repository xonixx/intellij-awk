package intellij_awk;

import com.intellij.psi.PsiFile;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;

public class AwkIncludesTests extends BasePlatformTestCase {

  private PsiFile a, b, c, x1, y1;

  @Override
  protected void setUp() throws Exception {
    super.setUp();

    a = myFixture.configureByFile("a.awk");
    b = myFixture.configureByFile("b.awk");
    c = myFixture.configureByFile("c.awk");
    x1 = myFixture.configureByFile("x/x1.awk");
    y1 = myFixture.configureByFile("y/y1.awk");
  }

  @Override
  protected String getTestDataPath() {
    return "src/test/testData/includes";
  }

  public void test1() {
    assertEquals(1, myFixture.findUsages(b).size());
  }

  public void test2() {
    assertEquals(1, myFixture.findUsages(c).size());
  }

  public void test3() {
    assertEquals(0, myFixture.findUsages(a).size());
  }

  public void test4() {
    assertEquals(2, myFixture.findUsages(x1).size());
  }

  public void test5() {
    assertEquals(1, myFixture.findUsages(y1).size());
  }
}
