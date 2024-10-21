local status_ok, impatient = pcall(require, "magma-nvim")
if not status_ok then
  return
end

vim.g.magma_image_provider = "ueberzug"
vim.g.magma_automatically_open_output = false
vim.g.magma_wrap_output = true
vim.g.magma_output_window_borders = true
vim.g.magma_cell_highlight_group = "CursorLine"

-- Where to save/load with :MagmaSave and :MagmaLoad.
-- The generated file is placed in this directory, with the filename itself
-- being the buffer's name, with % replaced by %% and / replaced by %, and
-- postfixed with the extension .json.
vim.g.magma_save_path = vim.fn.stdpath "data" .. "/magma"
