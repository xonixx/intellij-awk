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

  public final BiConsumer<String, String> awkFunctionChecker =
      (funcName, funcSig) ->
          doTest("{ print " + funcName + "<caret>(); }", s -> s.contains(funcName + funcSig));

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
