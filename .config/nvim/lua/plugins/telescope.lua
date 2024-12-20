-- telescope.lua
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      {
        "nvim-telescope/telescope-frecency.nvim",
        dependencies = { "kkharji/sqlite.lua" },
      },
    },
    opts = {
      defaults = {
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },

        cache_picker = {
          num_pickers = 5,
          limit_entries = 1000,
        },
      },

      pickers = {
        find_files = {
          find_command = {
            "fd",
            "--type",
            "f", -- Only files
            "--strip-cwd-prefix", -- Clean output for telescope
            "--hidden", -- Show hidden files
            "--no-ignore-vcs", -- Don't respect .gitignore
            "--exclude",
            ".git", -- Explicitly exclude .git
            "--exclude",
            "node_modules", -- Explicitly exclude node_modules
            "--exclude",
            "**/dist/**", -- Exclude dist directories at any depth
            "--exclude",
            "**/.next/**", -- Exclude .next directories at any depth
          },
        },

        live_grep = {
          additional_args = function()
            return {
              "--hidden", -- Show hidden files
              "--no-ignore-vcs", -- Don't respect .gitignore
              "--max-columns",
              "150",
              "--glob",
              "!.git/*", -- Exclude .git directory
              "--glob",
              "!node_modules/*", -- Exclude node_modules directory
              "--glob",
              "!**/dist/**", -- Exclude dist directories at any depth
              "--glob",
              "!**/.next/**", -- Exclude .next directories at any depth
            }
          end,
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)

      -- Load extensions
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("frecency")
    end,
  },
}
