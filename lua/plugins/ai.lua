return {
  -- Agentic coding via the opencode ACP bridge. Avante provides the
  -- chat/sidebar UI, diff review, and editor integration; the actual model
  -- calls are delegated to `opencode acp` running as a subprocess.
  {
    "yetone/avante.nvim",
    build = "make",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      provider = "opencode",
      mode = "agentic",
      acp_providers = {
        opencode = {
          command = "opencode",
          args = { "acp" },
        },
      },
      input = { provider = "native" },
      windows = {
        width = 34, -- a bit roomier than the 30% default for reading diffs
        sidebar_header = {
          include_model = true, -- show which model/agent is active in the title
        },
      },
      behaviour = {
        auto_set_keymaps = false, -- we define our own keymaps below
        support_paste_from_clipboard = true, -- paste screenshots straight into the chat input
        auto_approve_tool_permissions = true, -- don't interrupt every file write/bash call with a prompt
        confirmation_ui_style = "inline_buttons",
        -- Keep open buffers in sync with whatever the agent writes to disk,
        -- and jump to the file/line it just touched. Paired with the
        -- `checktime` autocmds in config/autocmds.lua, this is what makes
        -- edits show up instantly without you needing to `:e` or lose focus.
        acp_follow_agent_locations = true,
      },
    },
    keys = {
      { "<leader>aa", "<cmd>AvanteAsk<cr>", desc = "Avante: ask", mode = { "n", "v" } },
      { "<leader>ac", "<cmd>AvanteChat<cr>", desc = "Avante: chat" },
      { "<leader>an", "<cmd>AvanteChatNew<cr>", desc = "Avante: new chat" },
      { "<leader>ae", "<cmd>AvanteEdit<cr>", desc = "Avante: edit selection", mode = { "n", "v" } },
      { "<leader>af", "<cmd>AvanteFocus<cr>", desc = "Avante: focus sidebar" },
      { "<leader>at", "<cmd>AvanteToggle<cr>", desc = "Avante: toggle sidebar" },
      { "<leader>ah", "<cmd>AvanteHistory<cr>", desc = "Avante: history" },
      { "<leader>am", "<cmd>AvanteModels<cr>", desc = "Avante: select model" },
      { "<leader>ap", "<cmd>AvanteSwitchProvider<cr>", desc = "Avante: switch provider" },
      { "<leader>ar", "<cmd>AvanteRefresh<cr>", desc = "Avante: refresh" },
      { "<leader>as", "<cmd>AvanteStop<cr>", desc = "Avante: stop generation" },
      { "<leader>aR", "<cmd>AvanteShowRepoMap<cr>", desc = "Avante: show repo map" },
    },
  },

  -- Paste images (e.g. screenshots) straight into an avante prompt.
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = { insert_mode = true },
        use_absolute_path = true,
      },
    },
  },

  -- Render avante's chat buffer with the same nice markdown styling used
  -- for regular markdown files (headings, fences, checkboxes, etc.)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    opts = { file_types = { "markdown", "Avante" } },
    ft = { "markdown", "Avante" },
  },

  -- Surface avante as a blink.cmp completion source (@file, @diagnostics, ...)
  {
    "saghen/blink.cmp",
    optional = true,
    specs = { "Kaiser-Yang/blink-cmp-avante" },
    opts = {
      sources = {
        default = { "avante" },
        providers = { avante = { module = "blink-cmp-avante", name = "Avante" } },
      },
    },
  },

  -- Inline ghost-text completions. Kept as a separate engine from avante's
  -- own (disabled) auto-suggestions to avoid two systems fighting for the
  -- same virtual text.
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    opts = {
      keymaps = {
        accept_suggestion = "<Tab>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
      log_level = "warn",
      disable_inline_completion = false,
      disable_keymaps = false,
    },
  },

  -- Copilot stays off; supermaven + avante/opencode cover completions and
  -- agentic edits without paying for/loading a third AI integration.
  { "CopilotNvim/copilot.lua", enabled = false },
}
