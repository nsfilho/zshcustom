-- Only enable when inside a remote SSH session with LLM tunnel active
if not vim.env.NEOVIM_LLM_REMOTE then
  return {}
end

local llm_host = vim.env.NEOVIM_LLM_HOST or "127.0.0.1"
local llm_port = tonumber(vim.env.NEOVIM_LLM_PORT) or 8000
local llm_model = vim.env.NEOVIM_LLM_MODEL or "qwen"

return {
  "milanglacier/minuet-ai.nvim",
  event = "InsertEnter",
  opts = {
    provider = "openai_compatible",
    context_window = 16000,
    n_completions = 1,
    throttle = 100,
    debounce = 200,
    blink = {
      enable_auto_complete = true,
    },
    virtualtext = {
      auto_trigger_ft = {
        "lua", "python", "javascript", "typescript", "javascriptreact",
        "typescriptreact", "go", "rust", "java", "cpp", "c", "ruby",
        "haskell", "scala", "kotlin", "swift", "php", "shellscript",
        "sh", "zsh", "bash", "toml", "yaml", "json", "dockerfile",
        "html", "css", "sql", "ansible",
      },
      keymap = {
        accept = "<A-a>",
        accept_line = "<A-j>",
        next = "<A-]>",
        prev = "<A-[>",
        dismiss = "<A-e>",
      },
    },
    provider_options = {
      openai_compatible = {
        api_key = function() return "none" end,
        end_point = "http://" .. llm_host .. ":" .. tostring(llm_port)
                     .. "/v1/chat/completions",
        model = llm_model,
        optional = {
          max_tokens = 256,
          temperature = 0.2,
        },
      },
    },
  },
}
