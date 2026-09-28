return {
  -- Vim Enhancements
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = false },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
  { "tpope/vim-sensible",    enabled = true },
  { "tpope/vim-surround",    enabled = true },
  { "tpope/vim-commentary",  enabled = true },
  { "tpope/vim-unimpaired",  enabled = true },
  { 'echasnovski/mini.nvim', version = false },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
      },
      keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-p>"] = {},
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
      },
    },
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  { "tpope/vim-repeat",    enabled = true },
  { "tpope/vim-obsession", enabled = true },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    enabled = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  -- { "jiangmiao/auto-pairs",           enabled = true },

  -- UI Enhancements
  { "vim-airline/vim-airline",        enabled = true }, -- Statusline
  { "vim-airline/vim-airline-themes", enabled = true },
  { "dracula/vim",                    name = "dracula", enabled = true },

  -- Dependencies
  { "nvim-lua/plenary.nvim",          enabled = true },
  { "nvim-tree/nvim-web-devicons",    enabled = true,   opts = {} },
}
