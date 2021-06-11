package intellij_awk;

import com.intellij.psi.PsiElement;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import com.intellij.usageView.UsageInfo;
import org.junit.Assert;

import java.util.Collection;

public class AwkFindUsagesTests extends BasePlatformTestCase {

  public void testVars1() {
    doTest("function f(a, <caret>b, c) {\n" + "b++\n" + "print b\n" + "return f2(b)\n" + "}", 3);
  }

  public void testVars2() {
    doTest("function f(a, b, c) {\n" + "<caret>b++\n" + "print b\n" + "return f2(b)\n" + "}", 3);
  }

  public void testVars3() {
    doTest(
        "BEGIN {\n"
            + "}\n"
            + "\n"
            + "function f(a,    i) {\n"
            + "    f1(name<caret>)\n"
            + "    name++\n"
            + "    print \"name: \" name\n"
            + "}\n",
        2);
  }

  public void testVars4() {
    doTest(
        "BEGIN {\n"
            + "split(\"\", name)\n"
            + "}\n"
            + "\n"
            + "function f(a,    i) {\n"
            + "    f1(<caret>name)\n"
            + "    name++\n"
            + "    print \"name: \" name\n"
            + "}\n",
        3);
  }

  public void testVars5() {
    doTest(
        "END {\n"
            + "split(\"\", name)\n"
            + "}\n"
            + "{ print name name name }\n"
            + "\n"
            + "function f(a,    i) {\n"
            + "    f1(<caret>name)\n"
            + "    name++\n"
            + "    print \"name: \" name\n"
            + "}\n"
            + "function f2() { name = toupper(name) }\n",
        8);
  }

  public void testVars6() {
    doTest(
        "BEGIN { <caret>a=1 }\n"
            + "a\n"
            + "{ a++ }\n"
            + "function inc() { a+=1 }\n"
            + "END { print a }",
        4);
  }

  public void testFunc1() {
    doTest(
        "BEGIN {\n"
            + "    name<caret>()\n"
            + "}\n"
            + "\n"
            + "function name() {\n"
            + "    name()\n"
            + "}\n"
            + "\n"
            + "function f2() {\n"
            + "    name()\n"
            + "    name(\"arg\")\n"
            + "    print f3(name()+1)\n"
            + "}",
        5);
  }

  private void doTest(String code, int expectedUsagesCount) {
    myFixture.configureByText("a.awk", code);
    PsiElement element = myFixture.getElementAtCaret();
    Collection<UsageInfo> usages = myFixture.findUsages(element);
    Assert.assertEquals(expectedUsagesCount, usages.size());
  }
}
