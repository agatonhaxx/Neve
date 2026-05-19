{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    plenary.enable = lib.mkEnableOption "Enable plenary module";
  };
  config = lib.mkIf config.plenary.enable {
    # NOTE: plenary-nvim is a transitive dependency of telescope and many other
    # plugins. This explicit install is redundant but harmless.
    extraPlugins = with pkgs.vimPlugins; [
      plenary-nvim
    ];
  };
}
