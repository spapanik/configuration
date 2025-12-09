return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            local TOOLS = {
                -- LSP servers
                "clangd",
                "fortls",
                "lua_ls",
                "pylsp",
                "rust_analyzer",

                -- formatters
                "stylua",
                "prettier",
                "ruff", -- ruff format

                -- linters
                "ruff", -- ruff check
                "eslint_d",
                "luacheck",
            }

            require("mason").setup()
            require("mason-tool-installer").setup({
                ensure_installed = TOOLS,
                run_on_start = true,
                start_delay = 3000,
                auto_update = false,
            })

            local lsp_servers = { "clangd", "fortls", "lua_ls", "pylsp", "rust_analyzer" }
            require("mason-lspconfig").setup({
                ensure_installed = lsp_servers,
                automatic_installation = false,
            })

            local caps = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config.lua_ls = {
                capabilities = caps,
                settings = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            }
            vim.lsp.config["*"] = { capabilities = caps }

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "*",
                callback = function(args)
                    local ft = vim.bo[args.buf].filetype
                    local server = require("mason-lspconfig").get_mappings()[ft]
                    if server then
                        vim.lsp.enable(server, args.buf)
                    end
                end,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local opts = { buffer = args.buf }
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

                    vim.keymap.set("n", "<leader>f", function()
                        vim.lsp.buf.format({ async = true })
                    end, opts)
                end,
            })
        end,
    },

    { "mason-org/mason.nvim", cmd = "Mason" },
    { "mason-org/mason-lspconfig.nvim" },
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },
}
