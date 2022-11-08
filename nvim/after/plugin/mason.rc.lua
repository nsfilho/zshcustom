local status, mason = pcall(require, "mason")
if (not status) then return end

local status2, masonConfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

mason.setup({

})

if (jit.arch ~= 'x64') then
    masonConfig.setup {
        ensure_installed = { "sumneko_lua", "rust_analyzer", "bashls", "tsserver", "html", "yamlls" },
    }
else
    masonConfig.setup {
        ensure_installed = { "sumneko_lua", "rust_analyzer", "bashls", "tsserver", "html", "yamlls", "taplo" },
    }
end
