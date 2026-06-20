{
  lib,
  config,
  ...
}:
{
  imports = [
    # Feature-rich statusline with mode, branch, diagnostics, LSP, and navic
    ./lualine.nix
    # Simple alternative statusline (disabled in favour of lualine)
    ./staline.nix
  ];

  options = {
    statusline.enable = lib.mkEnableOption "Enable statusline module";
  };
  config = lib.mkIf config.statusline.enable {
    lualine.enable = lib.mkDefault true;
    staline.enable = lib.mkDefault false;
  };
}
