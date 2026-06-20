{
  lib,
  config,
  ...
}:
{
  imports = [
    # Lazy.nvim plugin manager in Nixvim integration mode
    ./lazy-nvim.nix
  ];

  options = {
    pluginmanagers.enable = lib.mkEnableOption "Enable pluginmanagers module";
  };
  config = lib.mkIf config.pluginmanagers.enable {
    lazy-nvim.enable = lib.mkDefault true;
  };
}
