return {
  {
    "joshuavial/aider.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    config = function()
      local model = "bedrock/us.anthropic.claude-3-5-sonnet-20241022-v2:0"
      
      require("aider").setup({
        auto_commit = false,
        model = model,
        default_args = "--no-show-model-warnings"
      })

      local args = "--model " .. model .. " --no-show-model-warnings"

      -- Open Aider
      vim.keymap.set("n", "<leader>ai", function()
        vim.cmd([[AiderOpen]] .. args)
      end, { desc = "AI: Open Aider (Bedrock Claude)" })

      -- Open Aider with current file
      vim.keymap.set("n", "<leader>af", function()
        local file = vim.fn.expand("%")
        vim.cmd([[AiderOpen]] .. args .. " " .. file)
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

      -- Terminal navigation mappings
      vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Move to left window" })
      vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Move to window below" })
      vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Move to window above" })
      vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Move to right window" })

      -- Quick return to terminal insert mode
      vim.keymap.set("n", "<leader>at", function()
        -- Find and focus the Aider terminal buffer
        local found = false
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          local name = vim.api.nvim_buf_get_name(buf)
          if name:match("Aider Chat") then
            -- Switch to the terminal buffer
            vim.api.nvim_set_current_buf(buf)
            -- Enter terminal mode
            vim.cmd('startinsert')
            found = true
            break
          end
        end
        if not found then
          vim.notify("No active Aider chat found", vim.log.levels.WARN)
        end
      end, { desc = "AI: Return to Aider chat" })
    end,
  },
}
