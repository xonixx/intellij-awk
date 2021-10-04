package intellij_awk;

import com.intellij.codeInsight.daemon.impl.HighlightInfo;
import com.intellij.codeInsight.intention.IntentionAction;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;

import java.util.List;

public class AwkInspectionTests extends BasePlatformTestCase {

  public void testTest1() {
    checkByFile();
  }

  @Override
  protected String getTestDataPath() {
    return "src/test/testData/inspection";
  }

  private void checkByFile() {
    String before = getTestName(true) + ".awk";
    String after = before.replace(".awk", "After.awk");
    myFixture.configureByFile(before);

    myFixture.enableInspections(new AwkInspectionUnusedFunctionParams());
    List<HighlightInfo> highlightInfos = myFixture.doHighlighting();
    assertFalse(highlightInfos.isEmpty());
    // Get the quick fix action for comparing references inspection and apply it to the file
    final IntentionAction action =
        myFixture.findSingleIntention(AwkInspectionUnusedFunctionParams.QUICK_FIX_NAME);
    assertNotNull(action);
    myFixture.launchAction(action);

    myFixture.checkResultByFile(after, true);
  }
}
