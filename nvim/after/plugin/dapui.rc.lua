local dap_ok, dap = pcall(require, "dap")
local dap_ui_ok, ui = pcall(require, "dapui")

if not (dap_ok and dap_ui_ok) then
    require("notify")("nvim-dap or dap-ui not installed!", "warning") -- nvim-notify is a separate plugin, I recommend it too!
    return
end

vim.fn.sign_define('DapBreakpoint', { text = '🐞' })

ui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    ui.open({})
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    ui.close({})
end

dap.listeners.before.event_exited["dapui_config"] = function()
    ui.close({})
end
