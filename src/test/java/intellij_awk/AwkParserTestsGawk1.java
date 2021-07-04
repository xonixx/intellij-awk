package intellij_awk;

import com.intellij.testFramework.ParsingTestCase;
import org.jetbrains.annotations.NotNull;

public class AwkParserTestsGawk1 extends ParsingTestCase {
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
  public void testSwitchErr1() { ensureParsingError(); }

  private void ensureOnlyParsingNoErrors() {
    doTest(false);
    ensureNoErrorElements();
  }

  private void ensureParsingError() {
    doTest(false);
    boolean success;
    try {
      ensureNoErrorElements();
      success = true;
    } catch (Throwable ignore) {
      success = false;
    }
    if (success) {
      fail("Should not parse");
    }
  }
}
