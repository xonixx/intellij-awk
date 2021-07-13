package intellij_awk;

import com.intellij.psi.PsiFile;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;

public class AwkIncludesTests extends BasePlatformTestCase {

  private PsiFile a, b, c, d, x1, y1, x2, y2, x3, y3;

  @Override
  protected void setUp() throws Exception {
    super.setUp();

    a = myFixture.configureByFile("a.awk");
    b = myFixture.configureByFile("b.awk");
    c = myFixture.configureByFile("c.awk");
    d = myFixture.configureByFile("d.awk");

    x1 = myFixture.configureByFile("x/x1.awk");
    x2 = myFixture.configureByFile("x/x2.awk");
    x3 = myFixture.configureByFile("x/x3.awk");

    y1 = myFixture.configureByFile("y/y1.awk");
    y2 = myFixture.configureByFile("y/y2.awk");
    y3 = myFixture.configureByFile("y/y3.awk");
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

  public void test6() {
    assertEquals(1, myFixture.findUsages(x2).size());
  }

  public void test7() {
    assertEquals(2, myFixture.findUsages(y2).size());
  }

  public void test8() {
    assertEquals(1, myFixture.findUsages(x3).size());
  }

  public void test9() {
    assertEquals(1, myFixture.findUsages(y3).size());
  }

  public void test10() {
    assertEquals(1, myFixture.findUsages(d).size());
  }
}
