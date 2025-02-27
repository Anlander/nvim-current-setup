return {
  'GustavEikaas/easy-dotnet.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    local function get_secret_path(secret_guid)
      local path = ''
      local home_dir = vim.fn.expand '~'
      if require('easy-dotnet.extensions').isWindows() then
        local secret_path = home_dir .. '\\AppData\\Roaming\\Microsoft\\UserSecrets\\' .. secret_guid .. '\\secrets.json'
        path = secret_path
      else
        local secret_path = home_dir .. '/.microsoft/usersecrets/' .. secret_guid .. '/secrets.json'
        path = secret_path
      end
      return path
    end

    local dotnet = require 'easy-dotnet'
    dotnet.setup {
      -- Your existing configuration...
      terminal = function(path, action, args)
        local commands = {
          run = function()
            return string.format('dotnet run --project %s %s', path, args)
          end,
          watch = function()
            return string.format('dotnet watch run --project %s %s', path, args)
          end,
          test = function()
            return string.format('dotnet test %s %s', path, args)
          end,
          restore = function()
            return string.format('dotnet restore %s %s', path, args)
          end,
          build = function()
            return string.format('dotnet build %s %s', path, args)
          end,
        }

        local command = commands[action]() .. '\r'
        vim.cmd 'vsplit'
        vim.cmd('term ' .. command)
      end,
      -- Your existing configuration...
    }

    -- Function to create a file in a chosen directory
    local function create_file()
      -- Use Telescope to pick a directory
      require('telescope.builtin').file_browser {
        cwd = vim.fn.getcwd(), -- Start from the current working directory
        attach_mappings = function(prompt_bufnr, map)
          -- When a directory is selected, create a file in it
          local actions = require 'telescope.actions'
          actions.select_default:replace(function()
            local entry = require('telescope.actions.state').get_selected_entry()
            actions.close(prompt_bufnr)

            -- Prompt for the file name
            vim.ui.input({ prompt = 'Enter file name: ' }, function(file_name)
              if file_name and file_name ~= '' then
                local full_path = entry.value .. '/' .. file_name
                vim.cmd('e ' .. full_path) -- Create and open the file
                print('Created file: ' .. full_path)
              else
                print 'File creation canceled.'
              end
            end)
          end)
          return true
        end,
      }
    end

    -- Command to create a file in a chosen directory
    vim.api.nvim_create_user_command('DotnetCreateFile', create_file, {})

    -- Existing command for running the project
    vim.api.nvim_create_user_command('DotnetRun', function()
      dotnet.run_project() -- Use the plugin's built-in function
    end, {})

    -- New command for running the project with dotnet watch
    vim.api.nvim_create_user_command('DotnetWatch', function()
      local path = vim.fn.expand '%:p:h' -- Get the current project path
      vim.cmd('vsplit | term dotnet watch run --project ' .. path) -- Manually run dotnet watch
    end, {})

    -- Existing keybinding for running the project
    vim.keymap.set('n', '<C-p>', function()
      dotnet.run_project() -- Use the plugin's built-in function
    end)

    -- New keybinding for running the project with dotnet watch
    vim.keymap.set('n', '<leader>w', function()
      local path = vim.fn.expand '%:p:h' -- Get the current project path
      vim.cmd('vsplit | term dotnet watch run --project ' .. path) -- Manually run dotnet watch
    end, { desc = 'Run project with dotnet watch' })
  end,
}
