package intellij_awk;

import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiFile;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import com.intellij.usageView.UsageInfo;
import intellij_awk.psi.AwkUserVarName;
import intellij_awk.psi.AwkUserVarNameMixin;
import org.jetbrains.annotations.NotNull;
import org.junit.Assert;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

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

  public void testVarRefs1() {
    List<PsiElement> userVars =
        configureTestFiles(
            "BEGIN {\n"
                + "initShells()\n"
                + "print A"
                + "}\n"
                + "function initShells() {"
                + "\n  A = 1"
                + "\n  A = 2"
                + "\n  A = 3"
                + "}");

    assertResolved(userVars, 0, 1, "RESOLVE-CUR-INIT-DECL");
    assertNull(userVars.get(1).getReference().resolve());
  }

  public void testVarRefs2() {
    List<PsiElement> userVars =
        configureTestFiles(
            "BEGIN {\n"
                + "initShells()\n"
                + "print \"sh\" in Shells"
                + "}\n"
                + "function initShells() {"
                + "\n  Shells[\"bash\"]"
                + "\n  Shells[\"zsh\"]"
                + "\n  Shells[\"sh\"]"
                + "}");

    assertResolved(userVars, 0, 1, "RESOLVE-CUR-INIT-DECL");
    assertNull(userVars.get(1).getReference().resolve());
  }

  public void testVarRefs3() {
    List<PsiElement> userVars =
        configureTestFiles(
            "BEGIN {\n"
                + "initShells()\n"
                + "print \"sh\" in Shells"
                + "}\n"
                + "function initShells() {"
                + "\n  Shells[\"bash\"]=1"
                + "\n  Shells[\"zsh\"] = \"string\""
                + "\n  Shells[\"sh\"] = rand()"
                + "}");

    assertResolved(userVars, 0, 1, "RESOLVE-CUR-INIT-DECL");
    assertNull(userVars.get(1).getReference().resolve());
  }

  public void testVarRefs4() {
    List<PsiElement> userVars =
        configureTestFiles("function f() { A = 1 }\nfunction init() { A = 2 }\n");

    assertResolved(userVars, 0, 1, "RESOLVE-CUR-INIT-DECL");
    assertNull(userVars.get(1).getReference().resolve());
  }

  public void testVarRefs5() {
    List<PsiElement> userVars = configureTestFiles("function f() { A = 1 }\nBEGIN { A = 2 }\n");

    assertResolved(userVars, 0, 1, "RESOLVE-CUR-INIT-DECL");
    assertNull(userVars.get(1).getReference().resolve());
  }

  public void testVarRefs6() {
    List<PsiElement> userVars =
        configureTestFiles("function f() { A = 1 }", "function init() { A = 2 }\n");

    assertResolved(userVars, 0, 1, "RESOLVE-ALL-INIT-DECL");
    assertNull(userVars.get(1).getReference().resolve());
  }

  public void testVarRefs7() {
    List<PsiElement> userVars = configureTestFiles("function f() { A = 1 }", "BEGIN { A = 2 }\n");

    assertResolved(userVars, 0, 1, "RESOLVE-ALL-INIT-DECL");
    assertNull(userVars.get(1).getReference().resolve());
  }

  public void testVarRefs8() {
    List<PsiElement> userVars =
        configureTestFiles(
            "function f()    { print A }\n"
                + "function f1()   { A = 1   }\n"
                + "function init() { A = 2   }");

    assertResolved(userVars, 0, 2, "RESOLVE-CUR-INIT-DECL");

    assertResolved(userVars, 1, 2, "RESOLVE-CUR-INIT-DECL");

    assertNull(userVars.get(2).getReference().resolve());
  }

  public void testVarRefs9() {
    List<PsiElement> userVars =
        configureTestFiles(
            "function f()    { print A }\n",
            "function f1()   { A = 1   }\nfunction init() { A = 2   }");

    assertResolved(userVars, 0, 2, "RESOLVE-ALL-INIT-DECL");

    assertResolved(userVars, 1, 2, "RESOLVE-CUR-INIT-DECL");

    assertNull(userVars.get(2).getReference().resolve());
  }

  public void testVarRefs10() {
    List<PsiElement> userVars =
        configureTestFiles(
            "BEGIN { while(getline Line) process() } function process() { print Line }");

    assertResolved(userVars, 1, 0, "RESOLVE-CUR-INIT-VAR");
    assertNull(userVars.get(0).getReference().resolve());
  }

  public void testVarRefs11() {
    List<PsiElement> userVars =
        configureTestFiles(
            "function process() { print Line } BEGIN { while(getline Line) process() }");

    assertResolved(userVars, 0, 1, "RESOLVE-CUR-INIT-VAR");
    assertNull(userVars.get(1).getReference().resolve());
  }

  public void testVarRefs12() {
    List<PsiElement> userVars = configureTestFiles("BEGIN { while(1) { A = 1 }; if(A) {} }");

    assertResolved(userVars, 1, 0, "RESOLVE-CUR-INIT-DECL");
    assertNull(userVars.get(0).getReference().resolve());
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
    doTest(0, "function f() { return A<caret>+1 }", "function f2() { print A }");
  }

  public void testMultipleFilesVars6() {
    doTest(0, "function f() { A<caret> = 1 }", "function f2() { A = 2 }");
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

  private void assertResolved(
      List<PsiElement> userVars, int source, int expected, String expectedResolutionType) {
    AwkReferenceVariable.Resolved.AwkResolvedResult resolved =
        ((AwkUserVarNameMixin) userVars.get(source)).getReference().resolveResult();
    assertEquals(userVars.get(expected), resolved.getElement());
    assertEquals(expectedResolutionType, resolved.type);
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

  @NotNull
  private static List<PsiElement> getUserVars(PsiFile psiFile) {
    ArrayList<PsiElement> userVars = new ArrayList<>();
    AwkUtil.findAllMatchedDeep(
        psiFile, psiElement -> psiElement instanceof AwkUserVarName, userVars);
    return userVars;
  }

  private List<PsiElement> configureTestFiles(String code, String... otherFiles) {
    List<PsiElement> res = new ArrayList<>();
    res.addAll(getUserVars(myFixture.configureByText("a.awk", code)));
    for (int i = 0; i < otherFiles.length; i++) {
      String otherFileCode = otherFiles[i];
      res.addAll(getUserVars(myFixture.addFileToProject("f" + i + ".awk", otherFileCode)));
    }
    return res;
  }
}
