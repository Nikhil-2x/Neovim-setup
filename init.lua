-- Basic settings
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"

-- Plugin manager (Lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath})
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
}, {
    "nvim-tree/nvim-tree.lua",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        require("nvim-tree").setup({
            filters = {
                dotfiles = false, -- set to false to show hidden files
                git_ignored = false
            }
        })
    end
}, {
    "nvim-lualine/lualine.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        require("lualine").setup()
    end
}, {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 2000,
    config = function()
        require("kanagawa").setup({
            transparent = true, -- transparent background
            dimInactive = true, -- dim inactive windows
            terminalColors = true, -- set terminal colors

            -- Special UI styling
            styles = {
                comments = {
                    italic = true
                },
                keywords = {
                    italic = false
                },
                functions = {
                    bold = true
                },
                variables = {}
            },

            -- UI Elements
            overrides = function(colors)
                return {
                    -- Transparent floating windows
                    NormalFloat = {
                        bg = "none"
                    },
                    FloatBorder = {
                        bg = "none",
                        fg = colors.theme.ui.fg_dim
                    },
                    FloatTitle = {
                        bg = "none",
                        fg = colors.theme.ui.special
                    },

                    -- Telescope customization
                    TelescopeTitle = {
                        fg = colors.palette.springViolet1,
                        bold = true
                    },
                    TelescopePromptNormal = {
                        bg = colors.theme.ui.bg_p1
                    },
                    TelescopePromptBorder = {
                        fg = colors.theme.ui.bg_p1,
                        bg = colors.theme.ui.bg_p1
                    },
                    TelescopeResultsNormal = {
                        bg = colors.theme.ui.bg_m1
                    },
                    TelescopeResultsBorder = {
                        fg = colors.theme.ui.bg_m1,
                        bg = colors.theme.ui.bg_m1
                    },
                    TelescopePreviewNormal = {
                        bg = colors.theme.ui.bg_dim
                    },
                    TelescopePreviewBorder = {
                        fg = colors.theme.ui.bg_dim,
                        bg = colors.theme.ui.bg_dim
                    }
                }
            end
        })

        vim.cmd("colorscheme kanagawa")
    end
}, {
    "EdenEast/nightfox.nvim",
    config = function()
        require("nightfox").setup({})
        -- choose nightfox, nordfox, dawnfox, dayfox, duskfox, carbonfox
    end
}, -- Other themes installed but NOT auto-loaded
{
    "craftzdog/solarized-osaka.nvim",
    config = function()
        require("solarized-osaka").setup({})
        -- No vim.cmd.colorscheme here
    end
}, {
    'sainnhe/sonokai',
    config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        vim.g.sonokai_transparent_background = '2'
        vim.g.sonokai_enable_italic = true
        vim.cmd.colorscheme('sonokai')
    end
}, {
    "folke/tokyonight.nvim",
    config = function()
    end
}, {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
    end
}, -- nvimdev/dashboard-nvim
-- {
--   'nvimdev/dashboard-nvim',
--   event = 'VimEnter',
--   config = function()
--     require('dashboard').setup {
--       theme = 'hyper', -- or 'doom'
--       config = {
--         week_header = {
--        enable = true,
--       },
--       shortcut = {
--         { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
--         {
--           icon = ' ',
--           icon_hl = '@variable',
--           desc = 'Files',
--           group = 'Label',
--           action = 'Telescope find_files',
--           key = 'f',
--         },
--         {
--           desc = ' Apps',
--           group = 'DiagnosticHint',
--           action = 'Telescope app',
--           key = 'a',
--         },
--         {
--           desc = ' dotfiles',
--           group = 'Number',
--           action = 'Telescope dotfiles',
--           key = 'd',
--         },
--       },
--         center = {
--           {
--             icon = '',
--             icon_hl = 'group',
--             desc = 'description',
--             desc_hl = 'group',
--             key = 'shortcut key in dashboard buffer not keymap !!',
--             key_hl = 'group',
--             key_format = ' [%s]', -- `%s` will be substituted with value of `key`
--             action = ''
--           }
--         },
--         footer = {},
--         -- if you want it vertically centered
--         -- dashboard already centers by default
--         -- vertical_center = true  ❌ not supported
--       }
--     }
--   end,
--   dependencies = { { 'nvim-tree/nvim-web-devicons' } }
-- },
-- requires github-cli and colorscript       
{
    "folke/snacks.nvim",
    lazy = false,
    opts = {
        dashboard = {
            sections = {{
                section = "header"
            }, {
                pane = 2,
                section = "terminal",
                cmd = "colorscript -e square",
                height = 5,
                padding = 1
            }, --  Multiple APIs with fallbacks
            {
                pane = 1,
                icon = "💭 ",
                title = "Quote",
                section = "terminal",
                cmd = "(timeout 3s curl -s 'https://zenquotes.io/api/random' | jq -r '.[0].q + \" - \" + .[0].a' 2>/dev/null) || (timeout 3s curl -s 'https://api.quotable.io/random' | jq -r '.content + \" - \" + .author' 2>/dev/null) || (timeout 3s curl -s 'https://dummyjson.com/quotes/random' | jq -r '.quote + \" - \" + .author' 2>/dev/null) || echo 'Code. Learn. Repeat.'",
                height = 4,
                padding = 1,
                ttl = 3600
            }, -- Dynamic system info
            {
                pane = 1,
                icon = " ",
                title = "System Info",
                section = "terminal",
                cmd = "echo \"$(uname -sr) | $(uptime -p) | $(df -h / | awk 'NR==2{print $4\" free\"}')\"",
                height = 3,
                padding = 1,
                ttl = 60 -- refresh every minute
            }, -- Dynamic weather (if you have curl)
            {
                pane = 1,
                icon = "🌤️ ",
                title = "Weather",
                section = "terminal",
                cmd = "curl -s 'https://wttr.in/?format=%l:+%c+%t+%h+%w' 2>/dev/null || echo 'Weather unavailable'",
                height = 2,
                padding = 1,
                ttl = 1800 -- refresh every 30 minutes
            }, -- Today's date with a fun fact
            {
                pane = 1,
                icon = " ",
                title = "Today",
                section = "terminal",
                cmd = "echo \"$(date +'%A, %B %d, %Y') | Day $(date +%j) of $(date +%Y)\"",
                height = 2,
                padding = 1,
                ttl = 3600 -- refresh hourly
            }, {
                section = "keys",
                gap = 1,
                padding = 1
            }, {
                pane = 2,
                icon = " ",
                title = "Recent Files",
                section = "recent_files",
                indent = 2,
                padding = 1
            }, {
                pane = 2,
                icon = " ",
                title = "Projects",
                section = "projects",
                indent = 2,
                padding = 1
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
                indent = 3
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
                indent = 3
            }, -- Show coding activity (if you have a way to track it)
            {
                pane = 1,
                icon = " ",
                title = "Dev Stats",
                section = "terminal",
                cmd = "find . -name '*.cpp' -o -name '*.c' -o -name '*.h' | wc -l | sed 's/^/C++ files: /' && find . -name '*.lua' | wc -l | sed 's/^/Lua files: /'",
                height = 3,
                padding = 1,
                ttl = 300 -- refresh every 5 minutes
            }, -- Show TODO/FIXME count in project
            {
                pane = 2,
                icon = " ",
                title = "TODOs & FIXMEs",
                section = "terminal",
                cmd = "grep -r --include='*.cpp' --include='*.c' --include='*.h' --include='*.lua' -c 'TODO\\|FIXME' . 2>/dev/null | wc -l | sed 's/^/Found: /' | sed 's/$/ items/' || echo 'No TODOs found'",
                height = 2,
                padding = 1,
                ttl = 600 -- refresh every 10 minutes
            }, {
                section = "startup"
            }}
        }
    }
}, {
    "akinsho/bufferline.nvim",
    config = function()
        require("bufferline").setup()
    end
}, {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {"MunifTanjim/nui.nvim", "rcarriga/nvim-notify"},
    config = function()
        -- Setup noice
        require("noice").setup({
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true
                }
            },
            presets = {
                bottom_search = true, -- search in bottom cmdline
                command_palette = false,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = true
            }
        })

        -- Setup notify
        local notify = require("notify")
        notify.setup({
            stages = "fade_in_slide_out", -- smooth animation
            timeout = 3000, -- 3 seconds
            background_colour = "#000000", -- transparent bg
            render = "minimal"
        })

        vim.notify = notify
    end
}, {
    "RRethy/vim-illuminate",
    config = function()
        require("illuminate").configure()
    end
}, {
    "folke/trouble.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        require("trouble").setup()
    end
}, {
    "norcalli/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup()
    end
}, {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        require("which-key").setup()
    end
}, {
    "wakatime/vim-wakatime",
    lazy = false -- make sure it's loaded immediately
}, {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
        require("mason").setup()
    end
}, {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            shell = "/usr/bin/zsh", -- Use your zsh path
            direction = "horizontal", -- could be 'horizontal' if you prefer split
            float_opts = {
                border = "curved"
            },
            open_mapping = [[<leader>`]], -- Ctrl + backtick
            insert_mappings = true -- allows <Esc> to exit terminal mode
        })
    end
}, {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}, {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup()
    end
}, {
    "neovim/nvim-lspconfig",
    config = function()
        require("lspconfig").clangd.setup {}
    end
}, -- Autocompletion engine
{
    "hrsh7th/nvim-cmp",
    dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "L3MON4D3/LuaSnip",
                    "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets"},
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert({
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                ['<CR>'] = cmp.mapping.confirm({
                    select = true
                })
            }),
            sources = cmp.config.sources({{
                name = "nvim_lsp"
            }, {
                name = "luasnip"
            }, {
                name = "buffer"
            }, {
                name = "path"
            }})
        })
    end
}})

-- Treesitter config
require("nvim-treesitter.configs").setup {
    highlight = {
        enable = true
    },
    ensure_installed = {"cpp", "c", "lua"}
}

-- Keybindings 
vim.keymap.set("n", "<F5>", function()
    vim.cmd("w") -- Save file 
    local filename = vim.fn.expand("%:r")
    vim.cmd("!g++ % -o " .. filename) -- Compile 
    vim.cmd("botright split | terminal ./" .. filename) -- Open terminal at bottom 
end)

vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.cpp",
    callback = function()
        local template = vim.fn.expand("~/.config/nvim/templates/cpp_boilerplate.cpp")
        vim.cmd("0r " .. template)
    end
})

vim.keymap.set("n", "<F8>", ":w<CR>:!clang-format -i %<CR>")
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", {
    noremap = true,
    silent = true
})
vim.keymap.set("n", "<leader>bo", ":0r ~/.config/nvim/templates/cpp_boilerplate.cpp<CR>")

vim.keymap.set('n', '<leader>p', function()
    local file = vim.fn.expand('%:p')
    vim.fn.jobstart({'xdg-open', file}, {
        detach = true
    })
end, {
    desc = 'Open current file externally'
})

-- Keybindings for Trouble:
-- Toggle Trouble
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", {
    silent = true
})

-- Go to next/previous diagnostic
vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_next()
end, {
    silent = true
})
vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_prev()
end, {
    silent = true
})

vim.keymap.set("n", "<leader>nd", function()
    require("notify").dismiss({
        silent = true,
        pending = true
    })
end, {
    desc = "Dismiss notifications"
})
