return {
  -- add dracula (optional, since you are using tokyonight)
  { "Mofiqul/dracula.nvim" },

  -- Configure LazyVim to load the correct colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = (function()
        local handle = io.popen(
          [[osascript -e 'tell application "System Events" to tell appearance preferences to return dark mode']]
        )
        local result = handle and handle:read("*a") or ""
        handle:close()
        return result:match("true") and "tokyonight" or "tokyonight-day"
      end)(),
    },
  },
}
