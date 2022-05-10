package intellij_awk;

import com.intellij.testFramework.UsefulTestCase;

public class UtilTests extends UsefulTestCase {
  public void testLowerUnderscoreToCamelCase() {
    assertNull(Util.lowerUnderscoreToCamelCase(null));
    assertEquals("", Util.lowerUnderscoreToCamelCase(""));
    assertEquals("Aaa", Util.lowerUnderscoreToCamelCase("aaa"));
    assertEquals("CamelCase", Util.lowerUnderscoreToCamelCase("camel_case"));
    assertEquals("CamelCase", Util.lowerUnderscoreToCamelCase("camel_Case"));
    assertEquals("CamelCase", Util.lowerUnderscoreToCamelCase("camel__case"));
  }
}
