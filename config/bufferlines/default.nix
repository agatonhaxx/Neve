{
  lib,
  config,
  ...
}:
{
  imports = [
    # Tab/buffer line UI with buffer management keymaps
    ./bufferline.nix
  ];

  options = {
    bufferlines.enable = lib.mkEnableOption "Enable bufferlines module";
  };
  config = lib.mkIf config.bufferlines.enable {
    bufferline.enable = lib.mkDefault true;
  };
}
