-- Automatically open nvim-tree for the directory passed in `nvim .`
vim.cmd([[
  augroup NvimTreeAutoOpen
    autocmd!
    autocmd VimEnter * if argc() == 0 || isdirectory(argv(0)) | execute 'cd ' . argv(0) | NvimTreeToggle | endif
  augroup END
]])
