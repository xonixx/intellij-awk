package intellij_awk;

import com.intellij.openapi.project.DumbAware;
import com.intellij.openapi.project.Project;
import com.intellij.psi.NavigatablePsiElement;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiFile;
import com.intellij.psi.util.PsiTreeUtil;
import com.intellij.usages.PsiElementUsageGroupBase;
import com.intellij.usages.Usage;
import com.intellij.usages.UsageGroup;
import com.intellij.usages.UsageInfo2UsageAdapter;
import com.intellij.usages.UsageTarget;
import com.intellij.usages.UsageView;
import com.intellij.usages.impl.FileStructureGroupRuleProvider;
import com.intellij.usages.rules.PsiElementUsage;
import com.intellij.usages.rules.SingleParentUsageGroupingRule;
import intellij_awk.psi.AwkBeginOrEnd;
import intellij_awk.psi.AwkFile;
import intellij_awk.psi.AwkFunctionNameMixin;
import intellij_awk.psi.AwkItem;
import intellij_awk.psi.AwkPattern;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public class AwkFileStructureGroupRuleProvider implements FileStructureGroupRuleProvider {
  @Override
  public @NotNull SingleParentUsageGroupingRule getUsageGroupingRule(@NotNull Project project) {
    return new AwkFileStructureGroupingRule();
  }

  private static class AwkFileStructureGroupingRule extends SingleParentUsageGroupingRule
      implements DumbAware {
    @Override
    protected @Nullable UsageGroup getParentGroupFor(
        @NotNull Usage usage, UsageTarget @NotNull [] targets) {
      if (!(usage instanceof PsiElementUsage)) return null;

      PsiElement element = ((PsiElementUsage) usage).getElement();
      if (element == null || !element.isValid()) return null;
      PsiFile file = element.getContainingFile();
      if (!(file instanceof AwkFile)) return null;

      PsiElement position = element;
      if (usage instanceof UsageInfo2UsageAdapter) {
        int offset = ((UsageInfo2UsageAdapter) usage).getUsageInfo().getNavigationOffset();
        if (offset >= 0 && offset < file.getTextLength()) {
          PsiElement atOffset = file.findElementAt(offset);
          if (atOffset != null) position = atOffset;
        }
      }

      AwkItem item = PsiTreeUtil.getParentOfType(position, AwkItem.class, false);
      if (item == null) return null;

      PsiElement owner = item.getFunctionName();
      if (owner == null) {
        AwkPattern pattern = item.getPattern();
        AwkBeginOrEnd beginOrEnd = pattern == null ? null : pattern.getBeginOrEnd();
        owner = beginOrEnd;
      }
      return owner instanceof NavigatablePsiElement
          ? new AwkStructureUsageGroup((NavigatablePsiElement) owner)
          : null;
    }
  }

  private static class AwkStructureUsageGroup
      extends PsiElementUsageGroupBase<NavigatablePsiElement> {
    private AwkStructureUsageGroup(@NotNull NavigatablePsiElement element) {
      super(element);
    }

    @Override
    public @NotNull String getText(UsageView view) {
      NavigatablePsiElement element = getElement();
      if (element instanceof AwkFunctionNameMixin) {
        AwkFunctionNameMixin function = (AwkFunctionNameMixin) element;
        return function.getName() + function.getSignatureString();
      }
      return super.getText(view);
    }

    @Override
    public int compareTo(@NotNull UsageGroup other) {
      int byName = super.compareTo(other);
      if (byName != 0 || !(other instanceof AwkStructureUsageGroup)) return byName;

      NavigatablePsiElement element = getElement();
      NavigatablePsiElement otherElement = ((AwkStructureUsageGroup) other).getElement();
      return element == null || otherElement == null
          ? 0
          : Integer.compare(element.getTextOffset(), otherElement.getTextOffset());
    }
  }
}
