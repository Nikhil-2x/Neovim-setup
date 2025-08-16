-- -- Basic settings
-- vim.g.mapleader = " "
-- vim.opt.number = true
-- vim.opt.relativenumber = true
-- vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true

-- -- Plugin manager (Lazy.nvim)
-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--   vim.fn.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "https://github.com/folke/lazy.nvim.git",
--     lazypath,
--   })
-- end
-- vim.opt.rtp:prepend(lazypath)

-- -- Plugins
-- require("lazy").setup({
--   {
--     "nvim-treesitter/nvim-treesitter",
--     build = ":TSUpdate"
--   },
--   {
--     "nvim-tree/nvim-tree.lua",
--     dependencies = { "nvim-tree/nvim-web-devicons" },
--     config = function()
--       require("nvim-tree").setup()
--     end
--   },
--   {
--     "nvim-lualine/lualine.nvim",
--     dependencies = { "nvim-tree/nvim-web-devicons" },
--     config = function()
--       require("lualine").setup()
--     end
--   },
--   {
--     "folke/tokyonight.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--       vim.cmd.colorscheme("tokyonight")
--     end
--   },
--   {
--     "williamboman/mason.nvim",
--     build = ":MasonUpdate",
--     config = function()
--       require("mason").setup()
--     end
--   },
--   {
--   "akinsho/toggleterm.nvim",
--   version = "*",
--   config = function()
--     require("toggleterm").setup({
--        shell = "/usr/bin/zsh",  -- 👈 Use your zsh path
--       direction = "horizontal", -- could be 'horizontal' if you prefer split
--       float_opts = {
--         border = "curved",
--       },
--       open_mapping = [[<leader>`]], -- Ctrl + backtick
--       insert_mappings = true, -- allows <Esc> to exit terminal mode
--     })
--   end
-- },
--   {
--     "neovim/nvim-lspconfig",
--     config = function()
--       require("lspconfig").clangd.setup {}
--     end
--   },
--   {
--     "hrsh7th/nvim-cmp",
--     dependencies = {
--       "hrsh7th/cmp-nvim-lsp",
--       "L3MON4D3/LuaSnip",
--       "saadparwaiz1/cmp_luasnip"
--     },
--     config = function()
--       local cmp = require("cmp")
--       cmp.setup({
--         snippet = {
--           expand = function(args)
--             require("luasnip").lsp_expand(args.body)
--           end,
--         },
--         mapping = cmp.mapping.preset.insert({
--           ['<Tab>'] = cmp.mapping.select_next_item(),
--           ['<S-Tab>'] = cmp.mapping.select_prev_item(),
--           ['<CR>'] = cmp.mapping.confirm({ select = true }),
--         }),
--         sources = cmp.config.sources({
--           { name = "nvim_lsp" },
--           { name = "luasnip" }
--         }),
--       })
--     end
--   }
-- })

-- -- Treesitter config
-- require("nvim-treesitter.configs").setup {
--   highlight = { enable = true },
--   ensure_installed = { "cpp", "c", "lua" }
-- }

-- -- Keybindings
-- vim.keymap.set("n", "<F5>", function()
--   vim.cmd("w")  -- Save file
--   local filename = vim.fn.expand("%:r")
--   vim.cmd("!g++ % -o " .. filename)  -- Compile
--   vim.cmd("botright split | terminal ./" .. filename)  -- Open terminal at bottom
-- end)

-- vim.keymap.set("n", "<F8>", ":w<CR>:!clang-format -i %<CR>")
-- vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })


-- Basic settings
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 6
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"

-- Plugin manager (Lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },
  {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      filters = {
        dotfiles = false, -- set to false to show hidden files
        git_ignored = false,
      }
    })
  end
},
{
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup()
    end
},



{
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 2000,
  config = function()
    require("kanagawa").setup({
      background = {
        dark = "dragon", -- Default for :colorscheme kanagawa
        light = "lotus"
      },
      transparent = false
    })
    vim.cmd("colorscheme kanagawa")
  end
},
{
  "EdenEast/nightfox.nvim",
   config = function()
    require("nightfox").setup({})
    -- choose nightfox, nordfox, dawnfox, dayfox, duskfox, carbonfox
  end
},
-- Other themes installed but NOT auto-loaded
{
  "marko-cerovac/material.nvim",
    config = function()
     -- darker, lighter, oceanic, deep ocean, palenight
    require("material").setup()
  end
},
{
  "craftzdog/solarized-osaka.nvim",
  config = function()
    require("solarized-osaka").setup({})
    -- No vim.cmd.colorscheme here
  end
},
{
  "folke/tokyonight.nvim",
  config = function() end
},
{
  "catppuccin/nvim", name = "catppuccin",
  config = function() end
},
{
  "navarasu/onedark.nvim",
  config = function() end
},
{
  "shaunsingh/moonlight.nvim",
  config = function() end
},
{
  "wakatime/vim-wakatime",
  lazy = false, -- make sure it's loaded immediately
},


  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end
  },
  {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
       shell = "/usr/bin/zsh",  -- Use your zsh path
      direction = "horizontal", -- could be 'horizontal' if you prefer split
      float_opts = {
        border = "curved",
      },
      open_mapping = [[<leader>`]], -- Ctrl + backtick
      insert_mappings = true, -- allows <Esc> to exit terminal mode
    })
  end
},{
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup()
  end
},
{
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup()
  end
},
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").clangd.setup {}
    end
  },



 -- Autocompletion engine
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
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end
} 
})


-- Treesitter config
require("nvim-treesitter.configs").setup {
  highlight = {enable = true}, ensure_installed = {"cpp", "c", "lua"}
}



--Keybindings 
vim.keymap .set("n", "<F5>",function()
 vim.cmd("w")-- Save file 
 local filename =vim.fn.expand("%:r")
 vim.cmd("!g++ % -o "..filename)-- Compile 
 vim.cmd("botright split | terminal ./"..filename)-- Open terminal at bottom 
end)

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.cpp",
  callback = function()
    local template = vim.fn.expand("~/.config/nvim/templates/cpp_boilerplate.cpp")
    vim.cmd("0r " .. template)
  end
})

          

vim.keymap.set("n", "<F8>", ":w<CR>:!clang-format -i %<CR>") 
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", {noremap = true, silent = true}) 
vim.keymap.set("n", "<leader>bo",":0r ~/.config/nvim/templates/cpp_boilerplate.cpp<CR>")


vim.keymap.set('n', '<leader>p', function()
  local file = vim.fn.expand('%:p')
  vim.fn.jobstart({'xdg-open', file}, {detach = true})
end, {desc = 'Open current file externally'})

