{
  lib,
  config,
  ...
}:
{
  imports = [
    # Treesitter syntax highlighting, indentation, text objects, and context
    ./treesitter-nvim.nix
    # Eclipse JDTLS Java language server
    ./jdtls.nix
    # Asynchronous linting with per-filetype linters
    ./nvim-lint.nix
  ];

  options = {
    languages.enable = lib.mkEnableOption "Enable languages module";
  };
  config = lib.mkIf config.languages.enable {
    treesitter-nvim.enable = lib.mkDefault true;
    jdtls.enable = lib.mkDefault true;
    nvim-lint.enable = lib.mkDefault true;
  };
}
