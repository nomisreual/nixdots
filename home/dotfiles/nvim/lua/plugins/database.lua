return {
  'kristijanhusak/vim-dadbod-ui',
  keys = {
    { '<leader>db', '<cmd>:DBUIToggle<cr>', desc = 'DBUI' },
  },
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
}
