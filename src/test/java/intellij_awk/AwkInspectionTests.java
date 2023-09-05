package intellij_awk;

import com.intellij.codeInsight.daemon.impl.HighlightInfo;
import com.intellij.codeInsight.intention.IntentionAction;
import com.intellij.codeInspection.LocalInspectionTool;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import java.nio.file.Path;
import java.util.List;
import java.util.Optional;
import org.jetbrains.annotations.NotNull;

public class AwkInspectionTests extends BasePlatformTestCase {

  private final Inspection unusedFunctionParam =
      new Inspection(
          new AwkInspectionUnusedFunctionParam(), AwkInspectionUnusedFunctionParam.QUICK_FIX_NAME);

  private final Inspection unusedFunction =
      new Inspection(new AwkInspectionUnusedFunction(), AwkInspectionUnusedFunction.QUICK_FIX_NAME);

  private final Inspection unusedGlobalVariable =
      new Inspection(
          new AwkInspectionUnusedGlobalVariable(),
          AwkInspectionUnusedGlobalVariable.QUICK_FIX_NAME);

  private final Inspection unresolvedFunctionCall =
      new Inspection(
          new AwkInspectionUnresolvedFunction(), AwkInspectionUnresolvedFunction.QUICK_FIX_NAME);
  private final Inspection unresolvedInclude =
      new Inspection(new AwkInspectionUnresolvedInclude(), null);

  private final Inspection duplicateFunction =
      new Inspection(new AwkInspectionDuplicateFunction(), null);
  private final Inspection duplicateFunctionParam =
      new Inspection(new AwkInspectionDuplicateFunctionParam(), null);

  private final Inspection declareLocal =
      new Inspection(
          new AwkInspectionDeclareLocalVariable(),
          AwkInspectionDeclareLocalVariable.QUICK_FIX_NAME);

  private final Inspection enforceGlobalVarNaming =
      new Inspection(
          new AwkInspectionEnforceGlobalVariableNaming(),
          AwkInspectionEnforceGlobalVariableNaming.QUICK_FIX_NAME);

  private final Inspection unnecessarySemicolon =
      new Inspection(
          new AwkInspectionUnnecessarySemicolon(),
          AwkInspectionUnnecessarySemicolon.QUICK_FIX_NAME);

  public void testDuplicateFunctionParam1() {
    checkByFile(duplicateFunctionParam);
  }

  public void testDuplicateFunctionParam2() {
    checkByFile(duplicateFunctionParam);
  }

  public void testUnusedFunctionParam1() {
    checkByFile(unusedFunctionParam);
  }

  public void testUnusedFunctionParam2_0() {
    checkByFile(unusedFunctionParam);
  }

  public void testUnusedFunctionParam2_1() {
    checkByFile(unusedFunctionParam);
  }

  public void testUnusedFunctionParam3_0() {
    checkByFile(unusedFunctionParam);
  }

  public void testUnusedFunctionParam3_1() {
    checkByFile(unusedFunctionParam);
  }

  public void testUnusedFunctionParam4() {
    checkByFile(unusedFunctionParam);
  }

  public void testUnusedFunctionParamNoProblem1() {
    checkByFileNoProblemAtCaret(unusedFunctionParam);
  }

  public void testUnusedFunction1() {
    checkByFile(unusedFunction);
  }

  public void testUnusedFunction2Recursive() {
    checkByFile(unusedFunction);
  }

  public void testUsedFunctionInFileOutsideProject() {
    checkByFileNoProblemAtCaret(unusedFunction, true);
  }

  public void testIssue203NoUnusedFunctionErrForUsageInOtherFile() {
    myFixture.configureByText("a.awk", "function <caret>f(){}");
    myFixture.addFileToProject("c.awk", "BEGIN { f() } ");
    assertNoInspectionAtCaret(unusedFunction);
  }
  public void testIssue203NoUnusedFunctionErrForRepeatingDefinitionInSeparateFiles() {
    myFixture.configureByText("a.awk", "function <caret>f(){}");
    myFixture.addFileToProject("b.awk", "function f() {}");
    myFixture.addFileToProject("c.awk", "BEGIN { f() } ");
    assertNoInspectionAtCaret(unusedFunction);
  }

  public void testIssue203UnusedFunctionErrForRepeatingDefinitionWhenFunctionIsUsedInSameFileAsDefined() {
    myFixture.configureByText("a.awk", "function <caret>f(){}");
    myFixture.addFileToProject("c.awk", "BEGIN { f() } function f() {}");
    assertInspectionIsShown(unusedFunction);
  }


