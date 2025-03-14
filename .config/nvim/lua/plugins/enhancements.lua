return {
  -- Vim Enhancements
  { "tpope/vim-sensible",             enabled = true },
  { "tpope/vim-surround",             enabled = true },
  { "tpope/vim-commentary",           enabled = true },
  { "tpope/vim-unimpaired",           enabled = true },
  { "tpope/vim-vinegar",              enabled = true },
  { "tpope/vim-repeat",               enabled = true },
  { "tpope/vim-obsession",            enabled = true },
  { "jiangmiao/auto-pairs",           enabled = true },

  -- UI Enhancements
  { "vim-airline/vim-airline",        enabled = true }, -- Statusline
  { "vim-airline/vim-airline-themes", enabled = true },
  { "dracula/vim",                    name = "dracula", enabled = true },

  -- Dependencies
  { "nvim-lua/plenary.nvim",          enabled = true },
  { "nvim-tree/nvim-web-devicons",    enabled = true,   opts = {} },
}
