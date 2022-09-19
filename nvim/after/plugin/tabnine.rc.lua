local status, tabnine = pcall(require, "cmp_tabnine.config")
if (not status) then return end

if (jit.arch == 'x64') then
    tabnine.setup({
        max_lines = 5000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = '..',
    })


    local prefetch = vim.api.nvim_create_augroup("prefetch", { clear = true })
    vim.api.nvim_create_autocmd('BufRead', {
        group = prefetch,
        pattern = { '*.py', '*.js', '*.ts', '*.rs' },
        callback = function()
            require('cmp_tabnine'):prefetch(vim.fn.expand('%:p'))
        end
    })

end
