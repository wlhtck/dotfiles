return {
  -- Git Plugins
  { "airblade/vim-gitgutter", enabled = true }, -- Git diff signs
  {
    "tpope/vim-fugitive",                       -- Git commands
    enabled = true,
    config = function()
      local map = vim.keymap.set
      map("n", "<Leader>gg", ":Git<CR>", { silent = true })
      map("n", "<Leader>gp", ":Git push<CR>", { silent = true })
    end,
  },
  {
    "tpope/vim-rhubarb", -- GBrowse GitHub support
    enabled = true,
    config = function()
      vim.keymap.set("n", "<Leader>gb", ":GBrowse<CR>", { silent = true })
    end
  },

  -- GitHub PR Review Integration
  {
    "ldelossa/gh.nvim",
    enabled = true,
    dependencies = { "ldelossa/litee.nvim" },
    config = function()
      require('litee.lib').setup({
        tree = {
          icon_set = "codicons"
        },
        panel = {
          orientation = "left",
          panel_size  = 80
        }
      })
      require("litee.gh").setup({ icon_set = "codicons" })
    end
  },
}
