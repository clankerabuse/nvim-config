return {
  -- Disable the VS Code colorscheme from example.lua
  {
    "Mofiqul/vscode.nvim",
    enabled = false,
  },

  -- Set LazyVim to use the custom terminal theme
  -- The colorscheme file is at ~/.config/nvim/colors/terminal.lua
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "terminal",
    },
  },
}
