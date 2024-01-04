-- Add to ~/.config/nvim/lua/init.lua
local nvim_lsp = require("lspconfig")
nvim_lsp['pylsp'].setup({
        enable = false,
        cmd = cmd,
        on_attach = on_attach,
        settings = {
            pylsp = {
                plugins = {
                    configurationSources = {},
                    flake8 = { enabled = false },
                    mypy = { enabled = false },
		    pycodestyle= {enabled = false},
		    pyflakes = {enabled=false},
                },
            },
        },
    })
