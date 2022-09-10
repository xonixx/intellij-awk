package intellij_awk;

import com.intellij.patterns.PsiElementPattern;
import com.intellij.psi.PsiElement;
import intellij_awk.psi.AwkTypes;
import org.jetbrains.annotations.NotNull;

import static com.intellij.patterns.PlatformPatterns.psiElement;

public class AwkCompletionPatterns {
    static final PsiElementPattern.@NotNull Capture<PsiElement> INSIDE_STRING =
        psiElement(AwkTypes.STRING);
}
