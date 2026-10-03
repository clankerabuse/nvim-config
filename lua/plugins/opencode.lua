-- OpenCode inside Neovim.
-- A dedicated side panel (opened with <leader>oa / <leader>ao) bridges to the
-- `opencode` CLI and, by default, spawns it pointed at Neovim's current working
-- directory. It also hooks into the same snacks pickers and blink.cmp sources
-- used everywhere else, so file mentions and completion feel native.
return {
  {
    "sudo-tee/opencode.nvim",
    config = function()
      require("opencode").setup({
        -- Use the pickers / completion engine already installed by LazyVim.
        preferred_picker = "snacks",
        preferred_completion = "blink",

        -- Start in build mode and default to your DeepSeek V4.1 Flash model.
        default_mode = "build",

        -- Keep the panel on the right; it uses Neovim's cwd (where you launched
        -- nvim) as the workspace opencode is pointed at.
        ui = {
          position = "right",
          input_position = "bottom",
          window_width = 0.40,
          display_model = true,
          display_context_size = true,
          display_cost = true,
          icons = { preset = "nerdfonts" },
        },

        -- Automatically send the current file/selection as context.
        context = {
          enabled = true,
          current_file = { enabled = true, show_full_path = true },
          selection = { enabled = true },
          diagnostics = { enabled = true, error = true, warning = true, info = false },
        },

        -- OpenCode's own default keymaps use the `<leader>o` prefix, which is
        -- already the LazyVim "open" menu. We disable the defaults and define a
        -- small, curated set below so the two never collide.
        default_global_keymaps = false,

        keymap = {
          editor = {
            -- Sidebar / panel: press <leader>aa to toggle from anywhere.
            ["<leader>oa"] = { "toggle", desc = "OpenCode: toggle sidebar" },
            ["<leader>oi"] = { "open_input", desc = "OpenCode: focus prompt" },
            ["<leader>oI"] = { "open_input_new_session", desc = "OpenCode: new session" },
            ["<leader>os"] = { "select_session", desc = "OpenCode: switch session" },
            ["<leader>op"] = { "configure_provider", desc = "OpenCode: pick model" },
            ["<leader>oV"] = { "configure_variant", desc = "OpenCode: pick variant" },
            ["<leader>od"] = { "diff_open", desc = "OpenCode: open diff" },
            ["<leader>oc"] = { "diff_close", desc = "OpenCode: close diff" },
          },
        },
      })
    end,
    keys = {
      -- A second, memorable shortcut: <leader>ao ("ask OpenCode").
      {
        "<leader>ao",
        function()
          require("opencode.api").toggle()
        end,
        desc = "OpenCode: toggle sidebar",
      },
      -- Quick chat in normal/visual mode: send the line or selection to a fast
      -- throwaway session and apply the edits inline.
      {
        "<leader>aq",
        function()
          require("opencode.api").quick_chat()
        end,
        mode = { "n", "x" },
        desc = "OpenCode: quick chat (line/selection)",
      },
    },
    dependencies = {
      -- Renders OpenCode's markdown output nicely in the panel.
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          anti_conceal = { enabled = false },
          file_types = { "markdown", "opencode_output" },
        },
        ft = { "markdown", "opencode_output" },
      },
    },
  },
}
