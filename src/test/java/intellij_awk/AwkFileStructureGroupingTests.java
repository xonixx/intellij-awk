package intellij_awk;

import com.intellij.openapi.extensions.LoadingOrder;
import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import com.intellij.usageView.UsageInfo;
import com.intellij.usages.UsageGroup;
import com.intellij.usages.UsageInfo2UsageAdapter;
import com.intellij.usages.UsageTarget;
import com.intellij.usages.UsageViewSettings;
import com.intellij.usages.impl.FileStructureGroupRuleProvider;
import com.intellij.usages.impl.rules.FileGroupingRule;
import com.intellij.usages.rules.UsageGroupingRule;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.Assert.assertNotEquals;

public class AwkFileStructureGroupingTests extends BasePlatformTestCase {
  /**
   * This test makes sure we display file.awk -> functionName() in the find usages popup, not the
   * opposite order.
   */
  public void testFileGroupPrecedesFunctionGroupWhenFileProviderIsRegisteredLater() {
    myFixture.configureByText(
        "a.awk", "function tar<caret>get() {}\nfunction alpha() { target() }\n");
    UsageInfo usageInfo = myFixture.findUsages(myFixture.getElementAtCaret()).iterator().next();
    UsageInfo2UsageAdapter usage = new UsageInfo2UsageAdapter(usageInfo);

    FileStructureGroupRuleProvider laterFileProvider = FileGroupingRule::new;
    FileStructureGroupRuleProvider.EP_NAME
        .getPoint()
        .registerExtension(laterFileProvider, LoadingOrder.ANY, getTestRootDisposable());

    List<UsageGroupingRule> rules = new ArrayList<>();
    UsageViewSettings settings = new UsageViewSettings();
    for (FileStructureGroupRuleProvider provider :
        FileStructureGroupRuleProvider.EP_NAME.getExtensionList()) {
      UsageGroupingRule rule = provider.getUsageGroupingRule(getProject(), settings);
      if (rule != null) rules.add(rule);
    }
    rules.sort(Comparator.comparingInt(UsageGroupingRule::getRank));
    List<String> groups = new ArrayList<>();
    for (UsageGroupingRule rule : rules) {
      for (UsageGroup group : rule.getParentGroupsFor(usage, UsageTarget.EMPTY_ARRAY)) {
        groups.add(group.getText(null));
      }
    }
    assertEquals(2, groups.stream().filter("a.awk"::equals).count());
    assertTrue(groups.indexOf("alpha()") > groups.lastIndexOf("a.awk"));
  }

  public void testGroupsUsagesByFunctionAndBeginEndBlock() {
    myFixture.configureByText(
        "a.awk",
        "function tar<caret>get() {}\n"
            + "BEGIN { target() }\n"
            + "function alpha(arg1, arg2,    local1, local2) { target(); target() }\n"
            + "function beta(    local) { target() }\n"
            + "BEGIN { target() }\n"
            + "END { target() }\n"
            + "{ target() }\n");

    FileStructureGroupRuleProvider provider =
        FileStructureGroupRuleProvider.EP_NAME.getExtensionList().stream()
            .filter(extension -> extension instanceof AwkFileStructureGroupRuleProvider)
            .findFirst()
            .orElseThrow(() -> new AssertionError("AWK file structure grouping is not registered"));

    UsageGroupingRule rule = provider.getUsageGroupingRule(getProject());
    Collection<UsageInfo> usages = myFixture.findUsages(myFixture.getElementAtCaret());
    assertEquals(7, usages.size());

    Map<String, Integer> groupCounts = new HashMap<>();
    List<UsageGroup> beginGroups = new ArrayList<>();
    for (UsageInfo usageInfo : usages) {
      List<UsageGroup> groups =
          rule.getParentGroupsFor(new UsageInfo2UsageAdapter(usageInfo), UsageTarget.EMPTY_ARRAY);
      assertTrue(groups.size() <= 1);
      String name = groups.isEmpty() ? "<file>" : groups.get(0).getText(null);
      groupCounts.merge(name, 1, Integer::sum);
      if (name.equals("BEGIN")) beginGroups.add(groups.get(0));
    }

    assertEquals(Integer.valueOf(2), groupCounts.get("alpha(arg1, arg2)"));
    assertEquals(Integer.valueOf(1), groupCounts.get("beta()"));
    assertEquals(Integer.valueOf(2), groupCounts.get("BEGIN"));
    assertEquals(Integer.valueOf(1), groupCounts.get("END"));
    assertEquals(Integer.valueOf(1), groupCounts.get("<file>"));
    assertEquals(5, groupCounts.size());
    assertEquals(2, beginGroups.size());
    assertNotEquals(beginGroups.get(0), beginGroups.get(1));
  }
}
