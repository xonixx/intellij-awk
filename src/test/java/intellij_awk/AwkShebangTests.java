package intellij_awk;

import com.intellij.testFramework.fixtures.BasePlatformTestCase;
import intellij_awk.psi.AwkFile;

public class AwkShebangTests extends BasePlatformTestCase {

  public void testAwkShebang() {
    assertTrue(isAwk("#!/usr/bin/awk -f\nBEGIN {}"));
  }

  public void testGawkShebang() {
    assertTrue(isAwk("#! /usr/local/bin/gawk -f\nBEGIN {}"));
  }

  public void testNotAwk1() {
    assertFalse(isAwk("#!/bin/sh\necho 1"));
  }

  public void testNotAwk2() {
    assertFalse(isAwk("hello world"));
  }

  private boolean isAwk(String code) {
    return myFixture.configureByText("file_name_without_extension", code) instanceof AwkFile;
  }
}
