local status, autosession = pcall(require, "auto-session")
if (not status) then return end

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winpos"

autosession.setup {
    log_level = "error",
    auto_session_suppress_dirs = { "~/", "~/Downloads" },
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
