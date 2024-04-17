package intellij_awk.psi;

import junit.framework.TestCase;
import org.junit.Assert;

public class AwkStringMixinTests extends TestCase {
  public void testTrue() {
    Assert.assertTrue(AwkStringMixin.canBeFunctionName("\"aaa\""));
    Assert.assertTrue(AwkStringMixin.canBeFunctionName("\"_aaa01\""));
    Assert.assertTrue(AwkStringMixin.canBeFunctionName("\"Xxx123\""));
    Assert.assertTrue(AwkStringMixin.canBeFunctionName("\"_\""));
    Assert.assertTrue(AwkStringMixin.canBeFunctionName("\"X\""));
  }
  public void testFalse() {
    Assert.assertFalse(AwkStringMixin.canBeFunctionName(" \"aaa\" "));
    Assert.assertFalse(AwkStringMixin.canBeFunctionName("\"111\""));
    Assert.assertFalse(AwkStringMixin.canBeFunctionName("\"1aaa\""));
    Assert.assertFalse(AwkStringMixin.canBeFunctionName("\"_aa a01\""));
    Assert.assertFalse(AwkStringMixin.canBeFunctionName("\"Xxx'123\""));
    Assert.assertFalse(AwkStringMixin.canBeFunctionName("\"-\""));
    Assert.assertFalse(AwkStringMixin.canBeFunctionName("\"aaaa\\\"bbb\""));
  }
}
