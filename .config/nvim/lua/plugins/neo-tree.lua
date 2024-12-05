return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
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
