local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"savq/paq-nvim", -- Let Paq manage itself

	-- Git tools
	'tpope/vim-fugitive',
	'airblade/vim-gitgutter',
	{
		"kdheepak/lazygit.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function() require("telescope").load_extension("lazygit") end,
	},

	-- LSP Support
	'neovim/nvim-lspconfig',
	'hrsh7th/cmp-nvim-lsp',
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},

	-- Autocompletion + sources
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-vsnip',
	'hrsh7th/vim-vsnip',
	'hrsh7th/vim-vsnip-integ',
	'hrsh7th/cmp-nvim-lua',
	'simrat39/symbols-outline.nvim',
	'hrsh7th/cmp-emoji',
	'kdheepak/cmp-latex-symbols',

	'fatih/vim-go',

	-- navigation
	'nvim-lua/plenary.nvim',
	'nvim-telescope/telescope.nvim',
	'nvim-telescope/telescope-fzf-native.nvim',
	"nvim-tree/nvim-tree.lua",
	"nvim-tree/nvim-web-devicons",

	-- Colors
	'sainnhe/sonokai',
}, {})

vim.cmd('colorscheme sonokai')
vim.wo.number = true
vim.o.ruler = true
vim.o.colorcolumn = "80" -- vertical line at 81

-- Share clipboard outside of vim
vim.opt.clipboard = "unnamedplus"

-- Folding
vim.opt.foldmethod = "indent"

-- map the leader key
vim.g.mapleader = ' '

local map = vim.api.nvim_set_keymap

options = { noremap = true }
map('n', '<leader>h', ':nohlsearch<cr>', options)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, options)

-- Move between panels easily
map('n', '<C-J>', '<C-W><C-J>', options)
map('n', '<C-K>', '<C-W><C-K>', options)
map('n', '<C-L>', '<C-W><C-L>', options)
map('n', '<C-H>', '<C-W><C-H>', options)

-- Escape terminal
map('t', '<Esc>', '<C-\\><C-n>', options)

-- Telescope config
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>fS', builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})

-- Toggle Files
require('nvim-tree').setup()
vim.keymap.set('n', '<leader>e', require 'nvim-tree.api'.tree.toggle, {})

vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', {})

-- LSP
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})

local cmp = require 'cmp'
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'emoji' },
		{ name = 'vsnip' },
		{ name = 'latex_symbols' },
	}, {
		{ name = 'buffer' },
	})
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format()
			end,
		})
	end
end

require 'lspconfig'.lua_ls.setup { on_attach = on_attach, capabilities = lsp_capabilities }
require 'lspconfig'.gopls.setup { on_attach = on_attach, capabilities = lsp_capabilities }
require 'lspconfig'.rust_analyzer.setup { on_attach = on_attach, capabilities = lsp_capabilities }
require 'lspconfig'.clangd.setup { on_attach = on_attach, capabilities = lsp_capabilities }
require 'lspconfig'.nil_ls.setup { on_attach = on_attach, capabilities = lsp_capabilities,
	settings = { ['nil'] = { formatting = { command = { "nixpkgs-fmt" } } } },
}
require 'lspconfig'.nil_ls.setup { on_attach = on_attach, capabilities = lsp_capabilities }
require 'lspconfig'.bashls.setup { on_attach = on_attach, capabilities = lsp_capabilities }
require 'lspconfig'.jedi_language_server.setup { on_attach = on_attach, capabilities = lsp_capabilities }
require 'lspconfig'.pyright.setup { on_attach = on_attach, capabilities = lsp_capabilities }
require 'lspconfig'.eslint.setup { on_attach = on_attach, capabilities = lsp_capabilities }
require 'lspconfig'.eslint.setup { on_attach = on_attach, capabilities = lsp_capabilities }
require 'lspconfig'.tsserver.setup { on_attach = on_attach, capabilities = lsp_capabilities }
require 'lspconfig'.jsonls.setup { on_attach = on_attach, capabilities = lsp_capabilities, }


require("symbols-outline").setup()
vim.keymap.set('n', '<leader>o', ":SymbolsOutline<CR>", {})

vim.cmd [[
" Command to store link to current line in bitbucket UI in the system's
" clipboard.
function! GetSourceLink() range
  let giturls={'git@stash.cfops.it:7999': 'bitbucket.cfdata.org/projects', 'git@bitbucket.cfdata.org:7999': 'bitbucket.cfdata.org/projects', 'git.kernel.org': "elixir.bootlin.com", "github.com": "github.com", "git.netflix.net": "github.netflix.net"}

  let remote=system("git remote get-url origin")
  let commit=system("git rev-parse HEAD")
  let domain=split(remote, '/')[2]
  let project=split(remote, '/')[-2]
  let repo=split(split(remote, '/')[-1], '\.')[0]

  if domain ==# "git.kernel.org"
    let @+=join(["https:/", giturls[domain], "linux/latest/source" , @%.'#L'.line('.')], "/")
  "elseif (domain ==# "github.com" || domain ==# "github.netflix.net")
  else " bitbucket
    let @+=join(["https:/", giturls[domain], project, repo, "tree", commit, @%.'#L'.a:firstline.'-'.'L'.a:lastline ], "/")
  "  let @+=join(["https:/", giturls[domain], project, "repos", repo ,"browse", @%.'?at='.commit.'#'.a:firstline.'-'.a:lastline], "/")
  endif
endfunction
]]

map('', '<leader>bb', ':call GetSourceLink()<CR>', options)
