-- Startup splash: an Evangelion-style title card.
--
-- Replaces LazyVim's default "LAZYVIM" dashboard header with a personal
-- "SUPER / LAZYVIM" wordmark styled after the Neon Genesis Evangelion logo:
-- a small angular kicker, a heavy slab wordmark, and a bold orange rule.
-- Each line is its own Snacks dashboard Text chunk (with a trailing newline)
-- so it can carry its own colour.

-- EVA-flavoured palette (orange accents, pale wordmark for dark backgrounds).
vim.api.nvim_set_hl(0, "EvaAccent", { fg = "#ff6a00", bold = true })
vim.api.nvim_set_hl(0, "EvaWord", { fg = "#e8e8e8" })

local accent = "EvaAccent"
local word = "EvaWord"

local header = {
  { "                       ◤  S U P E R  ◢\n", hl = accent },
  { "\n" },
  { "##          ###    ######## ##    ## ##     ## #### ##     ##\n", hl = word },
  { "##         ## ##        ##   ##  ##  ##     ##  ##  ###   ###\n", hl = word },
  { "##        ##   ##      ##     ####   ##     ##  ##  #### ####\n", hl = word },
  { "##       #########   ##        ##     ##   ##   ##  ## ### ##\n", hl = word },
  { "##       ##     ##  ##         ##      ## ##    ##  ##     ##\n", hl = word },
  { "######## ##     ## ########    ##       ###    #### ##     ##\n", hl = word },
  { "\n" },
  { "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀", hl = accent },
}

return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = header,
          -- Keep LazyVim's dashboard actions (Find File, Recent, etc.).
        },
      },
    },
  },
}
