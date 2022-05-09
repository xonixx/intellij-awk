package intellij_awk.psi;

public interface AwkUserVarNameDeclaration {
  boolean looksLikeDeclaration();

  boolean isInsideInitializingContext();

  default boolean isDeclaration() {
    return looksLikeDeclaration() && isInsideInitializingContext();
  }
}
