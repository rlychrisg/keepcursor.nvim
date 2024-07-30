## About
KeepCursor.nvim is a set of toggle functions to keep the cursor at the top or bottom of the screen while moving. For example, if you have a long list of search results to cycle through, with `ToggleCursorTop` enabled, you can do so with more new information to react to and work with, rather than old information.

## How to install
To install with lazy
```
{"rlychrisg/keepcursor.nvim"},
```

Keys can also be bound here, so that the plugin will only load once a KeepCursor function is called. Be sure to change the keys and opts to your liking.
```
    {
        "rlychrisg/keepcursor.nvim",
        keys = {
            { '<leader>zt', ':lua require("keepcursor").ToggleCursorTop()<CR>', desc = "KeepCursor toggle cursor top" },
            { '<leader>zb', ':lua require("keepcursor").ToggleCursorBot(3)<CR>', desc = "KeepCursor toggle cursor bottom" },
            { '<leader>zz', ':lua require("keepcursor").ToggleCursorMid()<CR>', desc = "KeepCursor toggle cursor middle" },
            { '<leader><leader>z', ':lua require("keepcursor").DisableKeepCursor()<CR>', desc = "KeepCursor disable all functions" },
        }
    },
```

## How to use
Functions can be called directly from the command line or bound to a key. No configuration is needed, no default keys are set, and any command you have no use for can be safely ignored. The toggle commands can be given a number to temporarily set the scroll off to a new value, until KeepCursor functions are disabled.

```
-- Toggle whether or not the cursor should be kept 2 lines from the top.
vim.api.nvim_set_keymap('n', '<leader>zt', ':lua require("keepcursor").ToggleCursorTop(2)<CR>', { noremap = true, silent = true })

-- Toggle whether or not the cursor should be kept at the bottom with whatever scroll off the user has set.
vim.api.nvim_set_keymap('n', '<leader>zb', ':lua require("keepcursor").ToggleCursorBot()<CR>', { noremap = true, silent = true })

-- Toggle whether or not to keep the cursor in the middle.
vim.api.nvim_set_keymap('n', '<leader>zz', ':lua require("keepcursor").ToggleCursorMid()<CR>', { noremap = true, silent = true })

-- Disable any KeepCursor functions that are currently enabled and restore previous scroll off value.
vim.api.nvim_set_keymap('n', '<leader><leader>z', ':lua require("keepcursor").DisableKeepCursor()<CR>', { noremap = true, silent = true })
```

`:lua ToggleCursorTop(int)` will keep the cursor at the top of the screen, at a distance of whatever integar is passed to it. Calling this function again will disable the autocmd and return the scrolloff to its previous value. `:lua ToggleCursorBot(int)` will do the same but for the bottom. If you want to disable any active functions you can use `:lua DisableKeepCursor` to restore previous scroll off behaviour. Previous scroll off value is only taken when enabling a function from the default state, and remembered until a function is toggled off or disabled.

## Lualine
For a visual indication of any function that may be currently active, you can pass `require('keepcursor').KeepCursorStatus` as a component in your lualine config. This is an excerpt from my own, in which I have adjusted the color to make it stand out among the encoding and filetype information, as well as a function to hide the component and its separator if no KeepCursor is active (see lualine docs for more info on these settings).
```
require('lualine').setup {
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {},
        lualine_x = {
            'encoding', 'fileformat', 'filetype',
            -- if adding options, create a new lua table within the lualine_x table
            {
                require('keepcursor').KeepCursorStatus,
                color = { fg = 'Normal' },
                cond = function ()
                    -- this is a variable used inside keepcursor to track the state of currently enabled functions
                    if _G.KeepCursorAt ~= nil then
                        return true
                    end
                end
            }
        },
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
}

```


