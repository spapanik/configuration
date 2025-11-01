return {
    { "cespare/vim-toml", ft = "toml" },
    {
        "cameron-wags/rainbow_csv.nvim",
        config = true,
        ft = {
            "csv",
            "tsv",
            "csv_semicolon",
            "csv_whitespace",
            "csv_pipe",
            "rfc_csv",
            "rfc_semicolon",
        },
        cmd = {
            "RainbowDelim",
            "RainbowDelimSimple",
            "RainbowDelimQuoted",
            "RainbowMultiDelim",
        },
    },
    { "jparise/vim-graphql", ft = "graphql" },
    { "Vimjas/vim-python-pep8-indent", ft = "python" },
    { "alaviss/nim.nvim", ft = "nim" },
}
