local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

-- Telescope setup with key mappings
telescope.setup({
    defaults = {
        mappings = {
            i = { -- Insert mode mappings
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
            n = { -- Normal mode mappings
                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
            },
        },
    },
})

-- All keybindings in one place
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
--vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Telescope Git files' })
vim.keymap.set('n', '<leader>g', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = 'Telescope search for string' })
