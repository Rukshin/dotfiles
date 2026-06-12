vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.scrolloff = 8

vim.opt.swapfile = false

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- Exit Insert mode without reaching for Esc
vim.keymap.set('i', 'jk', '<Esc>')

vim.filetype.add({
  pattern = {
    [".*/%.github/workflows/.*%.ya?ml"] = "yaml.github",
  },
})

