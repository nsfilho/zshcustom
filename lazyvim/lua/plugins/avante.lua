-- Only enable avante if NEOVIM_LLM_REMOTE is set (remote SSH session)
-- When not set, local machine uses its own LLM via vllm on :8000
if not vim.env.NEOVIM_LLM_REMOTE then
  return {}
end

local llm_host = vim.env.NEOVIM_LLM_HOST or "127.0.0.1"
local llm_port = tonumber(vim.env.NEOVIM_LLM_PORT) or 8000
local llm_model = vim.env.NEOVIM_LLM_MODEL or "qwen"

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  opts = {
    provider = "openai",
    providers = {
      openai = {
        endpoint = "http://" .. llm_host .. ":" .. tostring(llm_port) .. "/v1",
        api_key_name = "",
        model = llm_model,
        timeout = 60000,
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 20480,
        },
      },
    },
  },
}
