local M = {}

local wildfly_log_win = nil
local wildfly_job_id = nil

function M.setup()
    local buf = vim.api.nvim_create_buf(false, true)
    local width = 80
    local height = 10
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor', 
        row = row,
        col = col,
        width = width,
        height = height,
        style = 'minimal',
        border = 'rounded',
    })

    setupUI(buf, win)

    vim.keymap.set("n", "<CR>", function()
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        local path = vim.trim(lines[2] or "")

        createConfigurationFile(path)

        vim.api.nvim_win_close(win, true)
    end, { buffer = buf })
end

function getConfigurationFileContent() 
    local data_dir = vim.fn.stdpath("data")
    local config_file = data_dir .. "/wildfly_config.txt"

    if vim.fn.filereadable(config_file) == 0 then
        vim.notify("First configure wildfly path", vim.log.levels.WARN)

        return
    end

    local file = io.open(config_file, "r")
    if not file then
        vim.notify("Unexisting file, create a configuration first", vim.log.levels.WARN)

        return
    end

    local content = file:read("*all")
    file:close()

    return content
end

function M.start()
    local wildfly_path = vim.trim(getConfigurationFileContent() or "")
    if wildfly_path == "" then
        vim.notify("Empty configuration path. Reconfigure the path", vim.log.levels.WARN)

        return
    end

    local wildfly_script = wildfly_path .. "/bin/standalone.sh"
    if vim.fn.executable(wildfly_script) ~= 1 then
        vim.notify("Missing starting script: " .. wildfly_script, vim.log.levels.ERROR)

        return
    end

    vim.notify("Starting Wildfly...", vim.log.levels.INFO)

    local wildfly_log_win_already_open = wildfly_log_win and vim.api.nvim_win_is_valid(wildfly_log_win)
    local wildfly_is_running = wildfly_job_id and (vim.fn.jobwait({ wildfly_job_id }, 0)[1] == -1)

    -- if wildfly is already running and log window exists
    if wildfly_log_win_already_open and wildfly_is_running then
        vim.api.nvim_set_current_win(wildfly_log_win)
        vim.notify("Wildfly already running", vim.log.levels.WARN)

        return
    end
        
    -- if wildfly log windows is already open but wildfly is not running
    if wildfly_log_win_already_open then
        vim.api.nvim_set_current_win(wildfly_log_win)
    else
        -- else open a new log window
        vim.cmd("botright split")
        vim.cmd("resize 12")
        wildfly_log_win = vim.api.nvim_get_current_win()
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(wildfly_log_win, buf)

    wildfly_job_id = vim.fn.termopen(wildfly_script, {
        on_exit = function()
            wildfly_job_id = nil
        end
    })

    vim.api.nvim_win_set_cursor(wildfly_log_win, { vim.api.nvim_buf_line_count(buf), 0 })

    vim.notify("Wildfly started successfully", vim.log.levels.INFO)
end

function M.stop()
    local wildfly_path = vim.trim(getConfigurationFileContent() or "")
    if wildfly_path == "" then
        vim.notify("Empty configuration path. Reconfigure the path", vim.log.levels.WARN)

        return
    end

    local cli_script = wildfly_path .. "/bin/jboss-cli.sh"
    if vim.fn.executable(cli_script) ~= 1 then
        vim.notify("Wildfly CLI not found: " .. cli_script, vim.log.levels.ERROR)

        return
    end

    vim.notify("Stopping Wildfly...", vim.log.levels.INFO)

    vim.system({ cli_script, "--connect", "command=:shutdown" }, {}, function(result)
        vim.schedule(function()
            if result.code == 0 then
                vim.notify("Wildfly stopped successfully", vim.log.levels.INFO)
            else
                vim.notify("Error while stopping Wildfly (code: " .. tostring(result.code) .. ")", vim.log.levels.ERROR)
            end
        end)
    end)
end


function setupUI(buf, win)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
        " Insert wildfly path:",
        "",
    })

    vim.api.nvim_win_set_cursor(win, { 2, 0 })
end

function createConfigurationFile(path)
    if vim.fn.isdirectory(path) == 1 then
        local data_dir = vim.fn.stdpath("data")
        local config_file = data_dir .. "/wildfly_config.txt"

        local file = io.open(config_file, "w")
        if file then
            file:write(path)
            file:close()
            vim.notify("Wildfly path saved successfully to: " .. path, vim.log.levels.INFO)
        else
            vim.notify("Error: Unable to save wildfly path" , vim.log.levels.ERROR)
        end
    else
        vim.notify("Error: unexisting folder '" .. path .. "'", vim.log.level.ERROR)
    end
end

return M
