{
  lib,
  config,
  ...
}:
{
  imports = [
    # Git diff viewer for comparing revisions and branches
    ./diffview.nix
    # Git decorations in signcolumn — blame, diff, and hunk staging
    ./gitsigns.nix
    # LazyGit TUI integration with Telescope extension
    ./lazygit.nix
    # Magit-like Git interface (disabled in favour of lazygit)
    ./neogit.nix
  ];

  options = {
    git.enable = lib.mkEnableOption "Enable git module";
  };
  config = lib.mkIf config.git.enable {
    diffview.enable = lib.mkDefault true;
    gitsigns.enable = lib.mkDefault true;
    lazygit.enable = lib.mkDefault true;
    neogit.enable = lib.mkDefault false;
  };
}
