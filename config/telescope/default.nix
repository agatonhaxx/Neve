{
  lib,
  config,
  ...
}:
{
  imports = [
    # Fuzzy finder with fzf-native and ui-select extensions
    ./telescope-nvim.nix
  ];

  options = {
    telescope.enable = lib.mkEnableOption "Enable telescope module";
  };
  config = lib.mkIf config.telescope.enable {
    telescope-nvim.enable = lib.mkDefault true;
  };
}
