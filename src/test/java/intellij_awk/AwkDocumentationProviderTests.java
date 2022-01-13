package intellij_awk;

import com.intellij.codeInsight.documentation.DocumentationManager;
import com.intellij.lang.documentation.DocumentationProvider;
import com.intellij.psi.PsiElement;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import org.jsoup.Jsoup;

import java.util.function.BiConsumer;
import java.util.function.Predicate;

/**
 * Based on approach:
 * https://intellij-support.jetbrains.com/hc/en-us/community/posts/4415025845138-What-is-the-recommended-approach-for-testing-DocumentationProvider-I-ve-added-for-my-language-support-plugin-
 */
public class AwkDocumentationProviderTests extends BasePlatformTestCase {
  public void testAwkFunctionSubstr() {
    doTest(
        "subs<caret>tr(\"abc\",1,2)",
        s ->
            s.contains("substr(string, start [, length ])")
                && s.contains(
                    "Return a length-character-long substring of string, starting at character number start"));
  }

  public void testAwkFunctionSprintf() {
    doTest(
        "BEGIN { print <caret>sprintf(\"%s\",1) }",
        s ->
            s.contains("sprintf(format, expression1, …)")
                && s.contains(
                    "Return (without printing) the string that printf would have printed out with the same arguments")
                && s.contains("Print a number in floating-point notation")
                && s.contains("The minus sign, used before the width modifier"));
  }

  public void testGawkFunctionStrftime() {
    doTest(
        "function a() { return strf<caret>time() }",
        s ->
            s.contains("strftime([format [, timestamp [, utc-flag] ] ])")
                && s.contains("Gawk-only!")
                && s.contains(
                    "Format the time specified by timestamp based on the contents of the format string")
                && s.contains("The minute as a decimal number (00–59)"));
  }

  public void testAwkVarFS() {
    doTest(
        "BEGIN { FS<caret>=\":\" }",
        s -> s.contains("FS") && s.contains("The input field separator"));
  }

  public void testGawkVarBINMODE() {
    doTest(
        "BEGIN { BIN<caret>MODE=1 }",
        s ->
            s.contains("BINMODE")
                && s.contains("this variable specifies use of binary mode")
                && s.contains("Gawk-only!"));
  }

  public final BiConsumer<String, String> awkFunctionChecker =
      (funcName, funcSig) ->
          doTest(
              "{ print " + funcName + "<caret>(); }",
              s ->
                  s.contains(funcName + funcSig)
                      && AwkFunctions.gawkFunctions.containsKey(funcName)
                          == s.contains("Gawk-only!"));

  public void testAllFunctionsDocsPresent() {
    AwkFunctions.builtInFunctions.forEach(awkFunctionChecker);
    AwkFunctions.gawkFunctions.forEach(awkFunctionChecker);
  }

  private void doTest(String code, Predicate<String> docChecker) {
    myFixture.configureByText("a.awk", code);
    PsiElement docElement =
        DocumentationManager.getInstance(getProject())
            .findTargetElement(myFixture.getEditor(), myFixture.getFile());

    DocumentationProvider provider = DocumentationManager.getProviderFromElement(docElement);

    String docString = provider.generateDoc(docElement, getOriginalElement());
    String docStringWithoutHtmlTags = removeTags(docString);
    assertTrue("Incorrect doc detected", docChecker.test(docStringWithoutHtmlTags));
  }

  private String removeTags(String docString) {
    return Jsoup.parse(docString).text();
  }

  private PsiElement getOriginalElement() {
    return myFixture.getFile().findElementAt(myFixture.getEditor().getCaretModel().getOffset());
  }
}
