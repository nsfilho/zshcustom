local status, autosession = pcall(require, "auto-session")
if (not status) then return end

-- vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winpos"
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

function _G.close_all_floating_wins()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local config = vim.api.nvim_win_get_config(win)
        if config.relative ~= '' then
            vim.api.nvim_win_close(win, false)
        end
    end
end

autosession.setup {
    log_level = "error",
    auto_session_suppress_dirs = { "~/", "~/Downloads" },
    auto_session_allowed_dirs = { "~/workspace" },
    pre_save_cmds = { _G.close_all_floating_wins },
    cwd_change_handling = {
        restore_upcoming_session = true, -- already the default, no need to specify like this, only here as an example
        post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
            require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
        end,
    },
}


local statusLens, sessionlens = pcall(require, "session-lens")
if (not statusLens) then return end

sessionlens.setup({})
