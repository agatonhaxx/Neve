{
  lib,
  config,
  ...
}:
{
  imports = [
    # Dashboard/start screen with ASCII logo and quick-action buttons
    ./alpha.nix
    # Winbar breadcrumb navigation
    ./barbecue.nix
    # Improved vim.ui.select and vim.ui.input with Telescope backend
    ./dressing-nvim.nix
    # Indentation guide lines with scope highlighting
    ./indent-blankline.nix
    # Fancy UI for messages, cmdline, and popupmenu (disabled by default)
    ./noice.nix
    # UI component library — dependency for other plugins
    ./nui.nix
    # Notification system with toggle helpers for line numbers, wrap, and inlay hints
    ./notify.nix
    # File type icons used throughout the UI
    ./web-devicons.nix
  ];

  options = {
    ui.enable = lib.mkEnableOption "Enable ui module";
  };
  config = lib.mkIf config.ui.enable {
    alpha.enable = lib.mkDefault true;
    barbecue.enable = lib.mkDefault true;
    dressing-nvim.enable = lib.mkDefault true;
    indent-blankline.enable = lib.mkDefault true;
    noice.enable = lib.mkDefault false;
    notify.enable = lib.mkDefault true;
    nui.enable = lib.mkDefault true;
    web-devicons.enable = lib.mkDefault true;
  };
}
