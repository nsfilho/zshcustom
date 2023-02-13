local status, mason = pcall(require, "mason")
if (not status) then return end

local status2, masonConfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

mason.setup({
    max_concurrent_installers = 1,
})

if (jit.arch ~= 'x64') then
    masonConfig.setup {
        ensure_installed = { "bashls", "tsserver", "html", "yamlls" },
    }
else
    masonConfig.setup {
        ensure_installed = { "lua_ls", "rust_analyzer", "bashls", "tsserver", "html", "yamlls", "taplo" },
    }
end