  public void testUsedVarInFileOutsideProject() {
    checkByFileNoProblemAtCaret(unusedGlobalVariable, true);
  }

  public void testUnusedGlobalVar1_0() {
    checkByFile(unusedGlobalVariable);
  }

  public void testUnusedGlobalVar1_1() {
    checkByFile(unusedGlobalVariable);
  }

  public void testUnusedGlobalVar2_0() {
    checkByFile(unusedGlobalVariable);
  }

  public void testUnusedGlobalVar2_1() {
    checkByFile(unusedGlobalVariable);
  }

  public void testUnusedGlobalVar2_2() {
    checkByFile(unusedGlobalVariable);
  }

  public void testUnusedGlobalVar3() {
    checkByFile(unusedGlobalVariable);
  }

  public void testUnusedGlobalVar4() {
    checkByFile(unusedGlobalVariable);
  }

  public void testUnusedGlobalVarNoProblem1() {
    checkByFileNoProblemAtCaret(unusedGlobalVariable);
  }

  public void testUnusedGlobalVarNoProblem2() {
    checkByFileNoProblemAtCaret(unusedGlobalVariable);
  }

  public void testUnusedGlobalVarNoProblem3() {
    checkByFileNoProblemAtCaret(unusedGlobalVariable);
  }

  public void testUnusedGlobalVarNoProblem4() {
    checkByFileNoProblemAtCaret(unusedGlobalVariable);
  }

  public void testUnusedGlobalVarNoProblem5() {
    checkByFileNoProblemAtCaret(unusedGlobalVariable);
  }

  public void testUnusedGlobalVarNoProblem6() {
    checkByFileNoProblemAtCaret(unusedGlobalVariable);
  }

  public void testDeclareLocal1_0() {
    checkByFile(declareLocal);
  }

  public void testDeclareLocal1_1() {
    // checks that we only report on first same variable occurrence
    checkByFileNoProblemAtCaret(declareLocal);
  }

  public void testDeclareLocal2_0() {
    checkByFile(declareLocal);
  }

  public void testDeclareLocal2_1() {
    checkByFile(declareLocal);
  }

  public void testDeclareLocal2_2() {
    checkByFile(declareLocal);
  }

  public void testDeclareLocal2_3() {
    checkByFile(declareLocal);
  }

  public void testDeclareLocal2_4() {
    checkByFile(declareLocal);
  }

  public void testDeclareLocalNoProblem1() {
    checkByFileNoProblemAtCaret(declareLocal);
  }

  public void testDeclareLocalNoProblem2() {
    checkByFileNoProblemAtCaret(declareLocal);
  }

  public void testDupFunctionsNotReportedUnused() {
    // dup functions should not imply unused
    checkByFileNoProblemAtCaret(unusedFunction);
  }

  private static final HighlightInfoChecker correctDupFunctionErrorText =
      (highlightInfo, file) -> highlightInfo.getDescription().endsWith(file);

  public void testDupFunctions1() {
    checkByFile(duplicateFunction, correctDupFunctionErrorText);
  }

  public void testDupFunctions2() {
    checkByFile(duplicateFunction, correctDupFunctionErrorText);
  }

  public void testDupFunctionsRegression180() {
    checkByFile(duplicateFunction, correctDupFunctionErrorText);
  }

  public void testUnresolvedFunctionCall1() {
    checkByFile(unresolvedFunctionCall);
  }

  public void testUnresolvedFunctionCall2() {
    checkByFileNoProblemAtCaret(unresolvedFunctionCall);
  }

  public void testUnresolvedFunctionCall3() {
    checkByFileNoProblemAtCaret(unresolvedFunctionCall);
  }

  public void testUnresolvedFunctionCall4() {
    checkByFile(unresolvedFunctionCall);
  }

  public void testUnresolvedInclude1() {
    checkByFile(unresolvedInclude);
  }

  public void testUnresolvedIncludeNoProblem1() {
    myFixture.configureByText("resolved.awk", "");
    checkByFileNoProblemAtCaret(unresolvedInclude);
  }

  public void testUnresolvedIncludeNoProblem2() {
    myFixture.configureByText("resolved.awk", "");
    checkByFileNoProblemAtCaret(unresolvedInclude);
  }

