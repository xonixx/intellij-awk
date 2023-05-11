package intellij_awk;

import com.intellij.lang.ParserDefinition;
import com.intellij.testFramework.ParsingTestCase;
import org.jetbrains.annotations.NotNull;

abstract class ParsingTestCaseBase extends ParsingTestCase {
  @Override
  protected String getTestDataPath() {
    return "src/test/testData";
  }

  protected void ensureOnlyParsingNoErrors() {
    doTest(false);
    ensureNoErrorElements();
  }

  protected void ensureParsingError() {
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

  protected ParsingTestCaseBase(
      @NotNull String dataPath,
      @NotNull String fileExt,
      ParserDefinition @NotNull ... definitions) {
    super(dataPath, fileExt, definitions);
  }

  protected ParsingTestCaseBase(
      @NotNull String dataPath,
      @NotNull String fileExt,
      boolean lowercaseFirstLetter,
      ParserDefinition @NotNull ... definitions) {
    super(dataPath, fileExt, lowercaseFirstLetter, definitions);
  }
}
