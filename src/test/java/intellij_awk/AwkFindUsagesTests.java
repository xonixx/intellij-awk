package intellij_awk;

import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiFile;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import com.intellij.usageView.UsageInfo;
import intellij_awk.psi.AwkUserVarName;
import org.junit.Assert;

import java.util.ArrayList;
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

  public void testVars7() {
    doTest(0, "BEGIN { <caret>A=1 }\n");
  }

  public void testVars8() {
    doTest(
        2,
        "BEGIN {\n"
            + "\nShells<caret>[\"bash\"]"
            + "\nShells[\"zsh\"]"
            + "\nShells[\"sh\"]"
            + "}\n");
  }

  public void testVars9() {
    doTest(
        2,
        "BEGIN {\n"
            + "\nShells[\"bash\"]=1"
            + "\nShe<caret>lls[\"zsh\"]=1"
            + "\nShells[\"sh\"]=1"
            + "}\n");
  }

  public void testVars10() {
    PsiFile psiFile =
        myFixture.configureByText(
            "a.awk",
            "BEGIN {\n"
                + "initShells()\n"
                + "print A"
                + "}\n"
                + "function initShells() {"
                + "\n  A = 1"
                + "\n  A = 2"
                + "\n  A = 3"
                + "}");
    ArrayList<PsiElement> userVars = new ArrayList<>();
    AwkUtil.findAllMatchedDeep(
        psiFile, psiElement -> psiElement instanceof AwkUserVarName, userVars);

    assertEquals(userVars.get(1), userVars.get(0).getReference().resolve());
    assertNull(userVars.get(1).getReference().resolve());
  }

  public void testVars11() {
    PsiFile psiFile =
        myFixture.configureByText(
            "a.awk",
            "BEGIN {\n"
                + "initShells()\n"
                + "print \"sh\" in Shells"
                + "}\n"
                + "function initShells() {"
                + "\n  Shells[\"bash\"]"
                + "\n  Shells[\"zsh\"]"
                + "\n  Shells[\"sh\"]"
                + "}");
    ArrayList<PsiElement> userVars = new ArrayList<>();
    AwkUtil.findAllMatchedDeep(
        psiFile, psiElement -> psiElement instanceof AwkUserVarName, userVars);

    assertEquals(userVars.get(1), userVars.get(0).getReference().resolve());
    assertNull(userVars.get(1).getReference().resolve());
  }

  public void testVars12() {
    PsiFile psiFile =
        myFixture.configureByText(
            "a.awk",
            "BEGIN {\n"
                + "initShells()\n"
                + "print \"sh\" in Shells"
                + "}\n"
                + "function initShells() {"
                + "\n  Shells[\"bash\"]=1"
                + "\n  Shells[\"zsh\"] = \"string\""
                + "\n  Shells[\"sh\"] = rand()"
                + "}");
    ArrayList<PsiElement> userVars = new ArrayList<>();
    AwkUtil.findAllMatchedDeep(
        psiFile, psiElement -> psiElement instanceof AwkUserVarName, userVars);

    assertEquals(userVars.get(1), userVars.get(0).getReference().resolve());
    assertNull(userVars.get(1).getReference().resolve());
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

  public void testMultipleFilesFunc1() {
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

  public void testMultipleFilesFunc2() {
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

  public void testMultipleFilesVars1() {
    doTest(2, "BEGIN {\n  A<caret> = 1}\n", "A { print A }");
  }

  public void testMultipleFilesVars2() {
    doTest(2, "A<caret> { print A }", "BEGIN {split(\"\",A)}\n");
  }

  public void testMultipleFilesVars3() {
    doTest(1, "BEGIN {\n  A<caret> = 1 }\n", "function f() { print A }");
  }

  public void testMultipleFilesVars4() {
    doTest(0, "BEGIN {\n  A<caret> = 1 }\n", "function f(A) { print A }");
  }

  public void testMultipleFilesVars5() {
    doTest(1, "function f() { return A<caret>+1 }", "function f2() { print A }");
  }

  public void testMultipleFilesVars6() {
    doTest(1, "function f() { A<caret> = 1 }", "function f2() { A = 2 }");
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
