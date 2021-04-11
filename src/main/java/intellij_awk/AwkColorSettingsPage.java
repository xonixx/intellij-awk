package intellij_awk;

import com.intellij.openapi.editor.colors.TextAttributesKey;
import com.intellij.openapi.fileTypes.SyntaxHighlighter;
import com.intellij.openapi.options.colors.AttributesDescriptor;
import com.intellij.openapi.options.colors.ColorDescriptor;
import com.intellij.openapi.options.colors.ColorSettingsPage;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;
import java.util.Map;

public class AwkColorSettingsPage implements ColorSettingsPage {

  private static final AttributesDescriptor[] DESCRIPTORS =
      new AttributesDescriptor[] {
        new AttributesDescriptor("Keyword", AwkSyntaxHighlighter.KEYWORD),
        new AttributesDescriptor("String", AwkSyntaxHighlighter.STRING),
        new AttributesDescriptor("Number", AwkSyntaxHighlighter.NUMBER),
        new AttributesDescriptor("Comment", AwkSyntaxHighlighter.COMMENT),
        new AttributesDescriptor("Bad Character", AwkSyntaxHighlighter.BAD_CHARACTER),
        new AttributesDescriptor("Comma", AwkSyntaxHighlighter.COMMA),
        new AttributesDescriptor("Semicolon", AwkSyntaxHighlighter.SEMICOLON),
        new AttributesDescriptor("Operations", AwkSyntaxHighlighter.OPERATION_SIGN),
        new AttributesDescriptor("Braces", AwkSyntaxHighlighter.BRACES),
        new AttributesDescriptor("Brackets", AwkSyntaxHighlighter.BRACKETS),
        new AttributesDescriptor("Parentheses", AwkSyntaxHighlighter.PARENTHESES)
      };

  @Nullable
  @Override
  public Icon getIcon() {
    return AwkIcons.FILE;
  }

  @NotNull
  @Override
  public SyntaxHighlighter getHighlighter() {
    return new AwkSyntaxHighlighter();
  }

  @NotNull
  @Override
  public String getDemoText() {
    return "BEGIN {\n"
        + "    Trace=\"Trace\" in ENVIRON\n"
        + "    Number=1.23E-12\n"
        + "    @ # bad char\n"
        + "    split(\"\", GronAsm); GronAsmLen=0; split(\"\", LineNums)\n"
        + "\n"
        + "    while (getline > 0) {\n"
        + "        if ((Instr = trim($0))!=\"\") { GronAsm[GronAsmLen++] = Instr; LineNums[GronAsmLen] = NR }\n"
        + "    }\n"
        + "\n"
        + "    split(\"\", AddrType)  # addr -> type\n"
        + "    split(\"\", AddrKey)   # addr -> last segment name\n"
        + "\n"
        + "    for (i=0; i<GronAsmLen; i++) {\n"
        + "        Instr = GronAsm[i];\n"
        + "\n"
        + "        if (\"record\" == Instr) {\n"
        + "            split(\"\",Path)\n"
        + "            split(\"\",Value) # [ type, value ]\n"
        + "        }\n"
        + "        else if (isSegmentType(Instr)) { arrPush(Types, Instr); arrPush(Path, GronAsm[++i]) }\n"
        + "        else if (\"value\" == Instr) {\n"
        + "            Instr = GronAsm[++i];\n"
        + "            split(\"\",Value)\n"
        + "            Value[0] = Instr\n"
        + "            if (isValueHolder(Instr))\n"
        + "                Value[1] = GronAsm[++i]\n"
        + "        } else if (\"end\" == Instr) { processRecord() }\n"
        + "    }\n"
        + "    if (Trace) print \"--- JSON asm ---\"\n"
        + "    for (i=0; i<JsonAsmLen; i++)\n"
        + "        print JsonAsm[i]\n"
        + "}\n"
        + "\n"
        + "function isComplex(s) { return \"object\"==s || \"array\"==s }\n"
        + "function trim(s) { sub(/^[ \\t\\r\\n]+/, \"\", s); sub(/[ \\t\\r\\n]+$/, \"\", s); return s; }";
  }

  @Nullable
  @Override
  public Map<String, TextAttributesKey> getAdditionalHighlightingTagToDescriptorMap() {
    return null;
  }

  @NotNull
  @Override
  public AttributesDescriptor[] getAttributeDescriptors() {
    return DESCRIPTORS;
  }

  @NotNull
  @Override
  public ColorDescriptor[] getColorDescriptors() {
    return ColorDescriptor.EMPTY_ARRAY;
  }

  @NotNull
  @Override
  public String getDisplayName() {
    return "AWK";
  }
}
