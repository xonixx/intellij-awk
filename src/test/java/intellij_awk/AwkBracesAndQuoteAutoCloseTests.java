package intellij_awk;

import com.intellij.testFramework.fixtures.BasePlatformTestCase;

public class AwkBracesAndQuoteAutoCloseTests extends BasePlatformTestCase {

  public void testParen_should1() {
    doTest('(', "BEGIN { a<caret> }", "BEGIN { a(<caret>) }");
  }

  public void testParen_should2() {
    doTest('(', "BEGIN {a<caret>}", "BEGIN {a(<caret>)}");
  }

  public void testParen_shouldNot1() {
    doTest('(', "BEGIN { A = <caret>a }", "BEGIN { A = (<caret>a }");
  }

  public void testParen_shouldNot2() {
    doTest('(', "BEGIN { A = <caret>a() }", "BEGIN { A = (<caret>a() }");
  }

  public void testBrace_should1() {
    doTest('{', "BEGIN <caret>", "BEGIN {<caret>}");
  }

  public void testBracket_should1() {
    doTest('[', "BEGIN { a<caret> }", "BEGIN { a[<caret>] }");
  }

  public void testQuote_should1() {
    doTest('"', "BEGIN { print <caret> }", "BEGIN { print \"<caret>\" }");
  }

  public void testQuote1() {
    doTest(
        '"',
        "BEGIN {\n  print <caret>\n  print \"\"}",
        "BEGIN {\n  print \"<caret>\"\n  print \"\"}");
  }

  private void doTest(char brace, String code, String expectedCode) {
    myFixture.configureByText("a.awk", code);
    myFixture.type(brace);
    myFixture.checkResult(expectedCode);
  }
}
