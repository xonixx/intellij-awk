package intellij_awk;

import com.intellij.codeInsight.documentation.DocumentationManager;
import com.intellij.lang.documentation.DocumentationProvider;
import com.intellij.psi.PsiElement;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import java.util.Objects;
import java.util.function.BiConsumer;
import java.util.function.Consumer;
import java.util.function.Predicate;
import org.jsoup.Jsoup;

/**
 * Based on approach: <a
 * href="https://intellij-support.jetbrains.com/hc/en-us/community/posts/4415025845138-What-is-the-recommended-approach-for-testing-DocumentationProvider-I-ve-added-for-my-language-support-plugin-">What
 * is the recommended approach for testing DocumentationProvider</a>
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

  public void testGawkVarPROCINFO() {
    doTest(
        "BEGIN { print <caret>PROCINFO[\"\"] }",
        s ->
            s.contains("information about the running awk program")
                && s.contains("PROCINFO[\"argv\"]")
                && s.contains("PROCINFO[\"sorted_in\"]"));
  }

  public void testGlobalVar1() {
    doTest(
        "BEGIN {\nVar = 1  # doc_string\n}\n{ print Va<caret>r }",
        s -> s.contains("Var = 1") && s.contains("doc_string"));
  }

  public void testGlobalVar2() {
    doTest(
        "BEGIN {\ndelete Var #   doc_string\n}\n{ print Va<caret>r[0] }",
        s -> s.contains("delete Var") && s.contains("doc_string"));
  }

  public void testGlobalVar3() {
    doTest(
        "BEGIN {\nsplit(\"\",Var) \t  #  \t doc string \t \n}\n{ print Var<caret>[0] }",
        s -> s.contains("split(\"\",Var)") && s.contains("doc string"));
  }

  public void testGlobalVar4() {
    doTest(
        "BEGIN {\nVar[\"a\"] # doc string\nVar[\"b\"]}\n{ print <caret>Var[\"b\"] }",
        s -> s.contains("Var[\"a\"]") && s.contains("doc string"));
  }

  public void testGlobalVar5() {
    doTest(
        "BEGIN {\nVar[\"a\"] = 1 # doc string\n}\n{ print <caret>Var[\"b\"] }",
        s -> s.contains("Var[\"a\"] = 1") && s.contains("doc string"));
  }

  public void testGlobalVar6() {
    doTest("BEGIN {\nVar = 1\n}\n{ print Va<caret>r }", s -> s.contains("Var = 1"));
  }

  public void testGlobalVarNoDoc1() {
    doTest("Var<caret> {}", Objects::isNull);
  }

  public void testFunc1() {
    doTest("BEGIN { a<caret>(1,2) } function a(b,c,   d){}", s -> s.contains("function a(b, c)"));
  }

  public void testFunc2() {
    doTest(
        "function a(b,c,    d,e) {return 7}\nEND{ print <caret>a() }",
        s -> s.contains("function a(b, c)"));
  }

  public void testFunc3() {
    doTest(
        "function a(b,c,    d,e) {\nprint\n}\n<caret>a(7) { exit 7 }",
        s -> s.contains("function a(b, c)"));
  }

  public void testStmtExit1() {
    testStmtExit("BEGIN { exi<caret>t 123 }");
  }

  public void testStmtExit2() {
    testStmtExit("BEGIN { exit<caret> 123 }");
  }

  public void testStmtExit3() {
    testStmtExit("BEGIN { exit<caret>(123) }");
  }
  public void testStmtExit4() {
    testStmtExit("BEGIN { exit<caret>\n}");
  }
  public void testStmtExit5() {
    testStmtExit("BEGIN {exit<caret>}");
  }

  private void testStmtExit(String code) {
    doTest(code, s -> s.contains("The exit statement causes awk to immediately stop executing"));
  }

  public void testStmtPrintf1() {
    testStmtPrintf("END { <caret>printf \"%s\", 123 }");
  }

  public void testStmtPrintf2() {
    testStmtPrintf("END { printf<caret> \"%s\", 123 }");
  }

  public void testStmtPrintf3() {
    testStmtPrintf("END { printf<caret>(\"%s\", 123) }");
  }

  public void testStmtPrintf4() {
    testStmtPrintf("END { printf<caret>(\"\") }");
  }

  public void testGetline1() {
    testStmtGetline("BEGIN { getli<caret>ne }");
  }
  public void testGetline2() {
    testStmtGetline("BEGIN { while(getline<caret> > 0) {} }");
  }

  public void testGetline3() {
    testStmtGetline("BEGIN { while(<caret>getline <\"file\" > 0) {} }");
  }
  public void testGetline4() {
    testStmtGetline("BEGIN { while(getline<caret>) {} }");
  }
  public void testGetline5() {
    testStmtGetline("BEGIN { getline<caret> }");
  }
  public void testGetline6() {
    testStmtGetline("BEGIN { getline<caret>\n}");
  }
  public void testGetline7() {
    testStmtGetline("BEGIN { getline<caret>}");
  }

  private void testStmtPrintf(String code) {
    doTest(
        code,
        s ->
            s.contains("printf")
                && s.contains("Print a number in floating-point notation")
                && s.contains("The minus sign, used before the width modifier"));
  }

  private void testStmtGetline(String code) {
    doTest(code, s -> s.contains("getline") && s.contains("returns 1") && s.contains("Effect"));
  }

  public final Consumer<String> awkVariableChecker =
      (varName) ->
          doTest(
              "{ print " + varName + "<caret> }",
              s ->
                  s.contains(varName)
                      && AwkVariables.gawkVariables.contains(varName) == s.contains("Gawk-only!"));

  public void testAllVariablesDocsPresent() {
    AwkVariables.builtInVariables.forEach(awkVariableChecker);
    AwkVariables.gawkVariables.forEach(awkVariableChecker);
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
    String docStringWithoutHtmlTags = docString != null ? removeTags(docString) : null;
    assertTrue("Incorrect doc detected", docChecker.test(docStringWithoutHtmlTags));
  }

  private String removeTags(String docString) {
    return Jsoup.parse(docString).text();
  }

  private PsiElement getOriginalElement() {
    return myFixture.getFile().findElementAt(myFixture.getEditor().getCaretModel().getOffset());
  }
}
