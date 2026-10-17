return {
	{
		"stevearc/overseer.nvim",
		opts = {},
		config = function(_, opts)
			local overseer = require("overseer")
			overseer.setup(opts)

			vim.keymap.set("n", "<leader>os", "<cmd>OverseerRun<CR>", { desc = "Run Overseer task" })
			vim.keymap.set("n", "<leader>ot", "<cmd>OverseerToggle<CR>", { desc = "Toggle Overseer Window" })

			overseer.register_template({
				name = "Maven package",
				builder = function(params)
					return {
						cmd = { "mvn" },
						args = { "clean", "package" },
						components = { "default" },
					}
				end,
			})

            overseer.register_template({
                name = "WildFly Start Debug",
                builder = function(params)
                    local wf_path = "/opt/wildfly"
                    return {
                        cmd = { wf_path .. "/bin/standalone.sh" },
                        args = { "--debug", "127.0.0.1:5005", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0" },
                        components = { "default", "open_output" },
                    }
                end,
            })

            overseer.register_template({
                name = "Wildfly Exploded Deploy",
                builder = function(params)
                    return {
                        cmd = { "mvn" },
                        args = { "package", "wildfly:deploy" },
                        components = { "default" }
                    }
                end
            })

            overseer.register_template({
                name = "WildFly Stop",
                builder = function(params)
                    local wf_path = get_wildfly_path() or "/opt/wildfly"
                    return {
                        cmd = { wf_path .. "/bin/jboss-cli.sh" },
                        args = { "--connect", "command=:shutdown" },
                        components = { "default" },
                    }
                end,
            })
        end,
	},
}
