local cmp = require("cmp")
local cmp_enabled = true -- Keep track of whether cmp is enabled or disabled

-- Function to toggle nvim-cmp
_G.toggle_cmp = function()
  cmp_enabled = not cmp_enabled
  if cmp_enabled then
    cmp.setup({}) -- Re-enable nvim-cmp by setting it up again
    print("nvim-cmp enabled")
  else
    cmp.setup({
      enabled = function()
        return false -- Disable nvim-cmp by returning false
      end,
    })
    print("nvim-cmp disabled")
  end
end

-- Create a custom command to toggle nvim-cmp
vim.api.nvim_create_user_command("ToggleCmp", "lua toggle_cmp()", {})

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
      opts.experimental = opts.experimental or {}
      opts.experimental.ghost_text = false
    end,
  },
}
