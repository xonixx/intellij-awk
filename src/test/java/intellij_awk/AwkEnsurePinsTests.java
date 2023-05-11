package intellij_awk;

import com.intellij.psi.PsiFile;
import intellij_awk.psi.AwkFunctionName;

/**
 * These are parsing tests to ensure we still build (thanks to pins) a correct syntax tree in
 * presence of some parsing errors.
 */
public class AwkEnsurePinsTests extends ParsingTestCaseBase {

  public AwkEnsurePinsTests() {
    super("parser", "awk", new AwkParserDefinition());
  }

  public void test1() {
    checkByText("{ a(b,c,) }");
  }

  public void test2() {
    checkByText("function f(b,c,){}");
  }

  // XXX for some reason fixing below makes it terribly slow or hanging on profile5.awk
  /*
    public void test3() {
      checkByText("{ a[b,c,] }");
    }
  */

  private void checkByText(String code) {
    String code1 = code + "\nfunction f1(){}";
    PsiFile psiFile = parseFile("a.awk", code1);
    assertNotNull(
        "element matching predicate not found, this means PSI tree is broken",
        AwkUtil.findFirstMatchedDeep(
            psiFile,
            psiElement ->
                psiElement instanceof AwkFunctionName && "f1".equals(psiElement.getText())));
  }
}
