{
  lib,
  config,
  ...
}:
{
  imports = [
    # Format-on-save with per-filetype formatters and toggle commands
    ./conform.nix
    # LSP progress indicator in the status area
    ./fidget.nix
    # LSP client — servers, keymaps for goto, hover, rename, and diagnostics
    ./lsp-nvim.nix
    # Diagnostics and quickfix list viewer
    ./trouble.nix
  ];

  options = {
    lsp.enable = lib.mkEnableOption "Enable lsp module";
  };
  config = lib.mkIf config.lsp.enable {
    conform.enable = lib.mkDefault true;
    fidget.enable = lib.mkDefault true;
    lsp-nvim.enable = lib.mkDefault true;
    trouble.enable = lib.mkDefault true;
  };
}
