{
  lib,
  config,
  ...
}:
{
  imports = [
    # Core Neovim settings — line numbers, tabs, search, undo, folds, appearance
    ./set.nix
  ];

  options = {
    sets.enable = lib.mkEnableOption "Enable sets module";
  };
  config = lib.mkIf config.sets.enable {
    set.enable = lib.mkDefault true;
  };
}
