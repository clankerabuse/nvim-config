-- Polished side file tree.
-- `<leader>e` toggles the tree; `\` does the same, and `|` reveals the current
-- file inside it. Git status, hidden files, diagnostics and fuzzy "find in tree"
-- all come for free via snacks.explorer.
return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        replace_netrw = true,
        -- Keep the tree focused on the project when toggled without a path.
        follow_file = true,
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          Snacks.explorer({ cwd = LazyVim.root() })
        end,
        desc = "File Explorer",
      },
      {
        "\\",
        function()
          Snacks.explorer({ cwd = LazyVim.root() })
        end,
        desc = "File Explorer (alt)",
      },
      {
        "|",
        function()
          Snacks.explorer({ cwd = LazyVim.root(), find_file = true })
        end,
        desc = "File Explorer (reveal current file)",
      },
    },
  },
}
