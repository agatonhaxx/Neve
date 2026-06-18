{ lib, config, ... }:
let
  snippetsPath = ../../snippets;
in
{
  options = {
    luasnip.enable = lib.mkEnableOption "Enable luasnip module";
  };
  config = lib.mkIf config.luasnip.enable {
    plugins.friendly-snippets.enable = true;
    plugins.luasnip = {
      enable = true;
      settings = {
        enable_autosnippets = true;
        store_selection_keys = "<Tab>";
      };
      luaConfig.content = ''
        require("luasnip.loaders.from_lua").load({paths = "${snippetsPath}"})
      '';
    };
  };
}
