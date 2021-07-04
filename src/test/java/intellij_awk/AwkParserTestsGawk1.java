package intellij_awk;

public class AwkParserTestsGawk1 extends ParsingTestCaseBase {
  public AwkParserTestsGawk1() {
    super("parser/gawk1", "awk", new AwkParserDefinition());
  }

  @Override
  protected String getTestDataPath() {
    return "src/test/testData";
  }

  public void testNs1() { ensureOnlyParsingNoErrors(); }
  public void testNs2() { ensureOnlyParsingNoErrors(); }
  public void testNs3() { ensureOnlyParsingNoErrors(); }

  public void testBeginfileEndfileNextfile() { doTest(true); }
  public void testEre1() { doTest(true); }

  public void testTypedEre1() { ensureOnlyParsingNoErrors(); }
  public void testTypedEre2() { ensureOnlyParsingNoErrors(); }

  public void testFunc1() { doTest(true); }

  public void testSwitch0() { ensureOnlyParsingNoErrors(); }
  public void testSwitch1() { ensureOnlyParsingNoErrors(); }
  public void testSwitch2() { ensureOnlyParsingNoErrors(); }
  public void testSwitch3() { ensureOnlyParsingNoErrors(); }
  public void testSwitch4() { ensureOnlyParsingNoErrors(); }
  public void testSwitch5() { ensureOnlyParsingNoErrors(); }
  public void testSwitch6Err() { ensureParsingError(); }
}
