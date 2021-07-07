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

  public void testForWhileEtc() {
    doFileTest("awk");
  }

  public void testActionlessBegin() {
    doFileTest("awk");
  }

  public void testActionlessEnd() {
    doFileTest("awk");
  }

  public void testFunctionBegin() {
    doFileTest("awk");
  }

  public void testFunctionEnd() {
    doFileTest("awk");
  }

  public void testNumbers() {
    doFileTest("awk");
  }

  public void testBuiltins() {
    doFileTest("awk");
  }

  public void testBadChar() {
    doFileTest("awk");
  }
  public void testEreAmbiguity1() {
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