  public void testEnforceGlobalVarNaming1() {
    checkByFile(enforceGlobalVarNaming);
  }

  public void testEnforceGlobalVarNaming2() {
    checkByFile(enforceGlobalVarNaming);
  }

  public void testEnforceGlobalVarNaming3() {
    checkByFile(enforceGlobalVarNaming);
  }

  public void testUnnecessarySemicolon1() {
    checkByFile(unnecessarySemicolon);
  }

  public void testUnnecessarySemicolon2() {
    checkByFile(unnecessarySemicolon);
  }

  public void testUnnecessarySemicolon3() {
    checkByFile(unnecessarySemicolon);
  }

  public void testUnnecessarySemicolonNecessary1() {
    checkByFileNoProblemAtCaret(unnecessarySemicolon);
  }

  public void testUnnecessarySemicolonNecessary2() {
    checkByFileNoProblemAtCaret(unnecessarySemicolon);
  }

  public void testUnnecessarySemicolonNecessary3() {
    checkByFileNoProblemAtCaret(unnecessarySemicolon);
  }

  public void testUnnecessarySemicolonNecessary4() {
    checkByFileNoProblemAtCaret(unnecessarySemicolon);
  }

  @Override
  protected String getTestDataPath() {
    return "src/test/testData/inspection";
  }

  private void checkByFileNoProblemAtCaret(Inspection inspection) {
    checkByFileNoProblemAtCaret(inspection, false);
  }

  private void checkByFileNoProblemAtCaret(Inspection inspection, boolean fileOutsideProject) {
    String testName = getTestName(true) + ".awk";
    if (fileOutsideProject) {
      new ExternalFileConfigurer(myFixture)
          .configureByExternalFile(Path.of(getTestDataPath(), testName));
    } else {
      myFixture.configureByFile(testName);
    }

    assertNoInspectionAtCaret(inspection);
  }

  private void assertNoInspectionAtCaret(Inspection inspection) {
    myFixture.enableInspections(inspection.inspection);

    List<HighlightInfo> highlightInfos = myFixture.doHighlighting();

    Optional<HighlightInfo> highlightInfoAtCaretOpt = getHighlightInfoAtCaret(highlightInfos);

    highlightInfoAtCaretOpt.ifPresent(
        highlightInfo -> fail("Should be no error, but was: " + highlightInfo.getDescription()));
  }

  @NotNull
  private Optional<HighlightInfo> getHighlightInfoAtCaret(List<HighlightInfo> highlightInfos) {
    int caretOffset = myFixture.getCaretOffset();

    return highlightInfos.stream()
        .filter(
            highlightInfo ->
                highlightInfo.startOffset <= caretOffset && highlightInfo.endOffset >= caretOffset)
        .findAny();
  }

  private void checkByFile(Inspection inspection, HighlightInfoChecker... highlightInfoCheckers) {
    String before = getTestName(true) + ".awk";
    myFixture.configureByFile(before);

    List<HighlightInfo> highlightInfos = assertInspectionIsShown(inspection);

    if (highlightInfoCheckers != null) {
      for (HighlightInfoChecker highlightInfoChecker : highlightInfoCheckers) {
        assertTrue(
            highlightInfoChecker.isValid(
                getHighlightInfoAtCaret(highlightInfos).orElseThrow(), before));
      }
    }

    if (inspection.quickFixName != null) {
      // Get the quick fix action for comparing references inspection and apply it to the file
      final IntentionAction action = myFixture.findSingleIntention(inspection.quickFixName);
      assertNotNull(action);
      myFixture.launchAction(action);

      String after = before.replace(".awk", "After.awk");
      myFixture.checkResultByFile(after, true);
    }
  }

  @NotNull
  private List<HighlightInfo> assertInspectionIsShown(Inspection inspection) {
    myFixture.enableInspections(inspection.inspection);
    List<HighlightInfo> highlightInfos = myFixture.doHighlighting();
    assertFalse(
        "Inspection '" + inspection.quickFixName + "' must show, but is absent",
        highlightInfos.isEmpty());
    return highlightInfos;
  }

  private static class Inspection {
    final LocalInspectionTool inspection;
    final String quickFixName;

    Inspection(LocalInspectionTool inspection, String quickFixName) {
      this.inspection = inspection;
      this.quickFixName = quickFixName;
    }
  }

  private interface HighlightInfoChecker {
    boolean isValid(HighlightInfo highlightInfo, String file);
  }
}
