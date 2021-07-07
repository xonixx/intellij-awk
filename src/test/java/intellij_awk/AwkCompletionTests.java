package intellij_awk;

import com.intellij.codeInsight.lookup.LookupElement;
import com.intellij.codeInsight.lookup.LookupElementPresentation;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import org.jetbrains.annotations.NotNull;

import java.util.Arrays;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class AwkCompletionTests extends BasePlatformTestCase {

  public static final String POSIX_FUNC = "tolower";
  public static final String GAWK_FUNC = "and";
  public static final String POSIX_VAR = "NR";
  public static final String GAWK_VAR = "ERRNO";

  public void test1() {
    checkCompletion(
        Set.of("f1", "f2", POSIX_VAR, GAWK_VAR, POSIX_FUNC, GAWK_FUNC),
        Set.of("BEGIN", "END"),
        "function f1() {}\nfunction f2(){}\n{ <caret> }");
  }

  public void test2() {
    checkCompletion(
        Set.of("f1", "f2", POSIX_VAR, GAWK_VAR, POSIX_FUNC, GAWK_FUNC),
        Set.of("BEGIN", "END"),
        "function f1() {}\nfunction f2(){}\n{ 1 + <caret> }");
  }

  public void test3() {
    checkCompletion(
        Set.of("f1", "f2", POSIX_VAR, GAWK_VAR, POSIX_FUNC, GAWK_FUNC),
        Set.of("BEGIN", "END"),
        "function f1() {}\nfunction f2(){}\n{ print a[<caret>] }");
  }

  public void test4() {
    checkCompletion(
        Set.of("f1", "f2", POSIX_VAR, GAWK_VAR, POSIX_FUNC, "BEGIN", "END"), // TODO do we want to autocomplete BEGINFILE/ENDFILE?
        Set.of("return"),
        "function f1() {}\nfunction f2(){}\n<caret>");
  }

  public void test5() {
    checkCompletion(
        Set.of(POSIX_VAR, GAWK_VAR),
        //        Set.of("return", "f1", "f2", "tolower", "BEGIN", "END"), // TODO
        Set.of(),
        "function f1() {}\nfunction f2(){}\n{ delete <caret> }");
  }

  public void test6() {
    checkCompletion(
        Set.of("var1", "var2", "arg1", "arg2", "arg3", "delete", "printf", "next"),
        Set.of(),
        "BEGIN { var1=1\nsplit(\"\",var2)}\nfunction f1(arg1, arg2,     arg3) { <caret> }");
  }

  public void test7() {
    checkCompletionSingle("funct<caret>", "function <caret>");
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

  public void testFunctionArgs1() {
    checkFunctionArgs(
        "BEGIN { <caret> }\nfunction func1(arg1, arg2,     arg3) {}", "func1", "(arg1, arg2)");
  }

  public void testFunctionArgs2() {
    checkFunctionArgs(
        "BEGIN { <caret> }\nfunction func1(arg1, arg2,\\\narg3) {}", "func1", "(arg1, arg2)");
  }

  private void checkFunctionArgs(String code, String fName, String expectedArgs) {
    setupCode(code);
    LookupElement[] variants = myFixture.completeBasic();
    LookupElement resLookupElem =
        Stream.of(variants)
            .filter(lookupElement -> fName.equals(lookupElement.getLookupString()))
            .findAny()
            .orElseThrow();
    LookupElementPresentation presentation = new LookupElementPresentation();
    resLookupElem.renderElement(presentation);
    assertEquals(expectedArgs, presentation.getTailText());
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
