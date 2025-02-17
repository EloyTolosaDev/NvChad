local autocmd = vim.api.nvim_create_autocmd

-- Automatically set cwd when opening a directory using nvim
vim.api.nvim_create_augroup("NvimTreeAutoCwd", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  group = "NvimTreeAutoCwd",
  callback = function()
    local argv = vim.fn.argv(0)  -- Get the first argument passed to Neovim
    if vim.fn.argc() == 1 and vim.fn.isdirectory(argv) == 1 then
      vim.cmd("cd " .. vim.fn.fnameescape(argv))  -- Change to the directory safely
      require("nvim-tree.api").tree.open()  -- Open NvimTree
    end
  end,
})


-- Automatically open nvim-tree for the directory passed in `nvim .`
autocmd("VimEnter", {
  callback=function()
    require("nvim-tree.api").tree.open()
  end,
})

autocmd("VimEnter", {
  callback = function()
    vim.defer_fn(function()
      vim.cmd("Lazy sync")
    end
    , 100)
  end,
})

-- user event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      vim.api.nvim_del_augroup_by_name "NvFilePost"

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})

        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})
