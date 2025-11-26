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
vim.keymap.set("n", "<leader>p", function()
	local file = vim.fn.expand("%:p")
	vim.fn.jobstart({ "xdg-open", file }, { detach = true })
end, { desc = "Open current file externally" })

-- Trouble
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { silent = true })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_next()
end, { silent = true })
vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_prev()
end, { silent = true })

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

-- Terminal keymaps
vim.keymap.set("n", "<leader>tv", function()
	require("toggleterm").toggle(2, 40, vim.fn.getcwd(), "vertical")
end, { desc = "Toggle vertical terminal" })

vim.keymap.set("n", "<leader>tt", ":ToggleTerm direction=float<CR>", { desc = "Toggle floating terminal" })
-- Esc closes floating terminals, Ctrl+[ exits terminal mode but keeps it open
vim.keymap.set("t", "<Esc>", function()
	local buftype = vim.bo.buftype
	if buftype == "terminal" then
		vim.cmd("stopinsert")
		vim.cmd("close")
	end
end, { desc = "Close floating terminal" })

-- -- Quick project REPLs
vim.keymap.set("n", "<leader>tn", ":1ToggleTerm direction=horizontal<CR>", { desc = "Node REPL" })
vim.keymap.set("n", "<leader>tp", ":2ToggleTerm direction=horizontal<CR>ipython<CR>", { desc = "Python REPL" })

-- GitSigns navigation
vim.keymap.set("n", "]c", "<cmd>Gitsigns next_hunk<CR>", { desc = "Next git change" })
vim.keymap.set("n", "[c", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Previous git change" })

-- GitSigns actions
vim.keymap.set("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>hb", "<cmd>Gitsigns blame_line<CR>", { desc = "Blame line" })

-- LazyGit
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

-- oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Quick save (CRITICAL)
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save in insert mode" })

vim.keymap.set("t", "<C-[>", [[<C-\><C-n>]], { desc = "Exit terminal mode (keep open)" })

-- Quick save
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save in insert mode" })
vim.keymap.set("v", "<C-s>", "<Esc>:w<CR>gv", { desc = "Save in visual mode" })

-- Quick quit
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all (force)" })

-- Move lines up/down (Alt+j/k)
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting (stay in visual mode)
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Better paste (don't yank replaced text)
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })

-- Delete without yanking
vim.keymap.set({ "n", "v" }, "<leader>x", [["_d]], { desc = "Delete without yanking" })

-- Better Telescope shortcuts
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<CR>", { desc = "Find word under cursor" })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })

-- Clear search highlight
vim.keymap.set("n", "<Esc>", ":noh<CR>", { desc = "Clear search highlight" })

-- SPLIT MANAGEMENT
-- Split navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Bottom split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Top split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Right split" })

-- Create splits
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split vertical" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split horizontal" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equal split sizes" })
vim.keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close split" })

-- Resize splits
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase width" })
