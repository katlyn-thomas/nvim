require("kat")
-- Setup nvim-cmp.
local cmp = require 'cmp'
local luasnip = require 'luasnip'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

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
    completion = {
        autocomplete = false
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
else
                fallback()
            end
        end, { 'i', 's' }),
        -- ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-b>'] = cmp.mapping.abort(),
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
    tailwindcss = {},
    taplo = {},
    tsserver = {},
    marksman = {},
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
                runtime = {
                    version = 'LuaJIT'
                },
                diagnostics = {
                    globals = { 'vim', 'client' }
                }
            }
        }
    }
}

for server, lsp_config in pairs(lsp_configs) do
    local config = {
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function()
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = 0 })
            vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, { buffer = 0 })
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = 0 })
            vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_next, { buffer = 0 })
            vim.keymap.set('n', '<leader>dk', vim.diagnostic.goto_prev, { buffer = 0 })
            vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { buffer = 0 })
            vim.keymap.set('n', '<leader>l', vim.lsp.buf.formatting, { buffer = 0 })
        end,
    }

    for k, v in pairs(lsp_config) do
        config[k] = v
    end

    require('lspconfig')[server].setup(config)
end

--Rust Tools
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = 0 })
        vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, { buffer = 0 })
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = 0 })
        vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_next, { buffer = 0 })
        vim.keymap.set('n', '<leader>dk', vim.diagnostic.goto_prev, { buffer = 0 })
        vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { buffer = 0 })
        vim.keymap.set('n', '<leader>l', vim.lsp.buf.formatting, { buffer = 0 })

      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

require('lualine').setup()

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

require('matchparen').setup({
    on_startup = true,
    hl_group = 'MatchParen',
})

require('Comment').setup()

function Zen ()
    local width = math.floor((vim.o.columns / 3) + 0.5)
    if width < 120 then
        width = 120
    end
    require('zen-mode').toggle({
        window = {
            width = width
        }
    })
end

vim.keymap.set('n', '<leader>z', Zen)

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
require("catppuccin").setup()

require("null-ls").setup({
    sources = {
        require("null-ls").builtins.diagnostics.vale,
    },
})

require("nvim-tree").setup()

local nvim_tree_events = require('nvim-tree.events')
local bufferline_state = require('bufferline.state')

local function get_tree_size()
  return require'nvim-tree.view'.View.width
end

nvim_tree_events.subscribe('TreeOpen', function()
  bufferline_state.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('Resize', function()
  bufferline_state.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('TreeClose', function()
  bufferline_state.set_offset(0)
end)

