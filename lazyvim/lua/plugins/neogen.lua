return {
  {
    "danymat/neogen",
    config = true,
    keys = {
      {
        "gC",
        function()
          require("neogen").generate({})
        end,
      },
    },
  },
}
