{
  lib,
  config,
  ...
}:
{
  imports = [
    ./cmp.nix
    ./windsurf.nix
    ./copilot.nix
    ./lspkind.nix
  ];

  options = {
    completion.enable = lib.mkEnableOption "Enable completion module";
  };
  config = lib.mkIf config.completion.enable {
    cmp.enable = lib.mkDefault true;
    windsurf.enable = lib.mkDefault false;
    copilot.enable = lib.mkDefault false;
    lspkind.enable = lib.mkDefault true;
  };
}
