-- Global options
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.colorcolumn = "120"
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Setup leader and localleader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    "folke/tokyonight.nvim", -- Decent mostly dark color scheme
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        on_colors = function(colors)
          colors.bg = "#000000" -- Set the bg color to pure black to increase contrast
        end
      })
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
  {
    "neovim/nvim-lspconfig", -- Used to easily configure nvim to manage LSPs
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
    },
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8', -- Super fast search
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    "rhysd/devdocs.vim", -- Quick integration with devdocs.io
    keys = {
      { "<leader>dd", "<Plug>(devdocs-under-cursor)", desc = "Open devdocs.io" },
    }
  },
  {
    "zbirenbaum/copilot-cmp", -- Lets you use Copilot in nvim
    event = "InsertEnter",
    config = function () require("copilot_cmp").setup() end,
    dependencies = {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      config = function()
        require("copilot").setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
        })
      end,
    },
  },
  {
    'hrsh7th/nvim-cmp', -- Main autocompletion plugin
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
  },
  {
    "robitx/gp.nvim", -- Wraps various LLMs in a nice chat interface
    config = function()
      require("gp").setup({
        providers = {
          copilot = {
            endpoint = "https://api.githubcopilot.com/chat/completions",
            secret = { "bash", "-c", "cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'" },
          }
        }
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter", -- Used for syntax awareness in most plugins
    build = ":TSUpdate",
    config = function () 
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "ruby", "diff", "javascript", "html", "css", "dockerfile", "fish", "python", "gitcommit", "gitignore", "go", "ssh_config", "markdown", "markdown_inline" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },  
      })
    end,
  },
  {
    "RRethy/nvim-treesitter-endwise", -- Smart block completion using treesitter
    config = function()
      require("nvim-treesitter.configs").setup({
        endwise = { enable = true },
      })
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "folke/todo-comments.nvim", -- Adds nice highlights to special comments
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "tpope/vim-surround", event = { "BufReadPost", "BufNewFile" } }, -- Classic plugin that adds verbs for manipulating pairs of characters
  { 'windwp/nvim-autopairs', event = "InsertEnter", config = true }, -- Automatically inserts closing pairs
  {'nvim-lualine/lualine.nvim'}, -- Nice little status line plugin
  {'lukas-reineke/lsp-format.nvim'}, -- Simple way to get the LSPs to format their respective languages
  {'lewis6991/gitsigns.nvim'}, -- Adds nice inline git markers to show edits
}

require("lazy").setup(plugins)

-- Tell Mason which LSPs to autoinstall
local mason_lspconfig = require("mason-lspconfig")
local servers = {
  ruby_lsp = {},
  cssls = {},
  tailwindcss = {},
}
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

-- Setup LSP formatting
require("lsp-format").setup {}
local on_attach = function(client, bufnr)
    require("lsp-format").on_attach(client, bufnr)
end

-- Setup LSPs
local capabilities = vim.lsp.protocol.make_client_capabilities()
mason_lspconfig.setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}

-- Setup autocompletion
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'copilot' },
    { name = 'buffer' },
  })
})


require('lualine').setup()
require('gitsigns').setup()
require('todo-comments').setup()

local wk = require("which-key")

wk.add({
  { "<F7>", ":tabp<CR>", desc = "Previous Tab" },
  { "<F8>", ":tabn<CR>", desc = "Next Tab" },
  { "<Leader>w", ":w<CR>", desc = "Save Buffer" },
  { "<Leader>q", ":wq<CR>", desc = "Save and Quit" },
  { "<Leader>j", ":bnext<CR>", desc = "Next Buffer" },
  { "<Leader>k", ":bprevious<CR>", desc = "Previous Buffer" },
  { "<Leader>ff", ":Telescope find_files<CR>", desc = "Find Files" },
  { "<Leader>fg", ":Telescope live_grep<CR>", desc = "Live Grep" },
  { "<Leader>fb", ":Telescope buffers<CR>", desc = "Find Buffers" },
  { "<Leader>gn", ":GpChatNew", desc = "Open new LLM chat" },
  { "<Leader>gp", ":GpChatPaste", desc = "Paste selection into latest chat" },
  { "<Leader>gf", ":GpChatFinder", desc = "Search through LLM chats" },
  { "<Leader>gr", ":GpChatRewrite", desc = "Rewrite the current selection with the active LLM" },
  {
    mode = {'i'},
    {"jk", "<Esc>", desc = "Exit Insert Mode"},
    {"kj", "<Esc>", desc = "Exit Insert Mode"},
  }
})
