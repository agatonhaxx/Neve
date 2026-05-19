{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    lazy-nvim.enable = lib.mkEnableOption "Enable lazy-nvim module";
  };
  config = lib.mkIf config.lazy-nvim.enable {
    plugins.lazy = {
      enable = true;
      # Add neocord to lazy.nvim's managed plugins so that settings.spec is
      # non-empty. This makes lazy.nvim interpret the settings table as opts
      # (2nd arg to setup()), preventing it from resetting the runtimepath
      # and breaking Vimscript autoload functions (e.g. neocord#SetAutoCmds).
      #
      # Using `config = ""` (empty string) prevents lazy.nvim from running its
      # auto-setup callback (which would call setup() without opts), since
      # Nixvim handles neocord setup separately via its own require call.
      plugins = [
        {
          pkg = pkgs.vimPlugins.neocord;
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
