package intellij_awk;

import java.util.Set;

public class AwkVariables {
  static final Set<String> builtInVariables =
      Set.of(
          "ARGC",
          "ARGV",
          "CONVFMT",
          "ENVIRON",
          "FILENAME",
          "FNR",
          "FS",
          "NF",
          "NR",
          "OFMT",
          "OFS",
          "ORS",
          "RLENGTH",
          "RS",
          "RSTART",
          "SUBSEP");
  static final Set<String> gawkVariables =
      Set.of(
          "BINMODE",
          "FIELDWIDTHS",
          "FPAT",
          "IGNORECASE",
          "LINT",
          "PREC",
          "ROUNDMODE",
          "TEXTDOMAIN",
          "ARGIND",
          "ERRNO",
          "FUNCTAB",
          "PROCINFO",
          "RT",
          "SYMTAB");
}
