local opt = vim.opt
local g = vim.g
local map = vim.keymap.set

-- disable newrw 
g.loaded_netrw = 1 
g.loaded_netrwPlugin = 1

-- leader
g.mapleader = ' '

-- NvimTree
local tree_api = require "nvim-tree.api"

map('n', '<Leader>e', tree_api.tree.toggle)


-- leader
g.mapleader = ' '

-- gui
opt.termguicolors = true
opt.number = true 
opt.colorcolumn = '88'
opt.mouse = 'a'
vim.cmd("colorscheme palenight")

-- tabs etc
opt.tabstop = 2 
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- undo
opt.undofile = true
opt.undodir = '.undo'




-- nvim tree
require('nvim-tree').setup {
    sort_by = "case_sensitive",
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
}

-- lsp
local lspconfig = require('lspconfig')
lspconfig.ruff_lsp.setup {}
lspconfig.rust_analyzer.setup {}

vim.keymap.set('n', '<Leader>ll', vim.diagnostic.open_float)
vim.keymap.set('n', '<Leader>lk', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<Leader>lj', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Leader>lq', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<Leader>gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<Leader>gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<Leader>lk', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<Leader>gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<Leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<Leader>la', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<Leader>lf', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- lualine
local function lsp_servers() 
  local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }
  if #buf_clients == 0 then
    return "LSP Inactive"
  end
  local buf_client_names = {}
  for _, client in pairs(buf_clients) do
    table.insert(buf_client_names, client.name)
  end
  local unique_client_names = table.concat(buf_client_names, ", ")
  local language_servers = string.format("[%s]", unique_client_names)
  return language_servers
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'palenight',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename', lsp_servers},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'},
  }
}


-- Comment.nvim

require('Comment').setup {
}

local comment_api = require "Comment.api"
local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
-- map('v', '<Leader>/', comment_api.call('toggle.linewise', 'g@'), { expr = true })
map('x', '<leader>/', function()
  vim.api.nvim_feedkeys(esc, 'nx', false)
  comment_api.toggle.linewise(vim.fn.visualmode())
end)

map('x', '<leader>\\', function()
  vim.api.nvim_feedkeys(esc, 'nx', false)
  comment_api.toggle.blockwise(vim.fn.visualmode())
end)



map('n', '<leader>/', comment_api.toggle.linewise.current)
