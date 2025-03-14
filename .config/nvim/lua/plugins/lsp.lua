return {
  -- Core LSP Plugins
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      -- Mason Setup
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls", "eslint", "lua_ls", "pyright" },
      })

      -- LSP Capabilities (for nvim-cmp)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- LSP Keymaps and Formatting on Save
      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        local map = vim.keymap.set

        -- LSP Keybindings
        map("n", "gd", vim.lsp.buf.definition, opts)          -- Go to Definition
        map("n", "gr", vim.lsp.buf.references, opts)          -- Show References
        map("n", "K", vim.lsp.buf.hover, opts)                -- Hover Documentation
        map("n", "<Leader>rn", vim.lsp.buf.rename, opts)      -- Rename Symbol
        map("n", "<Leader>ca", vim.lsp.buf.code_action, opts) -- Code Actions

        -- 💡 Quick Fix Mapping: Applies fixes if available
        map("n", "<Leader>qf", function()
          vim.lsp.buf.code_action({
            context = { only = { "quickfix" } }, -- Only show Quick Fix actions
            apply = true,                        -- Automatically apply fix if there's only one option
          })
        end, opts)

        -- LSP Diagnostics Keybindings
        map("n", "[d", vim.diagnostic.goto_prev, opts)          -- Jump to previous diagnostic
        map("n", "]d", vim.diagnostic.goto_next, opts)          -- Jump to next diagnostic
        map("n", "<Leader>d", vim.diagnostic.open_float, opts)  -- Show diagnostic popup
        map("n", "<Leader>dl", vim.diagnostic.setloclist, opts) -- Open diagnostics list

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

      -- Setup LSP Servers
      local lspconfig = require("lspconfig")

      -- TypeScript & JavaScript (tsserver)
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          typescript = {
            format = { enable = true },
            preferences = {
              importModuleSpecifier = "relative",
            },
            tsserver = {
              useProjectTsconfig = true,
            },
          },
          javascript = { format = { enable = true } },
        },
      })

      -- Other LSPs
      lspconfig.eslint.setup({ capabilities = capabilities, on_attach = on_attach })
      lspconfig.lua_ls.setup({ capabilities = capabilities, on_attach = on_attach })
      lspconfig.pyright.setup({ capabilities = capabilities, on_attach = on_attach })
    end,
  },

  -- Autocompletion (nvim-cmp)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),            -- Trigger completion manually
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept suggestion
          ["<Tab>"] = cmp.mapping.select_next_item(),        -- Next completion
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),      -- Previous completion
        }),
        sources = {
          { name = "nvim_lsp" }, -- LSP-based completion
          { name = "luasnip" },  -- Snippet completion
        },
      })
    end,
  },

  -- Treesitter (for syntax highlighting & better parsing)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua", "javascript", "typescript", "python", "vim", "bash", "json" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
    },
  },

  -- EditorConfig (for consistent formatting)
  { "editorconfig/editorconfig-vim", enabled = true },
}
