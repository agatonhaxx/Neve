{
  lib,
  config,
  ...
}:
{
  imports = [
    # Autocompletion — nvim-cmp with LSP, buffer, path, cmdline, and LuaSnip sources
    ./cmp.nix
    # Windsurf AI completion (disabled by default)
    ./windsurf.nix
    # GitHub Copilot AI completion (disabled by default)
    ./copilot.nix
    # Pictogram icons for completion item kinds
    ./lspkind.nix
  ];

  options = {
    completion.enable = lib.mkEnableOption "Enable completion module";
  };
  config = lib.mkIf config.completion.enable {
    cmp.enable = lib.mkDefault true;
    windsurf.enable = lib.mkDefault false;
    copilot.enable = lib.mkDefault false;
    lspkind.enable = lib.mkDefault true;
  };
}
