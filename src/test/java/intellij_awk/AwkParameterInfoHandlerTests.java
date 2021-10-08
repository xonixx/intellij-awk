package intellij_awk;

import com.intellij.psi.PsiElement;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import com.intellij.testFramework.utils.parameterInfo.MockCreateParameterInfoContext;
import com.intellij.testFramework.utils.parameterInfo.MockParameterInfoUIContext;
import com.intellij.testFramework.utils.parameterInfo.MockUpdateParameterInfoContext;

public class AwkParameterInfoHandlerTests extends BasePlatformTestCase {

  public void test1() {
    checkByText("{ f(1<caret>, 2) } function f(a, bbb,  ccc ) {}", "a, bbb, ccc", 0);
  }

  public void test2() {
    checkByText("{ f(1, 2<caret>) } function f(a, bbb,  ccc,   i,j,k) {}", "a, bbb, ccc", 1);
  }

  public void test2_1() {
    checkByText("{ f(1, 2<caret>) } function f(a, bbb,  ccc,\\\ni,j,k) {}", "a, bbb, ccc", 1);
  }

  public void test3() {
    checkByText("BEGIN { f(1,   \"2<caret>\"  ) } function f() {}", "<no parameters>", 1);
  }

  public void test4() {
    checkByText("{ f<caret>(1, 2) } function f(    i,j,k) {}", "<no parameters>", -1);
  }

  public void test4_1() {
    checkByText("{ f(1<caret>, 2) } function f(\\\ni,j,k) {}", "<no parameters>", 0);
  }

  public void test5() {
    checkByText("{ f(<caret>) } function f(x,y) {}", "x, y", 0);
  }

  public void test6() {
    checkByTextShouldNotShowParamsHint("{ unknownFunc(<caret>) }");
  }

  private void checkByTextShouldNotShowParamsHint(String code) {
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
    if (items != null && items.length > 0) {
      fail("Parameters are shown");
    }
  }

  private void checkByText(String code, String hint, int index) {
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
    if (items == null || items.length == 0) {
      fail("Parameters are not shown");
    }
    assertEquals(1, items.length);
    var context = new MockParameterInfoUIContext<PsiElement>(el);
    handler.updateUI((AwkParameterInfoHandler.AwkParameterInfo) items[0], context);
    assertEquals(hint, context.getText());

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
