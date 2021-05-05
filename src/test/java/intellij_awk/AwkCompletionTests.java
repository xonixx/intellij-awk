package intellij_awk;

import com.intellij.codeInsight.lookup.LookupElement;
import com.intellij.psi.PsiFile;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;

import java.util.Arrays;
import java.util.Set;
import java.util.stream.Collectors;

public class AwkCompletionTests extends BasePlatformTestCase {
  private PsiFile psiFile;

  public void test1() {
    checkCompletion(
        Set.of("f1", "f2", "tolower"),
        "" + "function f1() {}\n" + "function f2(){}\n" + "{ <caret> }");
  }

  private void checkCompletion(Set<String> required, String code) {
    checkCompletion(required, code, false);
  }

  private void checkCompletion(Set<String> required, String code, boolean strict) {
    setupCode(code);
    LookupElement[] variants = myFixture.completeBasic();
    assertNotNull(
        "Expected completions that contain " + required + ", but no completions found", variants);
    Set<String> actual =
        Arrays.stream(variants).map(LookupElement::getLookupString).collect(Collectors.toSet());
    assertTrue(
        "required = " + required + ", actual = " + actual,
        strict ? actual.equals(required) : actual.containsAll(required));
  }

  private void setupCode(String code) {
    if (!code.contains("<caret>")) {
      throw new IllegalArgumentException("Please, add `<caret>` marker to code");
    }
    psiFile = myFixture.configureByText("a.awk", code);
  }
}
