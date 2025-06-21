-- Basic settings
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

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
      require("nvim-tree").setup()
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
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end
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
       shell = "/usr/bin/zsh",  -- 👈 Use your zsh path
      direction = "horizontal", -- could be 'horizontal' if you prefer split
      float_opts = {
        border = "curved",
      },
      open_mapping = [[<leader>`]], -- Ctrl + backtick
      insert_mappings = true, -- allows <Esc> to exit terminal mode
    })
  end
},
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").clangd.setup {}
    end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip"
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }
        }),
      })
    end
  }
})

-- Treesitter config
require("nvim-treesitter.configs").setup {
  highlight = { enable = true },
  ensure_installed = { "cpp", "c", "lua" }
}

-- Keybindings
vim.keymap.set("n", "<F5>", function()
  vim.cmd("w")  -- Save file
  local filename = vim.fn.expand("%:r")
  vim.cmd("!g++ % -o " .. filename)  -- Compile
  vim.cmd("botright split | terminal ./" .. filename)  -- Open terminal at bottom
end)

vim.keymap.set("n", "<F8>", ":w<CR>:!clang-format -i %<CR>")
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
