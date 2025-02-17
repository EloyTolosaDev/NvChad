-- Automatically open nvim-tree for the directory passed in `nvim .`
vim.cmd([[
  augroup NvimTreeAutoOpen
    autocmd!
    autocmd VimEnter * if argc() == 0 || isdirectory(argv(0)) | execute 'cd ' . argv(0) | NvimTreeToggle | endif
  augroup END
]])

dofile(vim.g.base46_cache .. "nvimtree")
return {
  filters = { dotfiles = false },
  disable_netrw = true,
  hijack_cursor = true,
  -- sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,  -- Ensure this is set to true to update root
  },
  -- update_cwd = true,  -- Ensure this is enabled to sync cwd with the file tree
  view = {
    width = 30,
    preserve_window_proportions = true,
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    indent_markers = { enable = true },
    icons = {
      glyphs = {
        default = "󰈚",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
        },
        git = { unmerged = "" },
      },
    },
  },
}
