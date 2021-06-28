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

  @Override
  protected @NotNull String getTestName(boolean lowercaseFirstLetter) {
    return super.getTestName(lowercaseFirstLetter).toLowerCase();
  }

  public void testNs1() { ensureOnlyParsingNoErrors(); }
  public void testNs2() { ensureOnlyParsingNoErrors(); }
  public void testNs3() { ensureOnlyParsingNoErrors(); }

  private void ensureOnlyParsingNoErrors() {
    doTest(false);
    ensureNoErrorElements();
  }
}
