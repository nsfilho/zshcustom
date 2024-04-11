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
}
