return {
  -- Quick file marks: pin the files you're bouncing between and jump
  -- straight to them, instead of hunting through buffers/oldfiles.
  --
  -- Custom keymaps here (rather than LazyVim's `editor.harpoon2` extra)
  -- because that extra's default `<leader>h` toggle collides with the
  -- `<leader>h*` HTTP-request group already used by kulala.nvim (see qol.lua).
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      settings = { save_on_toggle = true },
    },
    keys = function()
      local function list()
        return require("harpoon"):list()
      end

      local keys = {
        { "<leader>ma", function() list():add() end, desc = "Harpoon: add file" },
        {
          "<leader>mm",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon: quick menu",
        },
        { "<leader>mp", function() list():prev() end, desc = "Harpoon: prev file" },
        { "<leader>mn", function() list():next() end, desc = "Harpoon: next file" },
        { "<leader>mc", function() require("harpoon"):list():clear() end, desc = "Harpoon: clear list" },
      }

      for i = 1, 4 do
        table.insert(keys, {
          "<leader>m" .. i,
          function() list():select(i) end,
          desc = "Harpoon: file " .. i,
        })
      end

      return keys
    end,
  },

  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>m", group = "harpoon" },
      },
    },
  },
}
