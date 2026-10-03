-- LazyVim core settings and statusline.
return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- Keep the TokyoNight family that ships with LazyVim.
      colorscheme = "tokyonight",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Show whether an OpenCode panel is connected, right before the diff/file
      -- info in the status line.
      local function opencode_status()
        local ok, api = pcall(require, "opencode.api")
        if not ok then
          return ""
        end
        -- The panel exposes its state through the picker/UI module; fall back to
        -- a quiet indicator if the internals move.
        local connected = pcall(function()
          return api.is_running and api.is_running()
        end)
        return connected and "" or "󰚩 OpenCode"
      end

      table.insert(opts.sections.lualine_x, 1, {
        opencode_status,
        color = { fg = "#7aa2f7" },
      })
    end,
  },
  {
    -- Bufferline already ships with LazyVim; make buffer numbers visible and
    -- pick a clean "slant" separator so tabs read well next to the file tree.
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        numbers = "ordinal",
        separator_style = "slant",
        always_show_bufferline = false,
      },
    },
  },
}
