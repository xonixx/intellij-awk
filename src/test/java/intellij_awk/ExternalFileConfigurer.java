package intellij_awk;

import com.intellij.openapi.vfs.VirtualFile;
import com.intellij.testFramework.fixtures.CodeInsightTestFixture;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

/*
See https://intellij-support.jetbrains.com/hc/en-us/community/posts/10752685429394-How-can-I-create-a-unit-test-for-my-language-support-plugin-to-emulate-opening-a-file-from-outside-of-the-project-?page=1
 */
public class ExternalFileConfigurer {
  private final CodeInsightTestFixture myFixture;

  public ExternalFileConfigurer(CodeInsightTestFixture myFixture) {
    this.myFixture = myFixture;
  }

  public void configureByExternalFile(Path path) {
    String fileName = path.toFile().getName();
    String code;
    try {
      code = Files.readString(path);
    } catch (IOException e) {
      throw new RuntimeException(e);
    }
    configureByText(fileName, code);
  }

  public void configureByText(String fileName, String code) {
    VirtualFile file;
    try {
      // We can't just configure by virtual file in place, because test run will overwrite test file
      // by removing the <caret>.
      // So we create temp file but with path "temp://src/../testName" which appears to be out of
      // the project dir "temp://src".
      file = myFixture.getTempDirFixture().createFile("../" + fileName, code);
    } catch (IOException e) {
      throw new RuntimeException(e);
    }
    myFixture.configureFromExistingVirtualFile(file);
  }
}
