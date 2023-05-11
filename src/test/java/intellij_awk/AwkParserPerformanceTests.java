package intellij_awk;

public class AwkParserPerformanceTests extends ParsingTestCaseBase {
  public AwkParserPerformanceTests() {
    super("parser_performance", "txt", new AwkParserDefinition());
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
