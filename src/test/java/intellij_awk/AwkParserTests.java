package intellij_awk;

import com.intellij.testFramework.ParsingTestCase;

public class AwkParserTests extends ParsingTestCase {
  public AwkParserTests() {
    super("parser", "awk", new AwkParserDefinition());
  }

  @Override
  protected String getTestDataPath() {
    return "src/test/testData";
  }

  public void testJsonGenAsm() {
    ensureOnlyParsingNoErrors();
  }

  public void testGronParser() {
    ensureOnlyParsingNoErrors();
  }

  public void testJsonCompile() {
    ensureOnlyParsingNoErrors();
  }

  public void testJsonGron() {
    ensureOnlyParsingNoErrors();
  }

  public void testJsonParser() {
    ensureOnlyParsingNoErrors();
  }

  public void testJsonStructure() {
    ensureOnlyParsingNoErrors();
  }

  public void testMakesure() {
    ensureOnlyParsingNoErrors();
  }

  public void testEmpty() {
    ensureOnlyParsingNoErrors();
  }

  public void testUngron() {
    ensureOnlyParsingNoErrors();
  }
  public void testFuncName() {
    ensureOnlyParsingNoErrors();
  }
  public void testPrintWithParenProblem() {
    ensureOnlyParsingNoErrors();
  }

  public void testDeleteArr() {
    ensureOnlyParsingNoErrors();
  }

  public void testIssue63_1() { ensureOnlyParsingNoErrors(); }
  public void testIssue63_2() { ensureOnlyParsingNoErrors(); }
  public void testIssue63_3() { ensureOnlyParsingNoErrors(); }

  public void testBuiltInFuncSpace() { doTest(true); }
  public void testUserFuncSpace() { doTest(true); }

  private void ensureOnlyParsingNoErrors() {
    doTest(false);
    ensureNoErrorElements();
  }
}
