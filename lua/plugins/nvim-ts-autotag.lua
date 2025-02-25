return {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("nvim-ts-autotag").setup({
            filetypes = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact" }, -- Add filetypes
            skip_tags = {
                "area",
                "base",
                "br",
                "col",
                "command",
                "embed",
                "hr",
                "img",
                "input",
                "keygen",
                "link",
                "meta",
                "param",
                "source",
                "track",
                "wbr",
            }, -- Tags to skip
        })
    end,
}

