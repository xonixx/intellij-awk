package intellij_awk;

import com.intellij.psi.PsiFile;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;

public class AwkIncludesTests extends BasePlatformTestCase {

  private PsiFile a;
  private PsiFile b;
  private PsiFile c;

  @Override
  protected void setUp() throws Exception {
    super.setUp();

    a = myFixture.configureByFile("a.awk");
    b = myFixture.configureByFile("b.awk");
    c = myFixture.configureByFile("c.awk");
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
}
