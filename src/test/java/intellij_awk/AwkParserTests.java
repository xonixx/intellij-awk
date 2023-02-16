package intellij_awk;

public class AwkParserTests extends ParsingTestCaseBase {
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

  public void testMultilineStr() {
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
  public void testPrintGetline() {
    ensureOnlyParsingNoErrors();
  }

  public void testDeleteArr() {
    ensureOnlyParsingNoErrors();
  }

  public void testIssue63_1() { ensureOnlyParsingNoErrors(); }
  public void testIssue63_2() { ensureOnlyParsingNoErrors(); }
  public void testIssue63_3() { ensureOnlyParsingNoErrors(); }

  public void testSemi0() { ensureOnlyParsingNoErrors(); }
  public void testSemi1() { ensureOnlyParsingNoErrors(); }
  public void testSemi2Err() { ensureParsingError(); }
  public void testSemi3() { ensureOnlyParsingNoErrors(); }

  public void testPrint1() { ensureOnlyParsingNoErrors(); }
  public void testPrint2() { ensureOnlyParsingNoErrors(); }
  public void testPrint3() { ensureOnlyParsingNoErrors(); }
  public void testPrint4() { doTest(true); }
  public void testPrint5() { doTest(true); }

  public void testBuiltInFuncSpace() { doTest(true); }
  public void testUserFuncSpace() { doTest(true); }

  public void testUnterminatedElse1() { ensureOnlyParsingNoErrors(); }
}
