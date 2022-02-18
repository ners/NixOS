{ lib, ... }:

with builtins;
with lib;
{
  # Splits the string by newlines into a list of strings
  lines = splitString "\n";

  # Merges a list of string by newline into a single multiline string
  unlines = concatStringsSep "\n";

  # Read the list of files and concatenate their contents by the given separator
  concatFilesSep = sep: pipef [
    (map readFile)
    (concatStringsSep sep)
  ];
}
