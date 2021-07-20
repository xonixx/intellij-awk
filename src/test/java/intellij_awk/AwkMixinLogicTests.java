package intellij_awk;

import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import intellij_awk.psi.AwkElementFactory;
import intellij_awk.psi.AwkUserVarNameMixin;

public class AwkMixinLogicTests extends BasePlatformTestCase {

  private void doTestLooksLikeDeclaration(boolean expectedResult, String code) {
    AwkUserVarNameMixin awkUserVarNameMixin =
        AwkElementFactory.createAwkPsiElement(
            myFixture.getProject(), code, AwkUserVarNameMixin.class);
    assertEquals(expectedResult, awkUserVarNameMixin.looksLikeDeclaration());
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
}
