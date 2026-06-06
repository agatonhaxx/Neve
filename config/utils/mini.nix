{ lib, config, ... }:
{
  options = {
    mini.enable = lib.mkEnableOption "Enable mini module";
  };
  config = lib.mkIf config.mini.enable {
    plugins.mini = {
      enable = true;
      modules = {
        comment = {
          options = {
            custom_commentstring.__raw = ''
              function()
                return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
              end
            '';
          };
        };
        cursorword = {
          opts = {
            delay = 100;
          };
        };
      };
    };
  };
}
