package intellij_awk;

import com.intellij.codeInsight.lookup.Lookup;
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
        Set.of(
            "f1",
            "f2",
            POSIX_VAR,
            GAWK_VAR,
            POSIX_FUNC,
            "BEGIN",
            "END"), // TODO do we want to autocomplete BEGINFILE/ENDFILE?
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

  public void test6_1() {
    checkCompletion(
        Set.of("var1", "var2", "arg1", "arg2", "arg3", "delete", "printf", "next"),
        Set.of(),
        "BEGIN { var1=1\nsplit(\"\",var2)}\nfunction f1(arg1, arg2,     arg3) { print <caret> }");
  }

  public void test7() {
    checkCompletionAuto("func<caret>", "function <caret>");
  }

  public void test8() {
    checkCompletionAuto("BEG<caret>", "BEGIN { <caret>}");
  }

  public void test9() {
    checkCompletionAuto("function f() { retu<caret> }", "function f() { return<caret> }");
  }

  public void test10() {
    checkCompletionAuto("function f() { tolow<caret> }", "function f() { tolower(<caret>) }");
  }

  public void test10_1() {
    checkCompletionAuto("function f() { tolow<caret>() }", "function f() { tolower(<caret>) }");
  }

  public void test10_2() {
    checkCompletionAuto("BEGIN { tolow<caret>() }", "BEGIN { tolower(<caret>) }");
  }

  public void test10_3() {
    checkCompletionExact(Set.of("tolower"), "BEGIN { tolo<caret>w() }");
  }

  public void test10_4() {
    checkCompletionAuto(
        "function f() { tolow<caret>(\"A\") }", "function f() { tolower(<caret>\"A\") }");
  }

  public void test10_5() {
    checkCompletionAuto(
        "function f() { fff1<caret>() } function fff123(){}",
        "function f() { fff123(<caret>) } function fff123(){}");
  }

  public void test10_6() {
    checkCompletionAuto(
        "function f() { fff1<caret>(\"A\") } function fff123(){}",
        "function f() { fff123(<caret>\"A\") } function fff123(){}");
  }

  public void test10_7() {
    checkCompletionSingle(
        Lookup.NORMAL_SELECT_CHAR,
        "function f() { fff1<caret>aaa() } function fff123(){}",
        "function f() { fff123();<caret>aaa() } function fff123(){}");
  }

  public void test10_8() {
    checkCompletionSingle(
        Lookup.REPLACE_SELECT_CHAR,
        "function f() { fff1<caret>aaa() } function fff123(){}",
        "function f() { fff123(<caret>) } function fff123(){}");
  }

  public void test11() {
    checkCompletionExact(
        Set.of("aaa1", "aaa2"),
        "function aaa1(){}\nfunction bbb(){}\nfunction aaa2(){}\n{ aaa<caret> }");
  }

  public void test12() {
    checkCompletionAuto(
        "function f() {\n    BBBB = 1\n    print BB<caret> \n}",
        "function f() {\n    BBBB = 1\n    print BBBB<caret> \n}");
  }

  public void test12_1() {
    checkCompletionAuto(
        "BEGIN {\n    BBBB = 1\n} function f() { print BB<caret> \n}",
        "BEGIN {\n    BBBB = 1\n} function f() { print BBBB<caret> \n}");
  }

  public void test12_2() {
    checkCompletionAuto(
        "function bbbb(){} function f() { print bb<caret> }",
        "function bbbb(){} function f() { print bbbb(<caret>) }");
  }

  public void test12_3() {
    checkCompletionAuto(
        "function bbbb(){} function f() { printf bb<caret> }",
        "function bbbb(){} function f() { printf bbbb(<caret>) }");
  }

  public void testMultiFilesFunc1() {
    checkCompletionExact(
        Set.of("aaa1", "aaa2"),
        "function bbb(){}\nfunction aaa2(){}\n{ aaa<caret> }",
        "function aaa1(){}\n");
  }

  public void testMultiFilesVars1() {
    checkCompletionExact(
        Set.of("aaa1", "aaa2"),
        "function f() { aaa<caret> }; function init() { aaa1=1 }",
        "BEGIN { aaa2 = 2 }");
  }

  public void testMultiFilesVars2() {
    checkCompletionExact(
        Set.of("aaa1", "aaa2"),
        "function f() { aaa<caret> }; BEGIN { aaa2 = 2 }",
        "function init() { aaa1=1 }");
  }

  public void testMultiFilesVars3() {
    checkCompletionExact(
        Set.of("aaa1", "aaa3"),
        "function f(aaa3) { aaa<caret> }; function init() { aaa1=1 }",
        "{ aaa2 = 2 }");
  }

  public void testMultiFilesVars4() {
    checkCompletionExact(
        Set.of("aaa1", "aaa3"),
        "function f(aaa3) { aaa<caret> }; function init() { \"ls\" | getline aaa1 }",
        "{ aaa2 = 2 }");
  }

  public void testMultiFilesVars5() {
    checkCompletionExact(
        Set.of("aaa1", "aaa3"),
        "function f(aaa3) { aaa<caret> }; function init(aaa4) { print aaa1; print aaa4 }",
        "{ aaa2 = 2 }");
  }

  public void testFunctionArgs1() {
    checkFunctionArgs(
        "BEGIN { <caret> }\nfunction func1(arg1, arg2,     arg3) {}", "func1", "(arg1, arg2)");
  }

  public void testFunctionArgs2() {
    checkFunctionArgs(
        "BEGIN { <caret> }\nfunction func1(arg1, arg2,\\\narg3) {}", "func1", "(arg1, arg2)");
  }

  public void testFunctionArgsBuiltin1() {
    checkFunctionArgs("BEGIN { <caret> }", "gsub", "(regexp, replacement [, target])");
  }

  public void testFunctionArgsBuiltin2() {
    checkFunctionArgs("BEGIN { <caret> }", "gensub", "(regexp, replacement, how [, target])");
  }

  public void testSwitch() {
    checkCompletionAuto("{ sw<caret> }", "{ switch (<caret>) {} }");
  }

  public void testCase1() {
    checkCompletionAuto("{ switch(1) { cas<caret> } }", "{ switch(1) { case <caret>: } }");
  }

  public void testCase2() {
    checkCompletionAuto(
        "{ switch(1) { case \"hello\": cas<caret> } }",
        "{ switch(1) { case \"hello\": case <caret>: } }");
  }

  public void testDefault1() {
    checkCompletionAuto("{ switch(1) { def<caret> } }", "{ switch(1) { default:<caret> } }");
  }

  public void testDefault2() {
    checkCompletionAuto(
        "{ switch(1) { case \"hello\": def<caret> } }",
        "{ switch(1) { case \"hello\": default:<caret> } }");
  }

  public void testInsideString_1() {
    checkCompletion(
        Set.of(),
        Set.of("return", "for", "while", "break", POSIX_VAR, POSIX_FUNC, GAWK_VAR, GAWK_FUNC),
        "BEGIN { length(\"<caret>\") }");
  }

  public void testInsideString_1_1() {
    checkCompletion(
        Set.of(), Set.of("case", "default"), "BEGIN { switch (1) { case \"<caret>\":} }");
  }

  //  public void testInsideString_1_2() {
  //    checkCompletionEmpty("\"<caret>\"");
  //  }

  public void testInsideString_2() {
    checkCompletionAuto(
        "function f() { print \"fff1<caret>\" } function fff123(){}",
        "function f() { print \"fff123<caret>\" } function fff123(){}");
  }

  public void testInsideString_3() {
    checkCompletionAuto(
        "function f(aaa123) { print \"aaa1<caret>\" }",
        "function f(aaa123) { print \"aaa123<caret>\" }");
  }

  public void testInsideString_4() {
    checkCompletionAuto(
        "BEGIN { AAA123=1 } function f() { length(\"AAA1<caret>\") }",
        "BEGIN { AAA123=1 } function f() { length(\"AAA123<caret>\") }");
  }

  public void testInsideString_5() {
    checkCompletionAuto(
        "BEGIN { AAA123=1 } function f() { print \"AAA1<caret>\" }",
        "BEGIN { AAA123=1 } function f() { print \"AAA123<caret>\" }");
  }

  public void testInsideERE_1() {
    checkCompletionEmpty("BEGIN { if(/<caret>/){} }");
  }

  public void testInsideERE_2() {
    checkCompletionEmpty("/<caret>/");
  }

  public void testInsideERE_3() {
    checkCompletionEmpty("BEGIN {\n switch (1) { case /<caret>/: }\n}");
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
    checkCompletionAuto(code, code);
  }

  public void testNoCompletion2() {
    String code = "function a(){ BEG<caret> }";
    checkCompletionAuto(code, code);
  }

  private void checkCompletionAuto(String code, String expectedResult) {
    setupCode(code);
    LookupElement[] variants = myFixture.completeBasic();
    if (!(variants == null || variants.length == 0)) {
      fail("Should be empty completion: " + toSet(variants));
    }
    myFixture.checkResult(expectedResult);
  }

  private void checkCompletionEmpty(String code) {
    setupCode(code);
    LookupElement[] variants = myFixture.completeBasic();
    if (!(variants == null || variants.length == 0)) {
      fail("Should be empty completion: " + toSet(variants));
    }
  }

  private void checkCompletionSingle(char completionChar, String code, String expectedResult) {
    setupCode(code);
    LookupElement[] variants = myFixture.completeBasic();
    if (variants != null && variants.length == 1) {
      myFixture.finishLookup(completionChar);
    } else {
      fail("Should be single completion: " + toSet(variants));
    }
    myFixture.checkResult(expectedResult);
  }

  private void checkCompletionExact(Set<String> expected, String code, String... otherFiles) {
    setupCode(code, otherFiles);
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

  private void setupCode(String code, String... otherFiles) {
    if (!code.contains("<caret>")) {
      throw new IllegalArgumentException("Please, add `<caret>` marker to code");
    }
    myFixture.configureByText("a.awk", code);
    for (int i = 0; i < otherFiles.length; i++) {
      String otherFileCode = otherFiles[i];
      myFixture.addFileToProject("f" + i + ".awk", otherFileCode);
    }
  }
}
