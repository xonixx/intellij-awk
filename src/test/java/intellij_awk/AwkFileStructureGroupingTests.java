package intellij_awk;

import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import com.intellij.usageView.UsageInfo;
import com.intellij.usages.UsageGroup;
import com.intellij.usages.UsageInfo2UsageAdapter;
import com.intellij.usages.UsageTarget;
import com.intellij.usages.impl.FileStructureGroupRuleProvider;
import com.intellij.usages.rules.UsageGroupingRule;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.Assert.assertNotEquals;

public class AwkFileStructureGroupingTests extends BasePlatformTestCase {
  public void testGroupsUsagesByFunctionAndBeginEndBlock() {
    myFixture.configureByText(
        "a.awk",
        "function tar<caret>get() {}\n"
            + "BEGIN { target() }\n"
            + "function alpha() { target(); target() }\n"
            + "function beta() { target() }\n"
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

    assertEquals(Integer.valueOf(2), groupCounts.get("alpha()"));
    assertEquals(Integer.valueOf(1), groupCounts.get("beta()"));
    assertEquals(Integer.valueOf(2), groupCounts.get("BEGIN"));
    assertEquals(Integer.valueOf(1), groupCounts.get("END"));
    assertEquals(Integer.valueOf(1), groupCounts.get("<file>"));
    assertEquals(5, groupCounts.size());
    assertEquals(2, beginGroups.size());
    assertNotEquals(beginGroups.get(0), beginGroups.get(1));
    assertTrue(beginGroups.get(0).compareTo(beginGroups.get(1)) != 0);
  }
}
