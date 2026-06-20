{
  lib,
  config,
  ...
}:
{
  imports = [
    # jk/jj to escape insert and command mode
    ./better-escape.nix
    # Hide secrets in .env and similar files (disabled by default)
    ./cloak.nix
    # Highlight colour codes (#rgb, hsl()) inline in buffers
    ./colorizer.nix
    # Quick file marks and navigation with Telescope integration
    ./harpoon.nix
    # Preview markdown in Firefox with dark theme
    ./markdown-preview.nix
    # Markdown preview via Deno webview (disabled — use markdown-preview)
    ./peek.nix
    # mini.nvim — treesitter-aware comment and cursorword highlighting
    ./mini.nix
    # Discord Rich Presence showing editing/reading/browsing status
    ./neocord.nix
    # Test runner — adapters for Java, Python, Vitest, and Plenary
    ./neotest.nix
    # Auto-close brackets, quotes, and matching pairs
    ./nvim-autopairs.nix
    # Manage surrounding characters — add, change, delete parentheses, quotes, tags
    ./nvim-surround.nix
    # Terminal integration with horizontal, vertical, and floating splits
    ./nvterm.nix
    # File explorer as editable buffer — delete to trash, floating window
    ./oil.nix
    # Session management — auto-save and restore on startup
    ./persistence.nix
    # Lua utility library — dependency for many plugins
    ./plenary.nix
    # Project management with Telescope integration
    ./project-nvim.nix
    # Seamless pane navigation between tmux splits and Neovim windows
    ./tmux-navigator.nix
    # Highlight TODO, FIXME, HACK, and other annotation comments
    ./todo-comments.nix
    # Visual undo tree history browser with diff view
    ./undotree.nix
    # Automatic time tracking for programming activity (disabled by default)
    ./wakatime.nix
    # Keymap hint popup with organised groups
    ./which-key.nix
    # Fuzzy command-line completion (disabled by default)
    ./wilder.nix
  ];

  options = {
    utils.enable = lib.mkEnableOption "Enable utils module";
  };
  config = lib.mkIf config.utils.enable {
    better-escape.enable = lib.mkDefault true;
    cloak.enable = false;
    harpoon.enable = lib.mkDefault true;
    markdown-preview.enable = lib.mkDefault true;
    peek.enable = lib.mkDefault false;
    mini.enable = lib.mkDefault true;
    neocord.enable = lib.mkDefault true;
    neotest.enable = lib.mkDefault true;
    nvim-autopairs.enable = lib.mkDefault true;
    colorizer.enable = lib.mkDefault true;
    nvim-surround.enable = lib.mkDefault true;
    nvterm.enable = lib.mkDefault true;
    oil.enable = lib.mkDefault true;
    persistence.enable = lib.mkDefault true;
    plenary.enable = lib.mkDefault true;
    project-nvim.enable = lib.mkDefault true;
    tmux-navigator.enable = lib.mkDefault true;
    todo-comments.enable = lib.mkDefault true;
    undotree.enable = lib.mkDefault true;
    wakatime.enable = false;
    which-key.enable = lib.mkDefault true;
    wilder.enable = lib.mkDefault false;
  };
}
