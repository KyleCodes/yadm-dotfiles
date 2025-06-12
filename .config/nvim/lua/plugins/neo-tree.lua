return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      mappings = {
        ["R"] = {
          function(state)
            require("neo-tree.command").execute({ action = "reset_root" })
          end,
          desc = "Reset Root",
        },
      },
    },
    filesystem = {
      filtered_items = {
        visible = true, -- hide filtered items on open
        hide_gitignored = true,
        hide_dotfiles = true,
        hide_by_name = {},
      },
    },
  },
}
