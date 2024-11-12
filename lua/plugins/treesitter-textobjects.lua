return {
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = true,
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["of"] = { query = "@function.outer", desc = "Select outer function" },
                            ["if"] = { query = "@function.inner", desc = "Select inner function" },
                            ["oC"] = { query = "@class.outer", desc = "Select outer class" },
                            ["o="] = { query = "@assignment.outer", desc = "Select outer of an assignment" },
                            ["i="] = { query = "@assignment.inner", desc = "Select inner of an assignment" },
                            ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
                            ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },
                            ["op"] = { query = "@parameter.outer", desc = "Select parameter outer" },
                            ["ip"] = { query = "@parameter.inner", desc = "Select parameter inner" },
                            ["oi"] = { query = "@conditional.outer", desc = "Select conditional outer" },
                            ["ii"] = { query = "@conditional.inner", desc = "Select conditional inner" },
                            ["ol"] = { query = "@loop.outer", desc = "Select loop outer" },
                            ["il"] = { query = "@loop.inner", desc = "Select loop inner" },
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>pn"] = "@parameter.inner",
                            ["<leader>fn"] = "@function.outer",
                        },
                        swap_previous = {
                            ["<leader>pp"] = "@parameter.outer",
                            ["<leader>fp"] = "@function.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]f"] = { query = "@function.outer", desc = "Next function start" },
                            ["]c"] = { query = "@class.outer", desc = "Next class start" },
                            ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
                            ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
                        },
                        goto_next_end = {
                            ["]F"] = { query = "@function.outer", desc = "Next function end" },
                            ["]C"] = { query = "@class.outer", desc = "Next class end" },
                            ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
                            ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
                        },
                        goto_previous_start = {
                            ["[f"] = { query = "@function.outer", desc = "Previous function start" },
                            ["[c"] = { query = "@class.outer", desc = "Previous class start" },
                            ["[i"] = { query = "@conditional.outer", desc = "Previous conditional start" },
                            ["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
                        },
                        goto_previous_end = {
                            ["[F"] = { query = "@function.outer", desc = "Previous function end" },
                            ["[C"] = { query = "@class.outer", desc = "Previous class end" },
                            ["[I"] = { query = "@conditional.outer", desc = "Previous conditional end" },
                            ["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
                        },
                    },
                },
            })

            local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

            -- repeat forward and backward with ; and ,
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
        end,
    },
}
