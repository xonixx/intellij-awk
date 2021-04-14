package intellij_awk;

import com.intellij.testFramework.ParsingTestCase;

public class AwkParserTests extends ParsingTestCase {
  public AwkParserTests() {
    super("", "awk", new AwkParserDefinition());
  }

  @Override
  protected String getTestDataPath() {
    return "src/test/testData";
  }

  public void testJsonGenAsm() {
    doTest(true);
  }

  @Override
  protected boolean skipSpaces() {
    return false;
  }

  @Override
  protected boolean includeRanges() {
    return true;
  }
}
