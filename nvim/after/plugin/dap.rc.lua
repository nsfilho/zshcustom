local status, dap = pcall(require, "dap")
if (not status) then return end

vim.keymap.set('n', '<F6>', require 'dap'.continue)
vim.keymap.set('n', '<F7>', require 'dap'.step_over)
vim.keymap.set('n', '<F8>', require 'dap'.step_into)
vim.keymap.set('n', '<F9>', require 'dap'.step_out)
vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)

dap.set_log_level('INFO')

dap.adapters.go = {
    type = "server",
    port = "${port}",
    executable = {
        command = vim.fn.stdpath("data") .. '/mason/bin/dlv',
        args = { "dap", "-l", "127.0.0.1:${port}" },
    },
}

dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = { vim.fn.stdpath("data") .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
}

dap.configurations = {
    go = {
        {
            type = "go",         -- Which adapter to use
            name = "Debug",      -- Human readable name
            request = "launch",  -- Whether to "launch" or "attach" to program
            program = "${file}", -- The buffer you are focused on when running nvim-dap
        },
    },
    javascript = {
        {
            type = 'node2',
            name = 'Launch',
            request = 'launch',
            program = '${file}',
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = 'inspector',
            console = 'integratedTerminal',
        },
        {
            type = 'node2',
            name = 'Attach',
            request = 'attach',
            program = '${file}',
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = 'inspector',
            console = 'integratedTerminal',
        },
    },
}
