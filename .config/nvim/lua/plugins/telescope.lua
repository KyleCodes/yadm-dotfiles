-- telescope.lua
return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        file_ignore_patterns = {
          -- Node modules
          "node_modules/.*",
          -- Git directories
          "%.git/.*",
          -- Build directories
          "build/.*",
          "dist/.*",
          -- Cache directories
          "%.cache/.*",
          -- Package lock files
          "package%-lock.json",
          "yarn.lock",
          -- Minified files
          "%.min.js",
          "%.min.css",
          -- Log files
          "%.log",
          -- Dependencies
          "vendor/.*",
          -- Environment files
          "%.env.*",
        },
        -- Additional default configurations
        -- path_display = { "truncate" },
        -- layout_config = {
        --   horizontal = {
        --     preview_width = 0.55,
        --     results_width = 0.8,
        --   },
        --   vertical = {
        --     mirror = false,
        --   },
        --   width = 0.87,
        --   height = 0.80,
        --   preview_cutoff = 120,
        -- },
      },
      -- Picker-specific configurations can be added here
      pickers = {
        find_files = {
          hidden = true, -- Show hidden files
          no_ignore = true, -- Don't respect .gitignore
        },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
      },
    },
  },
}
