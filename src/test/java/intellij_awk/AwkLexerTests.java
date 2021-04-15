package intellij_awk;

import com.intellij.lexer.Lexer;
import com.intellij.testFramework.LexerTestCase;
import org.jetbrains.annotations.NotNull;

import java.nio.file.Paths;

public class AwkLexerTests extends LexerTestCase {

  public void testIf1() {
    System.out.println(Paths.get("").toAbsolutePath());
    doFileTest("awk");
  }

  public void testIf2() {
    doFileTest("awk");
  }

  @Override
  protected Lexer createLexer() {
    return new AwkLexerAdapter();
  }

  @Override
  protected String getDirPath() {
    return "src/test/testData/lexer";
  }

  @NotNull
  protected String getPathToTestDataFile(String extension) {
    return getDirPath() + "/" + getTestName(false) + extension;
  }
}
