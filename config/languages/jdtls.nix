{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    jdtls.enable = lib.mkEnableOption "Enable jdtls module";
  };
  config = lib.mkIf config.jdtls.enable {
    plugins.jdtls = {
      enable = true;
      settings = {
        cmd = [
          "${pkgs.jdt-language-server}/bin/jdtls"
          "--data"
          "~/.cache/jdtls/workspace"
        ];
        settings = {
          java = {
            signatureHelp = true;
            completion = true;
          };
        };
      };
    };
  };
}
