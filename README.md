## About
KeepCursor.nvim is a collection of functions to keep the screen positioned around your cursor as you scroll. for example, `ToggleCursorTop()` keeps the cursor at the top of the screen, by triggering an autocmd for `zt` every time the cursor moves. This is handy for allowing the user more look ahead when quickly scrolling through search results. `ToggleCursorRight()` aims to make dealing with long lines less tedious, as the screen will always return to the main chunk of text without having to press `ze` so much.

## Installation and configuration
To install with lazy
```lua
{"rlychrisg/keepcursor.nvim"},
```

By default no function begins on startup. You can however enable this behavour for both horizontal and vertical scrolling.
```lua
    {
        "rlychrisg/keepcursor.nvim",
        config = function ()
            require('keepcursor').setup({
                enabled_on_start_v = "none", -- options are "top", "middle" and "bottom".
                enabled_on_start_h = "none" -- options are "left" and "right".
            })
        end,
    },
```

## How to use
Functions can be called directly from the command line or bound to a key. No configuration is needed, no default keys are set, and any command you have no use for can be safely ignored. The toggle commands can be given a number to temporarily set the scroll off to a new value, until KeepCursor functions are disabled.

```lua
-- Toggle whether or not the cursor should be kept 2 lines from the top.
vim.api.nvim_set_keymap('n', '<leader>zt', ':lua require("keepcursor").ToggleCursorTop(2)<CR>', { noremap = true, silent = true })

-- Toggle whether or not the cursor should be kept at the bottom with whatever scroll off the user has set.
vim.api.nvim_set_keymap('n', '<leader>zb', ':lua require("keepcursor").ToggleCursorBot()<CR>', { noremap = true, silent = true })

-- Toggle whether or not to keep the cursor in the middle.
vim.api.nvim_set_keymap('n', '<leader>zz', ':lua require("keepcursor").ToggleCursorMid()<CR>', { noremap = true, silent = true })

-- Disable any vertical KeepCursor functions that are currently enabled and restore previous scroll off value.
vim.api.nvim_set_keymap('n', '<leader><leader>z', ':lua require("keepcursor").DisableKeepCursor()<CR>', { noremap = true, silent = true })

-- Toggle whether or not the cursor should always stay 20 columns from
-- the right side of the screen
vim.api.nvim_set_keymap('n', '<leader>ze', ':lua require("keepcursor").ToggleCursorRight(20)<CR>', { noremap = true, silent = true })

-- Toggle whether or not the cursor should stay on the left as the screen
-- scrolls to the right. I've included this purely for the sake of having
-- a complete set. I can't think of a situation where it would be helpful.
vim.api.nvim_set_keymap('n', '<leader>zs', ':lua require("keepcursor").ToggleCursorRight(20)<CR>', { noremap = true, silent = true })
```

## Lualine
For a visual indication of any function that may be currently active, you can pass `require('keepcursor').KeepCursorStatus` as a component in your lualine config. This is an excerpt from my own, in which I have adjusted the color to make it stand out among the encoding and filetype information, as well as a function to hide the component and its separator if no KeepCursor is active (see lualine docs for more info on these settings). Note this only works for vertical functions for now.
```lua
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


