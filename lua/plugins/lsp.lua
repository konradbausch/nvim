return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },

  config = function()
    require("mason").setup({
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry"
      }
    })

    -- add language servers here, to have them automatically installed--
    require("mason-lspconfig").setup({
      ensure_installed = { "pyright", "lua_ls" }
    })

    local cmp = require("cmp")

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
      }),

      completion = { completeopt = 'menu,menuone,noinsert' },
      sources = {
        {
          name = 'lazydev',
          -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
          group_index = 0,
        },
        { name = 'nvim_lsp' },
      }
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    local lsp_config = require("lspconfig")

    lsp_config.pyright.setup({
      capabilities = capabilities,
    })

    lsp_config.lua_ls.setup {
      capabilities = capabilities,
    }
  end
}
