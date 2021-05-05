package intellij_awk;

import com.intellij.codeInsight.lookup.LookupElement;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import org.jetbrains.annotations.NotNull;

import java.util.Arrays;
import java.util.Set;
import java.util.stream.Collectors;

public class AwkCompletionTests extends BasePlatformTestCase {

  public void test1() {
    checkCompletion(
        Set.of("f1", "f2", "NR", "tolower"),
        Set.of("BEGIN", "END"),
        "function f1() {}\nfunction f2(){}\n{ <caret> }");
  }

  public void test2() {
    checkCompletion(
        Set.of("f1", "f2", "NR", "tolower"),
        Set.of("BEGIN", "END"),
        "function f1() {}\nfunction f2(){}\n{ 1 + <caret> }");
  }

  public void test3() {
    checkCompletion(
        Set.of("f1", "f2", "NR", "tolower"),
        Set.of("BEGIN", "END"),
        "function f1() {}\nfunction f2(){}\n{ print a[<caret>] }");
  }

  public void test4() {
    checkCompletion(
        Set.of("f1", "f2", "NR", "tolower", "BEGIN", "END"),
        Set.of("return"),
        "function f1() {}\nfunction f2(){}\n<caret>");
  }

  public void test5() {
    checkCompletion(
        Set.of("NR"),
        Set.of("return", "f1", "f2", "tolower", "BEGIN", "END"),
        "function f1() {}\nfunction f2(){}\n{ delete <caret> }");
  }

  public void test6() {
    checkCompletion(
        Set.of("var1", "var2", "arg1", "arg2", "arg3", "delete", "printf"),
        Set.of(),
        "BEGIN { var1=1\nsplit(\"\",var2)}\nfunction f1(arg1, arg2,     arg3) { <caret> }");
  }

  public void test7() {
    checkCompletionSingle("func<caret>", "function <caret>");
  }

  public void test8() {
    checkCompletionSingle("BEG<caret>", "BEGIN { <caret>}");
  }

  public void test9() {
    checkCompletionSingle("function f() { retu<caret> }", "function f() { return<caret> }");
  }

  public void test10() {
    checkCompletionSingle("function f() { tolow<caret> }", "function f() { tolower(<caret>) }");
  }

  public void test11() {
    checkCompletionExact(
        Set.of("aaa1", "aaa2"),
        "function aaa1(){}\nfunction bbb(){}\nfunction aaa2(){}\n{ aaa<caret> }");
  }

  public void testNoCompletion1() {
    String code = "function a(<caret>){}";
    checkCompletionSingle(code, code);
  }

  public void testNoCompletion2() {
    String code = "function a(){ BEG<caret> }";
    checkCompletionSingle(code, code);
  }

  private void checkCompletionSingle(String code, String expectedResult) {
    setupCode(code);
    LookupElement[] variants = myFixture.completeBasic();
    if (!(variants == null || variants.length == 0)) {
      fail("Should be empty completion: " + toSet(variants));
    }
    myFixture.checkResult(expectedResult);
  }

  private void checkCompletionExact(Set<String> expected, String code) {
    setupCode(code);
    LookupElement[] variants = myFixture.completeBasic();
    assertNotNull(
        "Expected completions that contain " + expected + ", but no completions found", variants);
    Set<String> actual = toSet(variants);
    assertEquals("expected = " + expected + ", actual = " + actual, expected, actual);
  }

  private void checkCompletion(Set<String> required, Set<String> excluding, String code) {
    setupCode(code);
    LookupElement[] variants = myFixture.completeBasic();
    assertNotNull(
            "Expected completions that contain " + required + ", but no completions found", variants);
    Set<String> actual = toSet(variants);
    assertTrue("required = " + required + ", actual = " + actual, actual.containsAll(required));
    for (String excl : excluding) {
      assertFalse(excl + " present in actual=" + actual, actual.contains(excl));
    }
  }

  @NotNull
  private static Set<String> toSet(LookupElement[] variants) {
    return Arrays.stream(variants).map(LookupElement::getLookupString).collect(Collectors.toSet());
  }

  private void setupCode(String code) {
    if (!code.contains("<caret>")) {
      throw new IllegalArgumentException("Please, add `<caret>` marker to code");
    }
    myFixture.configureByText("a.awk", code);
  }
}
