package intellij_awk;

import com.intellij.psi.PsiElement;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import com.intellij.usageView.UsageInfo;
import org.junit.Assert;

import java.util.Collection;

public class AwkFindUsagesTests extends BasePlatformTestCase {

  public void testVars1() {
    doTest(3, "function f(a, <caret>b, c) {\n" + "b++\n" + "print b\n" + "return f2(b)\n" + "}");
  }

  public void testVars2() {
    doTest(3, "function f(a, b, c) {\n" + "<caret>b++\n" + "print b\n" + "return f2(b)\n" + "}");
  }

  public void testVars3() {
    doTest(
        2,
        "BEGIN {\n"
            + "}\n"
            + "\n"
            + "function f(a,    i) {\n"
            + "    f1(name<caret>)\n"
            + "    name++\n"
            + "    print \"name: \" name\n"
            + "}\n");
  }

  public void testVars4() {
    doTest(
        3,
        "BEGIN {\n"
            + "split(\"\", name)\n"
            + "}\n"
            + "\n"
            + "function f(a,    i) {\n"
            + "    f1(<caret>name)\n"
            + "    name++\n"
            + "    print \"name: \" name\n"
            + "}\n");
  }

  public void testVars5() {
    doTest(
        8,
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
            + "function f2() { name = toupper(name) }\n");
  }

  public void testVars6() {
    doTest(
        4,
        "BEGIN { <caret>a=1 }\n"
            + "a\n"
            + "{ a++ }\n"
            + "function inc() { a+=1 }\n"
            + "END { print a }");
  }

  public void testFunc1() {
    doTest(
        5,
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
            + "}");
  }

  public void testFuncMultipleFiles1() {
    doTest(
        5,
        "BEGIN {\n"
            + "    name<caret>()\n"
            + "}\n"
            + "\n"
            + "function name() {\n"
            + "    name()\n"
            + "}\n",
        "function f2() {\n"
            + "    name()\n"
            + "    name(\"arg\")\n"
            + "    print f3(name()+1)\n"
            + "}");
  }

  public void testFuncMultipleFiles2() {
    doTest(
        1,
        "BEGIN {\n"
            + "    name()\n"
            + "}\n"
            + "\n"
            + "function name<caret>() {\n"
            + "    print 1\n"
            + "}\n",
        "function name() {\n    print 2\n}");
  }

  public void testIndirect1() {
    doTest(
        4,
        "BEGIN {\n"
            + "    a=\"fun\"\n"
            + "    @a(123)\n"
            + "    @  a<caret>()\n"
            + "}\n"
            + "a\n"
            + "{ a++ }");
  }

  private void doTest(int expectedUsagesCount, String code, String... otherFiles) {
    myFixture.configureByText("a.awk", code);
    for (int i = 0; i < otherFiles.length; i++) {
      String otherFileCode = otherFiles[i];
      myFixture.addFileToProject("f" + i + ".awk", otherFileCode);
    }
    PsiElement element = myFixture.getElementAtCaret();
    Collection<UsageInfo> usages = myFixture.findUsages(element);
    Assert.assertEquals(expectedUsagesCount, usages.size());
  }
}
