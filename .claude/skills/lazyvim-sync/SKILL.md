---
name: lazyvim-sync
description: Update LazyVim, then audit this Neovim config against the installed LazyVim core and extras - find redundant specs/options, conflicting overrides and outdated usage, suggest extras and improvements, and apply only what the user approves, one commit per change. Use when the user wants to update or sync LazyVim, prune redundant plugin specs, clean up the nvim config, or get LazyVim extra suggestions.
---

# lazyvim-sync

Run from `~/.config/nvim`. Reference source is the installed LazyVim checkout:
`LV=~/.local/share/nvim/lazy/LazyVim`. Never edit anything under `$LV`.

## 1. Preflight

- `git status --porcelain` must be empty. If not, stop and say so.
- `OLD=$(git -C "$LV" rev-parse HEAD)`; note `git -C "$LV" describe --tags`.
- Record the baseline LSP-attach check from step 8.

## 2. Update

```sh
nvim --headless "+Lazy! sync" +qa
NEW=$(git -C "$LV" rev-parse HEAD)
```

`lazy-lock.json` is gitignored: nothing to commit here. If `OLD == NEW`, say
so and still run the audit — the config may have drifted from the current
version.

## 3. Upstream changes (`OLD..NEW`, skip if equal)

- `git -C "$LV" log --oneline OLD..NEW`
- `CHANGELOG.md` sections between the two versions — focus on `⚠ BREAKING CHANGES`, removed/renamed extras, deprecated options, plugin swaps.
- `git -C "$LV" diff OLD..NEW -- NEWS.md`
- `git -C "$LV" diff --stat OLD..NEW -- lua/lazyvim/plugins/extras` for added/removed extras.

## 4. Local config

- `lazyvim.json` → enabled extras.
- Every spec in `lua/plugins/*.lua` (`example.lua` returns `{}` — skip it).
- `lua/config/{options,keymaps,autocmds,lazy}.lua`.
- `flake.nix` devShell tools (evidence for languages in use).
- `queries/` overrides.

## 5. Classify

Compare each local spec/setting with LazyVim core (`$LV/lua/lazyvim/plugins/*.lua`,
`$LV/lua/lazyvim/config/{options,keymaps,autocmds}.lua`) and the **enabled**
extras (`$LV/lua/lazyvim/plugins/extras/**`). Read the actual source; don't
rely on memory of LazyVim.

- **Redundant** — plugin specs whose opts/keys/deps/ft equal what core or an
  enabled extra already sets; options/keymaps/autocmds identical to LazyVim
  defaults; LSP servers, formatters, linters or treesitter parsers an enabled
  extra already configures.
- **Conflicting** — overrides that fight an enabled extra: two LSPs for one
  filetype, competing completion/picker/explorer/comment/surround plugins,
  a plugin disabled in one place and configured in another, keymaps that
  shadow LazyVim's without evident intent.
- **Outdated** — options, APIs, plugin names or extras renamed/removed in
  `OLD..NEW` or no longer present in `$LV` (e.g. `lspconfig` setup patterns vs
  `vim.lsp.config`, extras in `lazyvim.json` that no longer exist).
- **Suggested extras / improvements** — only with local evidence: a hand-rolled
  spec an extra now covers, a language present in specs/flake/queries without
  its extra, a replacement announced in NEWS, a full override that could be an
  `opts` function merge on the extra. Never suggest on taste alone.

Also run `nvim --headless "+checkhealth lazy" "+w! $SCRATCH/health.txt" +qa`
(any writable scratch path) and fold duplicate/invalid-spec warnings in.

Every finding carries: `file:line`, category, the `$LV` path proving it, the
proposed change, and risk. Recent commits (`git log`) show deviations the user
already chose deliberately (e.g. nixd over nil_ls) — don't flag those as
conflicts unless the upstream change makes them break.

## 6. Ask — always with `AskUserQuestion`

Never ask "should I…?" in free text. First print a short grouped summary, then:

- **Redundant / conflicting / outdated** — one `multiSelect` question per
  category; each option is one finding (label `file: short claim`,
  description = `$LV` source + risk). Limit is 4 questions × 4 options per
  call: batch in rounds, highest-risk category first.
- **Conflicts with several valid resolutions** — a single-select question of
  their own, one option per resolution with its trade-off.
- **Suggested extras / improvements** — single-select per suggestion, options
  such as "Enable extra (Recommended)", "Enable extra and drop my spec",
  "Skip", with `preview` showing the exact diff (`lazyvim.json` line, removed
  or reduced spec).

Rejected findings are intentional deviations: leave them and don't re-propose
them this session.

## 7. Apply

- Minimal edit per approved finding; don't touch unrelated code.
- Extras are toggled by editing `lazyvim.json` (keep the list sorted).
- If a new extra needs external binaries (LSP, formatter, linter), propose the
  `flake.nix` addition via `AskUserQuestion`; don't rely on Mason installing it.
- Keep comments only where they record a non-obvious decision.

## 8. Verify each change before committing

```sh
nvim --headless "+Lazy! load all" "+lua io.stdout:write('ERR=['..vim.v.errmsg..']\n')" +qa 2>&1   # ERR must be empty
stylua --check <changed files>   # whole-tree check may already fail on untouched files
```

`Lazy! load all` does not run nvim-lspconfig's `config` against a buffer, so
errors there (e.g. an extra's `opts` function crashing) stay hidden. Always
also open a Lua file and confirm `lua_ls` attaches with an empty `errmsg` —
run this as a baseline in step 1 too, so pre-existing breakage is reported as
a finding rather than blamed on a change:

```sh
nvim --headless "+e lua/config/options.lua" +"lua vim.defer_fn(function() io.stdout:write('ERR=['..vim.v.errmsg..'] CLIENTS='..vim.inspect(vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients()))..'\n') vim.cmd'qa!' end, 4000)" 2>&1 | grep -a CLIENTS
# expect: ERR=[] CLIENTS={ "lua_ls" }
```

For other language/LSP changes, open a sample file of that language the same
way and confirm the expected client attaches:

```sh
nvim --headless sample.ext +"lua vim.defer_fn(function() print(vim.inspect(vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients()))) vim.cmd'qa' end, 3000)"
```

If verification fails, fix or revert that change and report it — never commit
a failing change.

## 9. Commit

One commit per logical change, directly on `main`, message `<area>: <what>`
matching `git log` style (e.g. `typst: build on the LazyVim extra instead of
duplicating it`). No attribution lines.

Finish with a summary: LazyVim `OLD → NEW`, applied (with commit hashes),
declined, and anything needing manual follow-up (e.g. `nix develop` reload,
`:Lazy` restart).
