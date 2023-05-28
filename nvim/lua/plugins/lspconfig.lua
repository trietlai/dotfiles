-- check mason-lspconfig for LSP being used
local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

lspconfig.bashls.setup {}

-- clangd may not work properly see the link below:
-- https://stackoverflow.com/questions/74785927/clangd-doesnt-recognize-standard-headers
lspconfig.clangd.setup {}

-- lspconfig.neocmake.setup {}
lspconfig.cmake.setup {}

lspconfig.jsonls.setup {}
lspconfig.jdtls.setup {}

lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

lspconfig.marksman.setup {}
lspconfig.pyright.setup {}
lspconfig.rust_analyzer.setup {}
lspconfig.yamlls.setup {}
lspconfig.vimls.setup {}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
		local bufnr = ev.buf
		local map = function(m, lhs, rhs, desc)
			local opts = {buffer = bufnr, desc = desc}
			vim.keymap.set(m, lhs, rhs, opts)
		end

		local buf_command = vim.api.nvim_buf_create_user_command

		buf_command(bufnr, 'LspFormat', function()
			vim.lsp.buf.format()
		end, {desc = 'Format buffer with language server'})

		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- LSP actions
		map('n', 'K', vim.lsp.buf.hover, "hover symbol under cursor")
		map('n', 'gd', vim.lsp.buf.definition, "jump to definition")
		map('n', 'gD', vim.lsp.buf.declaration, "jump to declaration")
		map('n', 'gi', vim.lsp.buf.implementation, "list all implementations")
		map('n', 'go', vim.lsp.buf.type_definition, "jump to type definition")
		map('n', 'gr', vim.lsp.buf.references, "list all references")
		map('n', 'gs', vim.lsp.buf.signature_help, "display symbol signature")
		map('n', 'gR', vim.lsp.buf.rename, "rename all references")

		map({'n', 'x'}, 'g=', function()
			vim.lsp.buf.format { async = true }
		end, "format buffer")

		map('n', 'ga', vim.lsp.buf.code_action, "select code action")
		--map('x', 'ga', vim.lsp.buf.range_code_action, "select code action")

		-- Diagnostics
		map('n', 'gl', vim.diagnostic.open_float, "open diagnostic list")
		map('n', '[d', vim.diagnostic.goto_prev, "jump to previous error")
		map('n', ']d', vim.diagnostic.goto_next, "jump to next error")
    end,
})

local function lsp_settings()
	vim.diagnostic.config({
		severity_sort = true,
		float = {border = 'rounded'},
	})

	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
		vim.lsp.handlers.hover,
		{border = 'rounded'}
	)

	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
		vim.lsp.handlers.signature_help,
		{border = 'rounded'}
	)

	local command = vim.api.nvim_create_user_command

	command('LspWorkspaceAdd', function()
		vim.lsp.buf.add_workspace_folder()
	end, {desc = 'Add folder to workspace'})

	command('LspWorkspaceList', function()
		vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, {desc = 'List workspace folders'})

	command('LspWorkspaceRemove', function()
		vim.lsp.buf.remove_workspace_folder()
	end, {desc = 'Remove folder from workspace'})
end

lsp_settings()

---
-- Autocompletion
---

local cmp = require('cmp')
local cmp_select_opts = {behavior = cmp.SelectBehavior.Select}

local cmp_config = {
	sources = { {name = 'nvim_lsp'}, },
	mapping = {
		-- confirm selection
		['<C-y>'] = cmp.mapping.confirm({select = true}),

		-- cancel completion
		['<C-e>'] = cmp.mapping.abort(),

		-- scroll up and down in the completion documentation
		['<C-u>'] = cmp.mapping.scroll_docs(-5),
		['<C-d>'] = cmp.mapping.scroll_docs(5),

		-- navigate items on the list
		['<Up>'] = cmp.mapping.select_prev_item(select_opts),
		['<Down>'] = cmp.mapping.select_next_item(select_opts),

		-- if completion menu is visible, go to the previous item
		-- else, trigger completion menu
		['<C-p>'] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			else
				cmp.complete()
			end
		end),

		-- if completion menu is visible, go to the next item
		-- else, trigger completion menu
		['<C-n>'] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_next_item(select_opts)
			else
				cmp.complete()
			end
		end),
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	formatting = {
		fields = {'abbr', 'menu', 'kind'},
		format = function(entry, item)
			local short_name = {
				nvim_lsp = 'LSP',
				nvim_lua = 'nvim'
			}

			local menu_name = short_name[entry.source.name] or entry.source.name

			item.menu = string.format('[%s]', menu_name)
			return item
		end,
	},
}

cmp.setup(cmp_config)

