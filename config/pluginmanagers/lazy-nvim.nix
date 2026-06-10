{ lib, config, ... }:
{
  options = {
    lazy-nvim.enable = lib.mkEnableOption "Enable lazy-nvim module";
  };
  config = lib.mkIf config.lazy-nvim.enable {
    extraConfigLuaPost = ''
      vim.go.loadplugins = true
    '';
    plugins.lazy = {
      enable = true;
      # Keep settings.spec non-empty so lazy.nvim treats settings as opts,
      # while still sourcing neocord through Nixvim's managed plugin option.
      plugins = [
        {
          pkg = config.plugins.neocord.package;
          name = "neocord";
          config = "";
        }
      ];
      settings = {
        performance = {
          # Nixvim manages plugins via packpath; lazy.nvim must not reset it
          reset_packpath = false;
          rtp = {
            reset = false;
          };
        };
      };
    };
  };
}
