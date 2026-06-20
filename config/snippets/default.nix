{
  lib,
  config,
  ...
}:
{
  imports = [
    # LuaSnip snippet engine with friendly-snippets and custom snippets
    ./luasnip.nix
  ];

  options = {
    snippets.enable = lib.mkEnableOption "Enable snippets module";
  };
  config = lib.mkIf config.snippets.enable {
    luasnip.enable = lib.mkDefault true;
  };
}
