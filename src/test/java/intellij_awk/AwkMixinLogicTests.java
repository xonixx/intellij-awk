package intellij_awk;

import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import intellij_awk.psi.AwkElementFactory;
import intellij_awk.psi.AwkFunctionNameMixin;
import intellij_awk.psi.AwkUserVarNameMixin;

public class AwkMixinLogicTests extends BasePlatformTestCase {

  private AwkUserVarNameMixin getUserVarName(String code) {
    return AwkElementFactory.createAwkPsiElement(
        myFixture.getProject(), code, AwkUserVarNameMixin.class);
  }

  private void doTestLooksLikeDeclaration(boolean expectedResult, String code) {
    AwkUserVarNameMixin awkUserVarNameMixin = getUserVarName(code);
    assertEquals(expectedResult, awkUserVarNameMixin.looksLikeDeclaration());
  }

  private void doTestInInitContext(boolean expectedResult, String code) {
    AwkUserVarNameMixin awkUserVarNameMixin = getUserVarName(code);
    assertEquals(expectedResult, awkUserVarNameMixin.isInsideInitializingContext());
  }

  private void doTestFunctionSignature(String code, String expectedSignature) {
    AwkFunctionNameMixin functionName =
        AwkElementFactory.createAwkPsiElement(
            myFixture.getProject(), code, AwkFunctionNameMixin.class);
    assertNotNull(functionName);
    assertNull(functionName.getStub());
    assertEquals(expectedSignature, functionName.getSignatureString());
  }

  public void testFunctionSignatureWithoutParameters() {
    doTestFunctionSignature("function f() {}", "()");
  }

  public void testFunctionSignatureWithParameters() {
    doTestFunctionSignature("function f(a,b) {}", "(a, b)");
  }

  public void testFunctionSignatureExcludesLocals() {
    doTestFunctionSignature("function f(a,b,   local1,local2) {}", "(a, b)");
  }

  public void testFunctionSignatureExcludesLocals2() {
    doTestFunctionSignature("function f(a,b,\\\n" +
            "local1,local2) {}", "(a, b)");
  }

  public void testFunctionSignatureWithOnlyLocals() {
    doTestFunctionSignature("function f(   local1,local2) {}", "()");
  }

  public void testFunctionSignatureWithOnlyLocals2() {
    doTestFunctionSignature("function f(\\\n" +
            "  local1,local2) {}", "()");
  }

  public void test1() {
    doTestLooksLikeDeclaration(true, "{ A = 1 }");
  }

  public void test2() {
    doTestLooksLikeDeclaration(true, "{ split(\"\", A) }");
  }

  public void test3() {
    doTestLooksLikeDeclaration(false, "{ split(\"xxx\", A) }");
  }

  public void test4() {
    doTestLooksLikeDeclaration(false, "{ f(\"\", A) }");
  }

  public void test5() {
    doTestLooksLikeDeclaration(false, "{ A++ }");
  }

  public void test6() {
    doTestLooksLikeDeclaration(false, "{ A+1 }");
  }

  public void test7() {
    doTestLooksLikeDeclaration(true, "{ A[\"str\"] }");
  }

  public void test8() {
    doTestLooksLikeDeclaration(true, "{ A[\"str\"] = 1 }");
  }

  public void test9() {
    doTestLooksLikeDeclaration(false, "{ 1 + A[\"str\"] }");
  }

  public void test10() {
    doTestLooksLikeDeclaration(false, "{ A[\"str\"]++ }");
  }

  public void test11() {
    doTestLooksLikeDeclaration(true, "BEGIN {\n" + "    if ((Instr = trim($0))!=\"\") {}\n" + "}");
  }

  public void test12() {
    doTestLooksLikeDeclaration(true, "{ delete A }");
  }
  public void test13() {
    doTestLooksLikeDeclaration(true, "{ delete \t  A }");
  }

  public void test14() {
    doTestLooksLikeDeclaration(false, "{ delete A[1] }");
  }

  public void testInitCtx1() {
    doTestInInitContext(true, "BEGIN { A=1 }");
  }

  public void testInitCtx2() {
    doTestInInitContext(false, "END { A=1 }");
  }

  public void testInitCtx3() {
    doTestInInitContext(true, "function init() { A=1 }");
  }

  public void testInitCtx4() {
    doTestInInitContext(true, "function initSomething() { A=1 }");
  }

  public void testInitCtx5() {
    doTestInInitContext(false, "function f() { A=1 }");
  }

  public void testInitCtx6() {
    doTestInInitContext(false, "{ A=1 }");
  }

  public void testInitCtx7() {
    doTestInInitContext(false, "{ for(;;){ A=1 } }");
  }

  public void testInitCtx8() {
    doTestInInitContext(true, "BEGIN { while(1){ A=1 } }");
  }
}
