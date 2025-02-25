return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha', -- Set the flavor to mocha
        transparent_background = false, -- Disable transparent background initially
        no_italic = true, -- Disable italics
        no_bold = true, -- Disable bold
        integrations = {
          -- Add integrations for plugins you use (optional)
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          treesitter = true,
          -- For more integrations, see the documentation: https://github.com/catppuccin/nvim
        },
      }

      -- Set the colorscheme
      vim.cmd.colorscheme 'catppuccin'

      -- Optional: Toggle transparency
      local bg_transparent = false -- Start with transparency disabled

      local toggle_transparency = function()
        bg_transparent = not bg_transparent
        vim.g.catppuccin_transparent_background = bg_transparent
        -- Reapply the colorscheme after modifying the transparency
        vim.cmd [[colorscheme catppuccin]] -- Reapply the colorscheme to update the background
        vim.notify('Transparency ' .. (bg_transparent and 'enabled' or 'disabled'), vim.log.levels.INFO)
      end

      -- Key mapping to toggle transparency
      vim.keymap.set('n', '<leader>bg', toggle_transparency, { noremap = true, silent = true })
    end,
  },
}
