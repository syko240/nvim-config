-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  -- NOTE: nixCats: return true only if category is enabled, else false
  enabled = require('nixCatsUtils').enableForCategory("kickstart-neo-tree"),
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
  },
  init = function()
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        if vim.fn.argc(-1) == 1 then
          local stat = vim.uv.fs_stat(vim.fn.argv(0))
          if stat and stat.type == 'directory' then
            require('neo-tree.command').execute({ action = 'show', position = 'left' })
            vim.cmd('wincmd l')
          end
        end
      end,
    })
  end,
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
