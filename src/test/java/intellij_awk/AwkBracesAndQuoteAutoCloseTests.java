package intellij_awk;

import com.intellij.testFramework.fixtures.BasePlatformTestCase;

public class AwkBracesAndQuoteAutoCloseTests extends BasePlatformTestCase {

  public void testParen_should1() {
    doTest('(', "BEGIN { a<caret> }", "BEGIN { a(<caret>) }");
  }

  public void testParen_should2() {
    doTest('(', "BEGIN {a<caret>}", "BEGIN {a(<caret>)}");
  }
  public void testParen_should3() {
    doTest('(', "BEGIN {if(a<caret>){}}", "BEGIN {if(a(<caret>)){}}");
  }
  public void testParen_should4() {
    doTest('(', "BEGIN {B[a<caret>]}", "BEGIN {B[a(<caret>)]}");
  }
  public void testParen_should5() {
    doTest('(', "function f(){ a=<caret>; }", "function f(){ a=(<caret>); }");
  }
  public void testParen_should6() {
    doTest('(', "function f(){ a=<caret>\n }", "function f(){ a=(<caret>)\n }");
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
  public void testBracket_should2() {
    doTest('[', "BEGIN {a<caret>}", "BEGIN {a[<caret>]}");
  }
  public void testBracket_should3() {
    doTest('[', "BEGIN {b(a<caret>)}", "BEGIN {b(a[<caret>])}");
  }
  public void testBracket_should4() {
    doTest('[', "BEGIN {B[a<caret>]}", "BEGIN {B[a[<caret>]]}");
  }
  public void testBracket_should5() {
    doTest('[', "function f(){ a=B<caret>; }", "function f(){ a=B[<caret>]; }");
  }
  public void testBracket_should6() {
    doTest('[', "function f(){ a=B<caret>\n }", "function f(){ a=B[<caret>]\n }");
  }

  public void testBracket_shouldNot1() {
    doTest('[', "BEGIN {<caret>B[1]}", "BEGIN {[<caret>B[1]}");
  }
  public void testBracket_shouldNot2() {
    doTest('[', "BEGIN {B<caret>[1]}", "BEGIN {B[<caret>[1]}");
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
