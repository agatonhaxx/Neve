{
  lib,
  config,
  ...
}:
{
  imports = [
    # base16 colourscheme (mountain variant)
    ./base16.nix
    # Catppuccin — mocha flavour, transparent background
    ./catppuccin.nix
    # Rosé Pine with italic and bold styles
    ./rose-pine.nix
  ];

  options = {
    colorschemes.enable = lib.mkEnableOption "Enable colorschemes module";
  };
  config = lib.mkIf config.colorschemes.enable {
    base16.enable = lib.mkDefault false;
    catppuccin.enable = lib.mkDefault true;
    rose-pine.enable = lib.mkDefault false;
  };
}
