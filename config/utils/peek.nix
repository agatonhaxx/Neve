{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    peek.enable = lib.mkEnableOption "Enable peek.nvim markdown preview module";
  };
  config = lib.mkIf config.peek.enable {
    plugins.peek = {
      enable = true;
      settings = {
        auto_load = true;
        close_on_bdelete = true;
        theme = "dark";
        app = "webview";
        syntax = true;
        update_on_change = true;
        filetype = [
          "markdown"
          "html"
          "pandoc"
          "rmd"
          "qmd"
          "vimwiki"
          "tex"
          "latex"
        ];
      };
    };
    extraPackages = with pkgs; [ deno ];

    extraConfigLua = ''
      _G.peek_toggle = function()
        if require('peek').is_open() then
          require('peek').close()
        else
          require('peek').open()
        end
      end
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>co";
        action = "<cmd>lua _G.peek_toggle()<cr>";
        options = {
          desc = "Toggle Markdown Preview";
        };
      }
    ];
  };
}
