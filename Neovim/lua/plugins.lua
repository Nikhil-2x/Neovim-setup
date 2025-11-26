local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				ensure_installed = { "cpp", "c", "lua", "javascript", "typescript", "tsx", "json", "css", "html" },
			})
		end,
	},

	-- File explorer
	-- nvim-tree
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				filters = { dotfiles = false, git_ignored = false },
			})
		end,
	},

	--Oil.nvim
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				view_options = { show_hidden = true },
			})
		end,
	},

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup()
		end,
	},

	-- Themes

	{
		"sainnhe/sonokai",
		-- lazy = false,
		-- priority = 2000,
		config = function()
			vim.g.sonokai_transparent_background = "2"
			vim.g.sonokai_enable_italic = true
			--[[ vim.cmd.colorscheme('sonokai') ]]
		end,
	},
	{
		"Shatur/neovim-ayu",
		config = function()
			require("ayu").setup({
				mirage = false, -- set false for normal Ayu Dark
				overrides = {}, -- optional overrides
			})

			-- vim.cmd("colorscheme ayu-mirage")
			vim.cmd("colorscheme ayu-dark")
			-- OR: vim.cmd("colorscheme ayu-light")
		end,
	},

	-- Dashboard / UI
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			dashboard = {
				sections = {
					{
						section = "header",
						padding = 2,
					},
					{
						pane = 2,
						section = "terminal",
						cmd = "colorscript -e square",
						height = 4,
						padding = 2,
					}, --  Multiple APIs with fallbacks
					{
						pane = 1,
						icon = "💭 ",
						title = "Quote",
						section = "terminal",
						cmd = [[
                if ping -c 1 -W 1 8.8.8.8 >/dev/null 2>&1; then
                  curl -s --max-time 3 'https://zenquotes.io/api/random' | jq -r '.[0].q + " - " + .[0].a' 2>/dev/null ||
                  curl -s --max-time 3 'https://api.quotable.io/random' | jq -r '.content + " - " + .author' 2>/dev/null ||
                  curl -s --max-time 3 'https://dummyjson.com/quotes/random' | jq -r '.quote + " - " + .author' 2>/dev/null
                else
                  quotes=(
                    "Control is an illusion. - Mr. Robot"
                    "The world itself is just one big hoax. - Elliot"
                    "People always make the best exploits. - Mr. Robot"
                    "I am root. - Elliot"
                    "We are all living in each other’s paranoia. - Mr. Robot"
                    "Hello, friend. - Elliot"
                    "I am not special. I'm just anonymous. And that's exactly what i want. -Elliot"
                    "They're just gonna keep coming. Corporations. Governments. Everyone. -Mr. Robot"
                    "The system is rigged. -Elliot"
                    "Maybe wars aren't meant to be won, maybe they're meant to be continous. -Mr. Robot"
                    "Just a dev trying to find certainity in an uncertain world. -localhost"
                    "Pushing commits and probabilities - one quantam bit at a time. -localhost"
                    "Full-stack by day, collapsing wavefunctions by night. -localhost"
                    "Superposition of bugs and features - until you test it."
                    "Reality is optional when you code across dimensions."
                    "From async functions to quantum fluctuations - I try to debug both. -localhost"
                    "Bits, qubits, and building better realities - one repo at a time."
                  )
                  echo "${quotes[$RANDOM % ${#quotes[@]}]}"
                fi
                ]],

						height = 3,
						padding = 1,
						ttl = 3600,
					}, -- Dynamic system info
					{
						pane = 1,
						icon = "🐧",
						title = "System Info",
						section = "terminal",
						cmd = 'echo "$(uname -sr) | $(uptime -p) | $(df -h / | awk \'NR==2{print $4" free"}\')"',
						height = 2,
						padding = 0,
						ttl = 60, -- refresh every minute
					}, -- Dynamic weather (if you have curl)
					{
						pane = 2,
						icon = "🌤️ ",
						title = "Weather",
						section = "terminal",
						cmd = "bash -c \"curl -s 'https://wttr.in/Mumbai?format=%l:+%c+%t+%h+%w' || echo 'Weather unavailable'\"",
						height = 2,
						padding = 1,
						ttl = 1800, -- refresh every 30 minutes
					},
					-- Today's date with a fun fact
					{
						pane = 1,
						icon = " ",
						title = "Today",
						section = "terminal",
						cmd = "echo \"$(date +'%A, %B %d, %Y') | Day $(date +%j) of $(date +%Y)\"",
						height = 2,
						padding = 1,
						ttl = 3600, -- refresh hourly
					},
					{
						section = "keys",
						gap = 1,
						padding = 1,
					},
					{
						pane = 2,
						icon = " ",
						title = "Recent Files",
						section = "recent_files",
						indent = 2,
						padding = 1,
					},
					{
						pane = 2,
						icon = " ",
						title = "Projects",
						section = "projects",
						indent = 2,
						padding = 1,
					}, -- Enhanced git status with branch info
					{
						pane = 2,
						icon = " ",
						title = "Git Status",
						section = "terminal",
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						cmd = "git branch --show-current | sed 's/^/Branch: /' && echo '---' && git status --short --branch --renames",
						height = 6,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					}, -- Show recent commits
					{
						pane = 2,
						icon = " ",
						title = "Recent Commits",
						section = "terminal",
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						cmd = "git log --oneline -5 --pretty=format:'%h %s (%cr)' 2>/dev/null || echo 'No commits found'",
						height = 6,
						padding = 1,
						ttl = 10 * 60, -- refresh every 10 minutes
						indent = 3,
					},
					--CPU and Memory Usage
					{
						pane = 1,
						icon = "🖥️ ",
						title = "Resources",
						section = "terminal",
						cmd = "echo \"CPU: $(top -bn1 | grep 'Cpu(s)' | awk '{print $2}')% | Mem: $(free -h | awk '/^Mem:/ {print $3\"/\"$2}')\"",
						height = 2,
						padding = 1,
						ttl = 10, -- update every 10s
					},
					-- Show coding activity (if you have a way to track it)
					{
						pane = 1,
						icon = " ",
						title = "Dev Stats",
						section = "terminal",
						cmd = "find . -name '*.cpp' -o -name '*.c' -o -name '*.h' | wc -l | sed 's/^/C++ files: /' && find . -name '*.lua' | wc -l | sed 's/^/Lua files: /'",
						height = 3,
						padding = 1,
						ttl = 300, -- refresh every 5 minutes
					},

					-- Show TODO/FIXME count in project
					{
						pane = 2,
						icon = " ",
						title = "TODOs & FIXMEs",
						section = "terminal",
						cmd = "grep -r --include='*.cpp' --include='*.c' --include='*.h' --include='*.lua' -c 'TODO\\|FIXME' . 2>/dev/null | wc -l | sed 's/^/Found: /' | sed 's/$/ items/' || echo 'No TODOs found'",
						height = 2,
						padding = 1,
						ttl = 600, -- refresh every 10 minutes
					},
					{
						section = "startup",
					},
				},
			},
		},
	},

	--Prettier
	-- {
	--   "stevearc/conform.nvim",
	--   event = { "BufWritePre" }, -- load before save
	--   config = function()
	--     local conform = require("conform")
	--
	--     conform.setup({
	--       -- Filetypes and their formatters
	--       formatters_by_ft = {
	--         javascript = { "prettier","eslint_d" },
	--         typescript = { "prettier","eslint_d" },
	--         javascriptreact = { "prettier","eslint_d" }, -- .jsx
	--         typescriptreact = { "prettier" ,"eslint_d"}, -- .tsx
	--         json = { "prettier" },
	--         html = { "prettier" },
	--         css = { "prettier" },
	--         markdown = { "prettier" },
	--         lua = { "stylua" },
	--       },
	--
	--       -- Formatter override for Prettier
	--       formatters = {
	--         prettier = {
	--           command = function()
	--             local local_prettier = vim.fn.getcwd() .. "/node_modules/.bin/prettier"
	--             if vim.fn.executable(local_prettier) == 1 then
	--               return local_prettier -- Use project Prettier
	--             end
	--             return "prettier" -- Fallback to global
	--           end,
	--           args = { "--stdin-filepath", "$FILENAME" },
	--         },
	--       },
	--     })
	--
	--     -- Autoformat on save
	--     vim.api.nvim_create_autocmd("BufWritePre", {
	--       pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.json", "*.css", "*.html", "*.md" },
	--       callback = function(args)
	--         conform.format({ bufnr = args.buf })
	--       end,
	--     })
	--
	--     -- Manual format keymap
	--     vim.keymap.set("n", "<leader>f", function()
	--       conform.format({ async = true, lsp_fallback = true })
	--     end, { desc = "Format file" })
	--   end,
	-- },
	--
	--Prettier
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					json = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					markdown = { "prettier" },
					lua = { "stylua" },
				},

				formatters = {
					prettier = {
						timeout_ms = 5000, -- Increase timeout
						command = "prettier",
					},
				},
			})

			-- Autoformat on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.json", "*.css", "*.html", "*.md", "*.lua" },
				callback = function(args)
					require("conform").format({
						bufnr = args.buf,
						timeout_ms = 5000,
						lsp_fallback = true,
					})
				end,
			})

			-- Manual format keymap
			vim.keymap.set("n", "<leader>f", function()
				require("conform").format({
					async = true,
					lsp_fallback = true,
					timeout_ms = 5000,
				})
			end, { desc = "Format file" })
		end,
	},

	--autoclosing tags for react
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup()
		end,
	},

	-- Plugin spec for lazy.nvim
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		main = "ibl", -- 👈 this is required in v3
		opts = {
			indent = { char = "│" },
			scope = { enabled = true, show_start = true, show_end = false },
		},
	},

	-- Copilot core
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false }, -- disable inline ghost text
				panel = { enabled = false }, -- disable Copilot panel
			})
		end,
	},

	-- Bridge between Copilot and nvim-cmp
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	-- Copilot Chat
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- you already have this
			{ "nvim-lua/plenary.nvim" },
		},
		build = "make tiktoken", -- required for token counting
		opts = {
			debug = false, -- set true to see logs if something breaks
			-- You can also configure window layout here
			window = {
				layout = "vertical", -- or 'vertical', 'horizontal'
				-- width = 0.8,
				-- height = 0.8,
				width = 40,
			},
		},
		config = function(_, opts)
			require("CopilotChat").setup(opts)
		end,
	},

	-- Git integration
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				current_line_blame = true, -- Show blame on current line
				current_line_blame_opts = {
					delay = 500, -- Show after 0.5s
				},
			})
		end,
	},

	{
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Other plugins
	{
		"akinsho/bufferline.nvim",
		config = function()
			require("bufferline").setup()
		end,
	},
	{
		"folke/noice.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				presets = {
					bottom_search = true,
					command_palette = false,
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = true,
				},
			})
			local notify = require("notify")
			notify.setup({
				stages = "fade_in_slide_out",
				timeout = 3000,
				background_colour = "#000000",
				render = "minimal",
			})
			vim.notify = notify
		end,
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure()
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("trouble").setup()
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup()
		end,
	},
	{ "wakatime/vim-wakatime", lazy = false },
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{ "williamboman/mason-lspconfig.nvim" },
	-- LSP setup
	--   {
	--     "neovim/nvim-lspconfig",
	--     dependencies = {
	--       "williamboman/mason.nvim",
	--       "williamboman/mason-lspconfig.nvim",
	--     },
	--     config = function()
	--       local mason_lspconfig = require("mason-lspconfig")
	--       local lspconfig = require("lspconfig")
	--
	--       mason_lspconfig.setup {
	--         ensure_installed = { "clangd", "lua_ls", "pyright","ts_ls","tailwindcss","eslint" },
	--         automatic_installation = true,
	--       }
	--
	--       -- Manually loop over installed servers
	-- for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
	--   lspconfig[server].setup {
	--     capabilities = require("cmp_nvim_lsp").default_capabilities(),
	--   }
	-- end
	--
	--     end
	--   },
	-- LSP setup
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			-- Get default capabilities for LSP
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Setup mason-lspconfig with handlers
			require("mason-lspconfig").setup({
				ensure_installed = { "clangd", "lua_ls", "pyright", "ts_ls", "tailwindcss", "eslint" },
				automatic_installation = true,
				handlers = {
					-- Default handler for all servers
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,
				},
			})
		end,
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				shell = "/usr/bin/zsh", -- keep your preferred shell
				open_mapping = [[<C-\>]], -- easier than <leader>`
				insert_mappings = true,
				direction = "horizontal", -- default
				float_opts = { border = "curved" },
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,
			})
		end,
	},

	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	-- { "windwp/nvim-autopairs", event = "InsertEnter", config = function() require("nvim-autopairs").setup() end },
	-- Better autopairs config
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local npairs = require("nvim-autopairs")
			npairs.setup({
				check_ts = true, -- Use treesitter
				fast_wrap = {
					map = "<M-e>", -- Alt+e to wrap selection
				},
			})

			-- Integration with nvim-cmp
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	--[[  { "neovim/nvim-lspconfig", config = function() require("lspconfig").clangd.setup {} end }, ]]
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),

				sources = cmp.config.sources({
					{ name = "copilot" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
})
