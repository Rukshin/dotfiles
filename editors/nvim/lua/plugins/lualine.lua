return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "catppuccin/nvim" },
    config = function()
       require('lualine').setup({
         options = {
           theme = 'auto'
         }
       })
     end
}
