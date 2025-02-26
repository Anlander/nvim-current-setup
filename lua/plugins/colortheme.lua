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
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          treesitter = true,
        },
      }

      -- Set the colorscheme
      vim.cmd.colorscheme 'catppuccin'

      -- State variable
      local bg_transparent = false

      -- Toggle function
      local function toggle_transparency()
        bg_transparent = not bg_transparent
        require('catppuccin').setup {
          flavour = 'mocha',
          transparent_background = bg_transparent, -- Apply dynamic state
          no_italic = true,
          no_bold = true,
          integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            telescope = true,
            treesitter = true,
          },
        }
        vim.cmd.colorscheme 'catppuccin' -- Reapply colorscheme to reflect changes
        vim.notify('Transparency ' .. (bg_transparent and 'enabled' or 'disabled'), vim.log.levels.INFO)
      end

      -- Key mapping
      vim.keymap.set('n', '<leader>bg', toggle_transparency, { noremap = true, silent = true })
    end,
  },
}
