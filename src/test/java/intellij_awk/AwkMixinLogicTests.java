package intellij_awk;

import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import intellij_awk.psi.AwkElementFactory;
import intellij_awk.psi.AwkUserVarNameMixin;

public class AwkMixinLogicTests extends BasePlatformTestCase {

  public void test1() {
    AwkUserVarNameMixin awkUserVarNameMixin =
        AwkElementFactory.createAwkPsiElement(
            myFixture.getProject(), "{ A = 1 }", AwkUserVarNameMixin.class);
    assertTrue(awkUserVarNameMixin.looksLikeDeclaration());
  }

  public void test2() {
    AwkUserVarNameMixin awkUserVarNameMixin =
        AwkElementFactory.createAwkPsiElement(
            myFixture.getProject(), "{ split(\"\", A) }", AwkUserVarNameMixin.class);
    assertTrue(awkUserVarNameMixin.looksLikeDeclaration());
  }

  public void test3() {
    AwkUserVarNameMixin awkUserVarNameMixin =
        AwkElementFactory.createAwkPsiElement(
            myFixture.getProject(), "{ f(\"\", A) }", AwkUserVarNameMixin.class);
    assertFalse(awkUserVarNameMixin.looksLikeDeclaration());
  }

  public void test4() {
    AwkUserVarNameMixin awkUserVarNameMixin =
        AwkElementFactory.createAwkPsiElement(
            myFixture.getProject(), "{ A++ }", AwkUserVarNameMixin.class);
    assertFalse(awkUserVarNameMixin.looksLikeDeclaration());
  }
}
