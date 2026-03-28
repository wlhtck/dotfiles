return {
  {
    "joshuavial/aider.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    config = function()
      require("aider").setup({})

      local model =
      "bedrock/us.anthropic.claude-3-5-sonnet-20241022-v2:0"

      local args =
          "--model " .. model .. " --no-show-model-warnings"

      -- Open Aider
      vim.keymap.set("n", "<leader>ai", function()
        vim.cmd([[AiderOpen]] .. args)
      end, { desc = "AI: Open Aider (Bedrock Claude)" })

      -- Open Aider with current file
      vim.keymap.set("n", "<leader>af", function()
        local file = vim.fn.expand("%")
        vim.cmd("AiderOpen " .. args .. " " .. file)
      end, { desc = "AI: Open with current file" })

      -- Add modified files
      vim.keymap.set("n", "<leader>am", function()
        vim.cmd([[AiderAddModifiedFiles]])
      end, { desc = "AI: Add modified files to chat" })

      -- Send visual selection
      vim.keymap.set("v", "<leader>as", function()
        vim.cmd([['<,'>AiderSendSelection]])
      end, { desc = "AI: Send selection to Aider" })

      -- Quick AI commit workflow
      vim.keymap.set("n", "<leader>ac", function()
        vim.cmd("AiderAddModifiedFiles")
        vim.cmd("AiderOpen " .. args)
      end, { desc = "AI: Commit workflow with Aider" })
    end,
  },
}
