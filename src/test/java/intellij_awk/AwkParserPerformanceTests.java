package intellij_awk;

public class AwkParserPerformanceTests extends ParsingTestCaseBase {
  public AwkParserPerformanceTests() {
    super("parser_performance", "txt", new AwkParserDefinition());
  }

  @Override
  protected String getTestDataPath() {
    return "src/test/testData";
  }

  public void testLongExpression() {
    ensureOnlyParsingNoErrors();
  }

  public void testLongExpression2() {
    ensureOnlyParsingNoErrors();
  }

  public void testLongExpression3() {
    ensureOnlyParsingNoErrors();
  }
}
