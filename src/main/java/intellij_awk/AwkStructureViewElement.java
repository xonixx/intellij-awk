package intellij_awk;

import com.intellij.ide.projectView.PresentationData;
import com.intellij.ide.structureView.StructureViewTreeElement;
import com.intellij.ide.util.treeView.smartTree.SortableTreeElement;
import com.intellij.ide.util.treeView.smartTree.TreeElement;
import com.intellij.navigation.ItemPresentation;
import com.intellij.psi.NavigatablePsiElement;
import com.intellij.psi.util.PsiTreeUtil;
import intellij_awk.psi.AwkFile;
import intellij_awk.psi.AwkItem;
import intellij_awk.psi.impl.AwkItemImpl;
import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.List;

public class AwkStructureViewElement implements StructureViewTreeElement, SortableTreeElement {

  private final NavigatablePsiElement myElement;

  public AwkStructureViewElement(NavigatablePsiElement element) {
    this.myElement = element;
  }

  @Override
  public Object getValue() {
    return myElement;
  }

  @Override
  public void navigate(boolean requestFocus) {
    myElement.navigate(requestFocus);
  }

  @Override
  public boolean canNavigate() {
    return myElement.canNavigate();
  }

  @Override
  public boolean canNavigateToSource() {
    return myElement.canNavigateToSource();
  }

  @NotNull
  @Override
  public String getAlphaSortKey() {
    String name = myElement.getName();
    return name != null ? name : "";
  }

  @NotNull
  @Override
  public ItemPresentation getPresentation() {
    ItemPresentation presentation = myElement.getPresentation();
    return presentation != null ? presentation : new PresentationData();
  }

  @NotNull
  @Override
  public TreeElement[] getChildren() {
    if (myElement instanceof AwkFile) {
      List<AwkItem> awkItems = PsiTreeUtil.getChildrenOfTypeAsList(myElement, AwkItem.class);
      List<TreeElement> treeElements = new ArrayList<>(awkItems.size());
      for (AwkItem awkItem : awkItems) {
        if (awkItem.getNameIdentifier() != null) {
          treeElements.add(new AwkStructureViewElement((AwkItemImpl) awkItem));
        }
      }
      return treeElements.toArray(new TreeElement[0]);
    }
    return EMPTY_ARRAY;
  }
}
