{ lib, config, ... }:
{
  options = {
    windsurf.enable = lib.mkEnableOption "Enable windsurf module";
  };
  config = lib.mkIf config.windsurf.enable {
    plugins.windsurf-vim = {
      enable = true;
    };
  };
}
