{ lib, config, pkgs, ... }:
{
  options = {
    peek.enable = lib.mkEnableOption "Enable peek.nvim markdown preview module";
  };
  config = lib.mkIf config.peek.enable {

    extraPlugins = with pkgs.vimPlugins; [ peek-nvim ];
    extraPackages = with pkgs; [ deno ];

    extraConfigLua = ''
      require('peek').setup({
        auto_load = true,
        close_on_bdelete = true,
        theme = 'dark',
        app = 'webview',
        syntax = true,
        update_on_change = true,
        filetype = { 'markdown', 'html', 'pandoc', 'rmd', 'qmd', 'vimwiki', 'tex', 'latex' },
      })

      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})

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
        key = "<leader>cp";
        action = "<cmd>lua _G.peek_toggle()<cr>";
        options = {
          desc = "Toggle Markdown Preview";
        };
      }
    ];
  };
}
