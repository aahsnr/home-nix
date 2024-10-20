

-- Vimtex configuration.
vim.g.vimtex_view_general_viewer = "zathura"
vim.g.vimtex_quickfix_enabled = 0

-- Setup cmp.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("LaTeXGroup", { clear = true }),
  pattern = "tex",
  callback = function()
    require("user.cmp")
  end,
})
