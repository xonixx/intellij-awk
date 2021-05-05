package intellij_awk;

import com.intellij.codeInsight.lookup.LookupElement;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;

import java.util.Arrays;
import java.util.Set;
import java.util.stream.Collectors;

public class AwkCompletionTests extends BasePlatformTestCase {

  public void test1() {
    checkCompletion(
        Set.of("f1", "f2", "NR", "tolower"),
        Set.of(),
        "function f1() {}\nfunction f2(){}\n{ <caret> }");
  }

  public void test2() {
    checkCompletion(
        Set.of("f1", "f2", "NR", "tolower"),
        Set.of(),
        "function f1() {}\nfunction f2(){}\n{ 1 + <caret> }");
  }

  public void test3() {
    checkCompletion(
        Set.of("f1", "f2", "NR", "tolower"),
        Set.of(),
        "function f1() {}\nfunction f2(){}\n{ print a[<caret>] }");
  }

  public void test4() {
    checkCompletion(
        Set.of("f1", "f2", "NR", "tolower"),
        Set.of("return"),
        "function f1() {}\nfunction f2(){}\n<caret>");
  }

  public void test5() {
    checkCompletion(
        Set.of("NR"),
        Set.of("return", "f1", "f2", "tolower"),
        "function f1() {}\nfunction f2(){}\n{ delete <caret> }");
  }

  private void checkCompletion(Set<String> required, Set<String> excluding, String code) {
    setupCode(code);
    LookupElement[] variants = myFixture.completeBasic();
    assertNotNull(
        "Expected completions that contain " + required + ", but no completions found", variants);
    Set<String> actual =
        Arrays.stream(variants).map(LookupElement::getLookupString).collect(Collectors.toSet());
    assertTrue("required = " + required + ", actual = " + actual, actual.containsAll(required));
    for (String excl : excluding) {
      assertFalse(excl + " present in actual=" + actual, actual.contains(excl));
    }
  }

  private void setupCode(String code) {
    if (!code.contains("<caret>")) {
      throw new IllegalArgumentException("Please, add `<caret>` marker to code");
    }
    myFixture.configureByText("a.awk", code);
  }
}
