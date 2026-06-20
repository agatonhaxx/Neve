{
  lib,
  config,
  ...
}:
{
  imports = [
    # Debug Adapter Protocol — nvim-dap with UI, virtual text, and Python support
    ./nvim-dap.nix
  ];

  options = {
    dap.enable = lib.mkEnableOption "Enable dap module";
  };
  config = lib.mkIf config.dap.enable {
    nvim-dap.enable = lib.mkDefault true;
  };
}
