local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    { trig = "script", dscr = "devenv script.exec", filetype = "nix" },
    fmt(
      [[
scripts.{}.exec = '''
  {}
''';]],
      {
        i(1, "name"),
        i(2, "command"),
      }
    )
  ),
}
