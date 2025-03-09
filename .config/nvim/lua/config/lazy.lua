-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- Set leader key
vim.g.mapleader = ","

-- General Settings
vim.opt.hidden = true
vim.opt.showcmd = true
vim.opt.hlsearch = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 3
vim.opt.cmdheight = 1
vim.opt.shortmess:append("a")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.clipboard = "unnamed"

-- Airline Theme
vim.g.airline_theme = "dracula"
vim.g.airline_powerline_fonts = 1
vim.g.airline_extensions_tabline_enabled = 1

-- Coc.nvim Settings
-- vim.g.coc_global_extensions = { "coc-tsserver", "coc-json" }

-- Auto-detect Prettier and ESLint for CoC
-- local function is_dir(path)
--   local stat = vim.loop.fs_stat(path)
--   return stat and stat.type == "directory"
-- end

-- if is_dir("./node_modules") and is_dir("./node_modules/prettier") then
--   table.insert(vim.g.coc_global_extensions, "coc-prettier")
-- end

-- if is_dir("./node_modules") and is_dir("./node_modules/eslint") then
--   table.insert(vim.g.coc_global_extensions, "coc-eslint")
-- end

-- Keybindings
vim.keymap.set("n", "<C-p>", ":GFiles<CR>", { silent = true })
vim.keymap.set("n", "<Leader>p", ":Rg<CR>", { silent = true })
vim.keymap.set("n", "<Leader>gg", ":Git<CR>", { silent = true })
vim.keymap.set("n", "<Leader>gp", ":Git push<CR>", { silent = true })
vim.keymap.set("n", "<Leader>gb", ":GBrowse<CR>", { silent = true })
vim.keymap.set("n", "<Leader>s", ":set spell! <CR>", { silent = true })
vim.keymap.set("n", "<Leader>ww", ":w!<CR>", { silent = true })
vim.keymap.set("n", "<Leader>wq", ":wq<CR>", { silent = true })
vim.keymap.set("n", "<Leader>qq", ":q!<CR>", { silent = true })
vim.keymap.set("n", "<Leader>qa", ":qa!<CR>", { silent = true })
vim.keymap.set("n", "<Leader>2", ":e ~/.config/nvim/init.lua<CR>", { silent = true })
vim.keymap.set("n", "<Leader>3", ":e ~/.zshrc<CR>", { silent = true })
vim.keymap.set("n", "<Leader>1", ":source ~/.config/nvim/init.lua | :Lazy sync<CR>", { silent = true })
-- vim.keymap.set("n", "<Leader>rn", "<Plug>(coc-rename)", {})
vim.keymap.set("n", "<Leader>mt", ":MergetoolToggle<CR>", { silent = true })
vim.keymap.set("n", "<Leader>t", ":tabnew<CR>", { silent = true })


-- Setup lazy.nvim
require("lazy").setup({
  spec = {
  -- Git Plugins
  -- { "airblade/vim-gitgutter" },      -- Git diff signs
  { "tpope/vim-fugitive", enabled = true },          -- Git commands
  { "tpope/vim-rhubarb", enabled = true },           -- GBrowse GitHub support
  -- { "samoshkin/vim-mergetool" },     -- Merge conflict helper

  -- Vim Enhancements
  { "tpope/vim-sensible", enabled = true },
  { "tpope/vim-surround", enabled = true },
  { "tpope/vim-commentary", enabled = true },
  { "tpope/vim-unimpaired", enabled = true },
  { "tpope/vim-vinegar", enabled = true },
  { "tpope/vim-repeat", enabled = true },
  { "tpope/vim-obsession", enabled = true },
  { "jiangmiao/auto-pairs", enabled = true },

  -- Syntax & Language Support
  -- { "sheerun/vim-polyglot", enabled = true },

  -- UI Enhancements
  { "vim-airline/vim-airline", enabled = true },       -- Statusline
  { "vim-airline/vim-airline-themes", enabled = true },
  { "dracula/vim", name = "dracula", enabled = true },

  -- Fuzzy Finder
  { "junegunn/fzf", build = ":call fzf#install()", enabled = true },
  { "junegunn/fzf.vim", enabled = true },

  -- LSP & Autocompletion
  -- { "neoclide/coc.nvim", branch = "release", enabled = true },
  { "editorconfig/editorconfig-vim", enabled = true },

  -- GitHub PR Review Integration
  { "ldelossa/gh.nvim", enabled = true, dependencies = { "ldelossa/litee.nvim" },
    config = function()
      require("litee.lib").setup()
      require("litee.gh").setup()
    end
  },

    {
      'plasticboy/vim-markdown',
      branch = 'master',
      require = {'godlygeek/tabular'},
      enabled = true,
      config = function()
        vim.g.vim_markdown_folding_disabled = 1 -- Disable folding
        vim.g.vim_markdown_conceal = 1 -- Hide unnecessary symbols
        vim.g.vim_markdown_conceal_code_blocks = 1 -- Hide code block indicators
      end
    },

    -- LSP and Completion
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },
    -- import your plugins
    -- { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

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

-- LSP Setup
local lspconfig = require("lspconfig")
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "ts_ls", "eslint", "lua_ls", "pyright" },
})

-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- local on_attach = function(_, bufnr)
--   local opts = { noremap = true, silent = true, buffer = bufnr }
--   vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
--   vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
--   vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
--   vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
--   vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
-- end
--
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)

  -- Enable formatting on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
end

lspconfig.ts_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    typescript = {
      format = { enable = true },
      preferences = {
        importModuleSpecifier = "relative"
      },
      tsserver = {
        useProjectTsconfig = true
      }
    },
    javascript = { format = { enable = true } }
  }
})
lspconfig.ts_ls.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.eslint.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.lua_ls.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.pyright.setup({ capabilities = capabilities, on_attach = on_attach })

vim.cmd("colorscheme dracula")
