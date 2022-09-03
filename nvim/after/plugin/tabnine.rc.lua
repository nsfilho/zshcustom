
if (vim.g.arch == 'i386' or vim.g.arch == 'x86_64') then
    local tabnine = require('cmp_tabnine.config')

    tabnine.setup({
        max_lines = 1000;
        max_num_results = 20;
        sort = true;
        run_on_every_keystroke = true;
        snippet_placeholder = '..';
    })
end
