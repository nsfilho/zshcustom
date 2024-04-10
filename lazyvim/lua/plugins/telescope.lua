return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader><space>",
      function()
        require("telescope.builtin").git_files({
          recurse_submodules = true,
          hidden = true,
        })
      end,
      desc = "Find Files",
    },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope").extensions.file_browser.file_browser({
            path = "%:p:h",
          })
        end,
        desc = "File Browser",
      },
    },
  },
}
