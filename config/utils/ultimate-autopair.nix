{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    ultimate-autopair.enable = lib.mkEnableOption "Enable ultimate-autopair module";
  };
  config = lib.mkIf config.ultimate-autopair.enable {

    extraPlugins = with pkgs.vimPlugins; [
      ultimate-autopair-nvim
    ];
    extraConfigLua = ''
      require('ultimate-autopair').setup()
    '';
  };
}
