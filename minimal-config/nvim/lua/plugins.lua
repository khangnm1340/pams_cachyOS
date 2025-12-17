-- Plugins: plugin manager and configurations

-- Core plugin list (vim.pack)
vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/zbirenbaum/copilot.lua" },
    { src = "https://github.com/norcalli/nvim-colorizer.lua" },
    { src = "https://github.com/folke/flash.nvim" },
    { src = "https://github.com/mbbill/undotree" },
    -- { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/kdheepak/lazygit.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/mikavilpas/yazi.nvim" },
    { src = "https://github.com/opdavies/toggle-checkbox.nvim" },
    { src = "https://github.com/jake-stewart/multicursor.nvim" },
})

-- Undotree config
vim.g.undotree_DiffAutoOpen       = 1
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_DiffCommand        = 'diff -u'
vim.g.undotree_WindowLayout       = 2

-- Mini and Mason
require('mason').setup()
require("mason-lspconfig").setup({
  ensure_installed = { "emmylua_ls","zls","tinymist","hyprls","qmlls" },
})

require('mini.pick').setup()
require('mini.ai').setup()
require('mini.surround').setup({
    mappings = {
        add = 'gsa',
        delete = 'gsd',
        replace = 'gsr',
        find = 'gsf',
        find_left = 'gsF',
        highlight = 'gsh',
        update_n_lines = '',
    },
})
require('mini.pairs').setup()
---@diagnostic disable-next-line: assign-type-mismatch, need-check-nil
require('mini.extra').setup()
require('mini.deps').setup()
require('colorizer').setup()

-- Multicursor plugin (basic setup)
do
    local ok, mc = pcall(require, 'multicursor-nvim')
    if ok and not vim.g.__mc_loaded then
        mc.setup()
        vim.g.__mc_loaded = true
    end
end

-- Additional plugins via MiniDeps
MiniDeps.add({
    source = 'saghen/blink.cmp',
    depends = { 'rafamadriz/friendly-snippets' },
    checkout = 'v1.6.0',
})

require('blink.cmp').setup({
    keymap = { preset = 'default' },
    appearance = { nerd_font_variant = 'mono' },
    completion = { documentation = { auto_show = false } },
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
})

-- Flash
require('flash').setup({
    labels = 'jkluioprewtfsgvmbq',
    highlight = {},
    modes = {
        char = {
            jump_labels = true,
            label = { exclude = 'py' },
            multi_line = true,
            highlight = { backdrop = true },
        },
    },
})

-- Copilot
require('copilot').setup()

-- remember to run TSUpdate after upgrading treesitter
-- Treesitter via MiniDeps
MiniDeps.add({
    source = 'nvim-treesitter/nvim-treesitter',
    hooks  = {
        post_install  = function() vim.cmd('TSUpdate') end,
        post_checkout = function() vim.cmd('TSUpdate') end,
    },
})

require'nvim-treesitter'.setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site'
}
require'nvim-treesitter'.install {
        'lua', 'vim', 'vimdoc', 'query',
        'bash', 'python', 'json', 'yaml', 'toml',
        'markdown', 'markdown_inline',
        'regex', 'c', 'rust', 'typst', 'nu', 'qmljs'
    }


-- LSP
vim.lsp.enable({ 'emmylua_ls', 'tinymist','qmlls' })
vim.lsp.config('tinymist', {
    cmd = { 'tinymist' },
    filetypes = { 'typst' },
    settings = { formatterMode = 'typstyle' },
})

vim.lsp.config('qmlls', {
    cmd = { 'qmlls' },
    filetypes = { 'qmljs', 'qml' },
    handlers = {
        ['textDocument/publishDiagnostics'] = function(err, result, ctx, config)
            if result then
                result.diagnostics = vim.tbl_filter(function(d)
                    -- Filter out the specific error code
                    return d.code ~= 'create'
                end, result.diagnostics)
            end
            -- Pass the filtered diagnostics to the default handler
            vim.lsp.handlers['textDocument/publishDiagnostics'](err, result, ctx, config)
        end,
    },
})


-- Mini.pick registry helper
do
    local MiniPick = require('mini.pick')
    MiniPick.registry.files = function(local_opts)
        local opts = { source = { cwd = local_opts.cwd } }
        local_opts.cwd = nil
        return MiniPick.builtin.files(local_opts, opts)
    end
end



-- UI / Colors
require('tokyonight').setup({
    transparent = not vim.g.neovide,
})
vim.cmd('colorscheme tokyonight')
vim.cmd('hi statusline guibg=NONE')

