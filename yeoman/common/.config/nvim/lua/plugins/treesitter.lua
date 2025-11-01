return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      -- Safely load Treesitter after plugin is available
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          local ok, configs = pcall(require, "nvim-treesitter.configs")
          if not ok then
            vim.notify("nvim-treesitter not found!", vim.log.levels.WARN)
            return
          end
          configs.setup({
            ensure_installed = {
              "lua", "vim", "vimdoc", "python",
              "javascript", "typescript", "tsx",
              "json", "yaml", "toml", "html", "css",
              "markdown", "markdown_inline",
              "graphql", "bash", "go", "fortran",
            },
            auto_install = true,
            highlight = { enable = true, additional_vim_regex_highlighting = false },
            indent = { enable = true },
            incremental_selection = {
              enable = true,
              keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
              },
            },
            textobjects = {
              select = {
                enable = true,
                lookahead = true,
                keymaps = {
                  ["af"] = "@function.outer",
                  ["if"] = "@function.inner",
                  ["ac"] = "@class.outer",
                  ["ic"] = "@class.inner",
                },
              },
            },
          })
        end,
      })
    end,
  },
}
