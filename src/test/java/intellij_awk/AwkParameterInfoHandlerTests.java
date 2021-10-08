package intellij_awk;

import com.intellij.psi.PsiElement;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import com.intellij.testFramework.utils.parameterInfo.MockCreateParameterInfoContext;
import com.intellij.testFramework.utils.parameterInfo.MockParameterInfoUIContext;
import com.intellij.testFramework.utils.parameterInfo.MockUpdateParameterInfoContext;

public class AwkParameterInfoHandlerTests extends BasePlatformTestCase {

  public void test1() {
    checkByText("{ f(1<caret>, 2) } function f(a, bbb,  ccc ) {}", 0, "a, bbb, ccc");
  }

  public void test2() {
    checkByText("{ f(1, 2<caret>) } function f(a, bbb,  ccc,   i,j,k) {}", 1, "a, bbb, ccc");
  }

  public void test2_1() {
    checkByText("{ f(1, 2<caret>) } function f(a, bbb,  ccc,\\\ni,j,k) {}", 1, "a, bbb, ccc");
  }

  public void test3() {
    checkByText("BEGIN { f(1,   \"2<caret>\"  ) } function f() {}", 1, "<no parameters>");
  }

  public void test4() {
    checkByText("{ f<caret>(1, 2) } function f(    i,j,k) {}", -1, "<no parameters>");
  }

  public void test4_1() {
    checkByText("{ f(1<caret>, 2) } function f(\\\ni,j,k) {}", 0, "<no parameters>");
  }

  public void test5() {
    checkByText("{ f(<caret>) } function f(x,y) {}", 0, "x, y");
  }

  public void test6() {
    checkByTextShouldNotShowParamsHint("{ unknownFunc(<caret>) }");
  }

  public void testBuiltIn1() {
    checkByText("{ index(\"abc\"<caret>, \"b\") }", 0, "in, find");
  }

  public void testBuiltIn2() {
    checkByText(
        "{ sub(/aaa/<caret>, \"<caret>BBB\") }",
        1,
        "regexp, replacement",
        "regexp, replacement, target");
  }

  private void checkByTextShouldNotShowParamsHint(String code) {
    checkByText(code, -100);
  }

  private void checkByText(String code, int index, String... hints) {
    myFixture.configureByText("a.awk", code);
    AwkParameterInfoHandler handler = new AwkParameterInfoHandler();
    var createContext =
        new MockCreateParameterInfoContext(myFixture.getEditor(), myFixture.getFile());

    var el = handler.findElementForParameterInfo(createContext);
    if (el == null) {
      fail("Hint not found");
    }
    handler.showParameterInfo(el, createContext);
    var items = createContext.getItemsToShow();

    if (hints.length == 0) {
      if (items != null && items.length > 0) {
        fail("Parameters are shown");
      }
      return;
    }

    if (items == null || items.length == 0) {
      fail("Parameters are not shown");
    }
    
    assertEquals(hints.length, items.length);

    for (int i = 0; i < hints.length; i++) {
      var context = new MockParameterInfoUIContext<PsiElement>(el);
      handler.updateUI((AwkParameterInfoHandler.AwkParameterInfo) items[i], context);
      assertEquals(hints[i], context.getText());
    }

    var updateContext =
        new MockUpdateParameterInfoContext(myFixture.getEditor(), myFixture.getFile());
    var element = handler.findElementForUpdatingParameterInfo(updateContext);
    if (element == null) {
      fail("Parameter not found");
    }
    updateContext.setParameterOwner(element);
    handler.updateParameterInfo(element, updateContext);
    assertEquals(index, updateContext.getCurrentParameter());
  }
}
