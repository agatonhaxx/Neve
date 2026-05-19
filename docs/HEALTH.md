# Neve Health Exceptions

This document catalogues `:checkhealth` items that are expected, environment-dependent,
or upstream artifacts — not Neve configuration errors.

Items are classified as:

- **Expected** — By-design consequence of using NixVim
- **Environment** — Depends on host tools or user preference
- **User-auth** — Requires per-user authentication
- **Upstream** — Bug or artifact in a third-party plugin or Neovim itself
- **Test artifact** — Plugin self-test failure that does not affect real usage

## Current Exceptions (2026-05-19)

### nvim-treesitter — Parser dependency errors
- **Severity:** 6 ❌
- **Classification:** Upstream / benign fallback
- **Detail:** `html`, `javascript`, `tsx`, and `typescript` parsers declare companion
  dependencies (`ecma`, `jsx`, `html_tags`) that are not installed. These companion
  parsers provide shared capture groups for edge-case highlighting. Direct Lua API
  access to all query files succeeds — parsing and highlighting work correctly without
  them. The empty error bodies in healthcheck occur because `'queries'` is a catch-all
  pseudo-type for dependency checks, not a real query group.

### ultimate-autopair — Self-test failures
- **Severity:** 3 ❌
- **Classification:** Test artifact
- **Detail:** The plugin's self-test suite uses `vim.treesitter.get_string_parser`
  (synthetic test harness), while real editor usage uses `vim.treesitter.get_parser`
  (live buffer). In Neovim 0.12, these code paths can produce different node trees,
  causing false-positive test failures in `rfaswarp` tests. Headless testing confirmed
  reverse fastwarp (`<A-E>`) works correctly in live buffers for all three test cases.
  No configuration change needed.

### lazy.nvim — luarocks/hererocks
- **Severity:** 1 ❌, 3 ⚠️
- **Classification:** Expected
- **Detail:** NixVim manages all plugins through Nix derivations. LuaRocks and hererocks
  are not needed and not installed. lazy.nvim's healthcheck warns about this by default.
  There is no supported way to disable these warnings in a NixVim-managed config.

### copilot.lua — LSP client not available
- **Severity:** 1 ❌
- **Classification:** User-auth
- **Detail:** Copilot requires authentication via `:Copilot auth` with GitHub credentials.
  This is a per-user action, not a configuration issue. Users who do not use Copilot
  can ignore this; users who do must authenticate once.

### vim.health — Missing user config
- **Severity:** 1 ⚠️
- **Classification:** Expected
- **Detail:** NixVim generates its own `init.lua` and does not use
  `~/.config/nvim/init.lua`. The missing-user-config warning is expected and harmless.

### diffview — hg not executable
- **Severity:** 1 ⚠️
- **Classification:** Environment
- **Detail:** Mercurial (`hg`) is an optional VCS dependency for diffview.nvim. Git is the
  only VCS in use. Install `hg` only if Mercurial repositories are needed.

### project.nvim — No active session / fzf-lua disabled
- **Severity:** 2 ⚠️
- **Classification:** Expected
- **Detail:** Normal on fresh Neovim start. A session is created after opening a project.
  `fzf-lua` integration being disabled is intentional — telescope is the fuzzy finder in use.

### conform — Language-specific formatters
- **Severity:** 4 ⚠️
- **Classification:** Environment
- **Detail:** `black` (Python), `rustfmt` (Rust), `google-java-format` (Java), and `prettier`
  (fallback) are not included in the Neve closure. These are language-specific tools that
  not every user needs. Install them per-project or per-user preference.
  `prettierd` is included as the primary web-language formatter.
