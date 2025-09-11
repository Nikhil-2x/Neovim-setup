-- Compile & Run C++ (F5)
vim.keymap.set("n", "<F5>", function()
  vim.cmd("w")
  local filename = vim.fn.expand("%:r")
  vim.cmd("!g++ % -o " .. filename)
  vim.cmd("botright split | terminal ./" .. filename)
end)

-- Clang-format (F8)
vim.keymap.set("n", "<F8>", ":w<CR>:!clang-format -i %<CR>")

-- Toggle NvimTree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Insert boilerplate
vim.keymap.set("n", "<leader>bo", ":0r ~/.config/nvim/templates/cpp_boilerplate.cpp<CR>")

-- Open current file externally
vim.keymap.set('n', '<leader>p', function()
  local file = vim.fn.expand('%:p')
  vim.fn.jobstart({'xdg-open', file}, {detach = true})
end, { desc = 'Open current file externally' })

-- Trouble
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { silent = true })
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, { silent = true })
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, { silent = true })

-- Dismiss notifications
vim.keymap.set("n", "<leader>nd", function()
  require("notify").dismiss({ silent = true, pending = true })
end, { desc = "Dismiss notifications" })

-- Buffer navigation
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { silent = true, desc = "Prev buffer" })

-- Buffer actions
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { silent = true, desc = "Delete buffer" })
vim.keymap.set("n", "<leader>ba", ":%bd|e#<CR>", { silent = true, desc = "Delete all but current" })
vim.keymap.set("n", "<leader>bl", ":ls<CR>", { silent = true, desc = "List buffers" })


-- Copilot Chat
vim.keymap.set("n", "<leader>cc", ":CopilotChat<CR>", { desc = "Open Copilot Chat" })
vim.keymap.set("v", "<leader>ce", ":CopilotChatExplain<CR>", { desc = "Explain selected code" })
vim.keymap.set("v", "<leader>cf", ":CopilotChatFix<CR>", { desc = "Fix selected code" })
vim.keymap.set("v", "<leader>ct", ":CopilotChatTests<CR>", { desc = "Generate tests" })
vim.keymap.set("v", "<leader>co", ":CopilotChatOptimize<CR>", { desc = "Optimize selected code" })


--Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffer" })



-- Toggleterm keymaps
vim.keymap.set("n", "<leader>th", function()
  require("toggleterm").toggle(1, 15, vim.fn.getcwd(), "horizontal")
end, { desc = "Toggle horizontal terminal" })

vim.keymap.set("n", "<leader>tv", function()
  require("toggleterm").toggle(2, 40, vim.fn.getcwd(), "vertical")
end, { desc = "Toggle vertical terminal" })



vim.keymap.set("n", "<leader>tf", function()
  require("toggleterm").toggle(3, 20, vim.fn.getcwd(), "float")
end, { desc = "Toggle floating terminal" })
--
-- -- Quick project REPLs
vim.keymap.set("n", "<leader>tn", ":1ToggleTerm direction=horizontal<CR>", { desc = "Node REPL" })
vim.keymap.set("n", "<leader>tp", ":2ToggleTerm direction=horizontal<CR>ipython<CR>", { desc = "Python REPL" })


