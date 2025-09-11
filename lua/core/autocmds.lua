-- Auto-insert boilerplate in new C++ files
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.cpp",
  callback = function()
    local template = vim.fn.expand("~/.config/nvim/templates/cpp_boilerplate.cpp")
    vim.cmd("0r " .. template)
  end
})
