return {
        'RRethy/base16-nvim',
        config = function()
                local ok, matugen = pcall(require, 'matugen')
                if ok then matugen.setup() end
                vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end,
}
