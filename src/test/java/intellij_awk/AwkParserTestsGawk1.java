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

  private void ensureOnlyParsingNoErrors() {
    doTest(false);
    ensureNoErrorElements();
  }
}
