-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo,
    lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
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
-- vim.opt.showcmd = true
vim.opt.mouse = ""
vim.opt.hlsearch = true
vim.opt.showmode = false
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

-- Keybindings
vim.keymap.set("n", "<Leader>s", ":set spell! <CR>", { silent = true })
vim.keymap.set("n", "<Leader>ww", ":w!<CR>", { silent = true })
vim.keymap.set("n", "<Leader>wq", ":wq<CR>", { silent = true })
vim.keymap.set("n", "<Leader>q", function()
  if vim.bo.modified then
    vim.cmd("confirm q") -- Ask if there are unsaved changes
  else
    vim.cmd("q")         -- Quit normally
  end
end, { silent = true })

vim.keymap.set("n", "<Leader>qa", function()
  -- Check if any buffers have unsaved changes
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].modified then
      -- If there's an unsaved buffer, ask for confirmation
      if vim.fn.confirm("You have unsaved changes. Quit anyway?", "&Yes\n&No", 2) == 1 then
        vim.cmd("qa!")
      end
      return
    end
  end
  -- No unsaved buffers? Just quit all normally.
  vim.cmd("qa")
end, { silent = true })

vim.keymap.set("n", "<Leader>2", ":e ~/.config/nvim/init.lua<CR>", { silent = true })
vim.keymap.set("n", "<Leader>3", ":e ~/.zshrc<CR>", { silent = true })
vim.keymap.set("n", "<Leader>1", function()
  -- Clear cached modules to force reloading
  for name, _ in pairs(package.loaded) do
    if name:match("^user") or name:match("^config") then
      package.loaded[name] = nil
    end
  end

  -- Re-run the init.lua
  dofile(vim.fn.stdpath("config") .. "/init.lua")

  -- Run Lazy sync
  vim.cmd("Lazy sync")
end, { silent = true })
-- vim.keymap.set("n", "<Leader>rn", "<Plug>(coc-rename)", {})
vim.keymap.set("n", "<Leader>mt", ":MergetoolToggle<CR>", { silent = true })
vim.keymap.set("n", "<Leader>t", ":tabnew<CR>", { silent = true })


-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- AI
    -- {
    --   'augmentcode/augment.vim',
    -- },
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

vim.cmd [[highlight Normal guibg=NONE ctermbg=NONE]]
vim.cmd [[highlight NonText guibg=NONE ctermbg=NONE]]

vim.opt.termguicolors = true
vim.cmd("colorscheme dracula")
vim.cmd [[highlight Normal guibg=NONE ctermbg=NONE]]
