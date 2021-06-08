package intellij_awk;

import com.intellij.psi.PsiElement;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import com.intellij.usageView.UsageInfo;
import org.junit.Assert;

import java.util.Collection;

public class AwkFindUsagesTests extends BasePlatformTestCase {

  public void test1() {
    doTest("function f(a, <caret>b, c) {\n" + "b++\n" + "print b\n" + "return f2(b)\n" + "}", 3);
  }

  public void test2() {
    doTest("function f(a, b, c) {\n" + "<caret>b++\n" + "print b\n" + "return f2(b)\n" + "}", 3);
  }

  private void doTest(String code, int expectedUsagesCount) {
    myFixture.configureByText("a.awk", code);
    PsiElement element = myFixture.getElementAtCaret();
    Collection<UsageInfo> usages = myFixture.findUsages(element);
    Assert.assertEquals(expectedUsagesCount, usages.size());
  }
}
