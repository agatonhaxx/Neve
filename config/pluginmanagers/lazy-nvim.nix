{
  lib,
  config,
  ...
}:
{
  options = {
    lazy-nvim.enable = lib.mkEnableOption "Enable lazy-nvim module";
  };
  config = lib.mkIf config.lazy-nvim.enable {
    plugins.lazy = {
      enable = true;
      settings = {
        # Empty list as spec signals lazy.nvim to treat this as opts (2nd arg),
        # not as plugin specs.  Nixvim drops {} (empty attrset) but preserves [].
        spec = [ ];
        performance = {
          # Nixvim manages plugins via packpath; lazy.nvim must not reset it
          reset_packpath = false;
          rtp = {
            reset = false;
          };
        };
      };
    };
  };
}
