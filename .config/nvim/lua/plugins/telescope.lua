return {
  -- Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git" },
          sorting_strategy = "ascending",
          layout_config = { prompt_position = "top" },
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- Enable fuzzy search
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      require("telescope").load_extension("fzf")
      -- Telescope keymappings
      local builtin = require("telescope.builtin")
      local map = vim.keymap.set

      -- Equivalent to `GFiles` (Git files)
      map("n", "<C-p>", builtin.git_files, { silent = true })

      -- Equivalent to `Rg` (Live Grep)
      map("n", "<Leader>p", builtin.live_grep, { silent = true })
    end
  },
}
