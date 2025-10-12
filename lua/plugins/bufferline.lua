return {
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = { 
            'nvim-tree/nvim-web-devicons',
            'ThePrimeagen/harpoon',
        },
        config = function()
            require("bufferline").setup({})
            local harpoon = require("harpoon")
            for i, item in ipairs(harpoon:list().items) do
                -- added harpoon saved to buffer list showed by bufferline
                vim.cmd("badd " .. vim.fn.fnameescape(item.value))
            end
        end
    }
}
