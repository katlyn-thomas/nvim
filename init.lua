require("kat")

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-j>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})


local lsp_configs = {
    pyright = {},
    eslint = {},
    gdscript = {},
    rust_analyzer = {},
    tailwindcss = {},
    taplo = {},
    tsserver = {},
    volar = {
        filetypes = {
            'typescript',
            'javascript',
            'javascriptreact',
            'typescriptreact',
            'vue',
            'json'
        }
    },
    sumneko_lua = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' }
                }
            }
        }
    }
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function ()
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer=0})
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer=0})
    vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, {buffer=0})
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {buffer=0})
    vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_next, {buffer=0})
    vim.keymap.set('n', '<leader>dk', vim.diagnostic.goto_prev, {buffer=0})
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, {buffer=0})
end

for server, lsp_config in pairs(lsp_configs) do
    local config = {}
    config[on_attach] = on_attach
    config[capabilities] = capabilities

    for k, v in pairs(lsp_config) do
        config[k] = v
    end

    require('lspconfig')[server].setup(config)
end

require('lualine').setup {
  options = {
    theme = 'tokyonight'
  }
}

require("telescope").setup {
  extensions = {
    file_browser = {
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  },
}

require("telescope").load_extension "file_browser"

vim.api.nvim_set_keymap(
  "n",
  "<space>fb",
  "<cmd>Telescope file_browser<cr>",
  { noremap = true }
)
