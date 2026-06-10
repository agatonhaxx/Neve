{ lib, config, ... }:

{
  options = {
    nui.enable = lib.mkEnableOption "Enable nui module";
  };
  config = lib.mkIf config.nui.enable {
    plugins.nui.enable = true;
  };
}
