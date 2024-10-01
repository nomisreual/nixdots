-- return {
--   'Mofiqul/dracula.nvim',
--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000, -- make sure to load this before all the other start plugins
--   config = function()
--     vim.cmd.colorscheme 'dracula'
--
--     vim.cmd.hi 'Comment gui=none'
--   end,
-- }
--
return {
  'rose-pine/neovim',
  name = 'rose-pine',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    vim.cmd.colorscheme 'rose-pine-moon'
  end,
}
