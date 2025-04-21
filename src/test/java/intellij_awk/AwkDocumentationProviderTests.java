package intellij_awk;

import com.intellij.codeInsight.documentation.DocumentationManager;
import com.intellij.lang.documentation.DocumentationProvider;
import com.intellij.psi.PsiElement;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.function.BiConsumer;
import java.util.function.Consumer;
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
        "substr(string, start [, length ])",
        "Return a length-character-long substring of string, starting at character number start");
  }

  public void testAwkFunctionSprintf() {
    doTest(
        "BEGIN { print <caret>sprintf(\"%s\",1) }",
        "sprintf(format, expression1, …)",
        "Return (without printing) the string that printf would have printed out with the same arguments",
        "Print a number in floating-point notation",
        "The minus sign, used before the width modifier");
  }

  public void testGawkFunctionStrftime() {
    doTest(
        "function a() { return strf<caret>time() }",
        "strftime([format [, timestamp [, utc-flag] ] ])",
        "Gawk-only!",
        "Format the time specified by timestamp based on the contents of the format string",
        "The minute as a decimal number (00–59)");
  }

  public void testAwkVarFS() {
    doTest("BEGIN { FS<caret>=\":\" }", "FS", "The input field separator");
  }

  public void testGawkVarBINMODE() {
    doTest(
        "BEGIN { BIN<caret>MODE=1 }",
        "BINMODE",
        "this variable specifies use of binary mode",
        "Gawk-only!");
  }

  public void testGawkVarPROCINFO() {
    doTest(
        "BEGIN { print <caret>PROCINFO[\"\"] }",
        "information about the running awk program",
        "PROCINFO[\"argv\"]",
        "PROCINFO[\"sorted_in\"]");
  }

  public void testGlobalVar1() {
    doTest("BEGIN {\nVar = 1  # doc_string\n}\n{ print Va<caret>r }", "Var = 1", "doc_string");
  }

  public void testGlobalVar2() {
    doTest(
        "BEGIN {\ndelete Var #   doc_string\n}\n{ print Va<caret>r[0] }",
        "delete Var",
        "doc_string");
  }

  public void testGlobalVar3() {
    doTest(
        "BEGIN {\nsplit(\"\",Var) \t  #  \t doc string \t \n}\n{ print Var<caret>[0] }",
        "split(\"\",Var)",
        "doc string");
  }

  public void testGlobalVar4() {
    doTest(
        "BEGIN {\nVar[\"a\"] # doc string\nVar[\"b\"]}\n{ print <caret>Var[\"b\"] }",
        "Var[\"a\"]",
        "doc string");
  }

  public void testGlobalVar5() {
    doTest(
        "BEGIN {\nVar[\"a\"] = 1 # doc string\n}\n{ print <caret>Var[\"b\"] }",
        "Var[\"a\"] = 1",
        "doc string");
  }

  public void testGlobalVar6() {
    doTest("BEGIN {\nVar = 1\n}\n{ print Va<caret>r }", "Var = 1");
  }

  public void testGlobalVarNoDoc1() {
    doTest("Var<caret> {}");
  }

  public void testFunc1() {
    doTest("BEGIN { a<caret>(1,2) } function a(b,c,   d){}", "function a(b, c)");
  }

  public void testFunc2() {
    doTest("function a(b,c,    d,e) {return 7}\nEND{ print <caret>a() }", "function a(b, c)");
  }

  public void testFunc3() {
    doTest("function a(b,c,    d,e) {\nprint\n}\n<caret>a(7) { exit 7 }", "function a(b, c)");
  }

  // testing func comments
  private void testFuncComment(String code, String... docString) {
    String doc = doTest(code, docString);
    // make sure we strip all leading '#'
    assertFalse(doc, doc.contains("#"));
    // make sure we handle newlines properly
    assertFalse(doc, doc.contains("\n\n\n"));
  }

  public void testFunc4() {
    testFuncComment("# doc string\nfunction f(){}\nBEGIN { f<caret>() }", "doc string");
  }

  public void testFunc4_2() {
    testFuncComment("\n\n\n# doc string\nfunction f(){}\nBEGIN { f<caret>() }", "doc string");
  }

  public void testFunc4_1() {
    doTest("# doc string\n\nfunction f(){}\nBEGIN { f<caret>() }");
  }

  public void testFunc5() {
    testFuncComment(
        "# doc string\n# doc string2\nfunction f(){}\nBEGIN { f<caret>() }",
        "doc string",
        "doc string2");
  }
  public void testFunc6() {
    testFuncComment(
        "#\n# doc string\n### doc string2\n#\nfunction f(){}\nBEGIN { f<caret>() }",
        "doc string",
        "doc string2");
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
    doTest(code, "The exit statement causes awk to immediately stop executing");
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
        "printf",
        "Print a number in floating-point notation",
        "The minus sign, used before the width modifier");
  }

  private void testStmtGetline(String code) {
    doTest(code, "getline", "returns 1", "Effect");
  }

  public final Consumer<String> awkVariableChecker =
      (varName) -> {
        List<String> check = new ArrayList<>(2);
        check.add(varName);
        if (AwkVariables.gawkVariables.contains(varName)) {
          check.add("Gawk-only!");
        }
        doTest("{ print " + varName + "<caret> }", check.toArray(new String[0]));
      };

  public void testAllVariablesDocsPresent() {
    AwkVariables.builtInVariables.forEach(awkVariableChecker);
    AwkVariables.gawkVariables.forEach(awkVariableChecker);
  }

  public final BiConsumer<String, String> awkFunctionChecker =
      (funcName, funcSig) -> {
        List<String> check = new ArrayList<>(2);
        check.add(funcName + funcSig);
        if (AwkFunctions.gawkFunctions.containsKey(funcName)) {
          check.add("Gawk-only!");
        }
        doTest("{ print " + funcName + "<caret>(); }", check.toArray(new String[0]));
      };

  public void testAllFunctionsDocsPresent() {
    AwkFunctions.builtInFunctions.forEach(awkFunctionChecker);
    AwkFunctions.gawkFunctions.forEach(awkFunctionChecker);
  }

  private String doTest(String code, String... docStringMustContain) {
    myFixture.configureByText("a.awk", code);
    PsiElement docElement =
        DocumentationManager.getInstance(getProject())
            .findTargetElement(myFixture.getEditor(), myFixture.getFile());

    DocumentationProvider provider = DocumentationManager.getProviderFromElement(docElement);

    String docString = provider.generateDoc(docElement, getOriginalElement());
    assertTrue(
        "Incorrect doc detected\n--- Expected to match all:\n"
            + String.join("|", docStringMustContain)
            + "\n--- Actual:\n"
            + docString,
        docStringMustContain.length == 0
            ? docString == null
            : Arrays.stream(docStringMustContain).allMatch(removeTags(docString)::contains));
    return docString;
  }

  private String removeTags(String docString) {
    return Jsoup.parse(docString).text();
  }

  private PsiElement getOriginalElement() {
    return myFixture.getFile().findElementAt(myFixture.getEditor().getCaretModel().getOffset());
  }
}
