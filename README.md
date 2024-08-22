# keepcursor.nvim

https://github.com/user-attachments/assets/87eebc34-bc3a-4d8c-9681-1070d05401ff

## About
KeepCursor is a collection of functions to manage autocmds which keep the screen positioned around the cursor. For eg, `:ToggleCursorTop` effectively pressed `zt` after every cursor movement, and `:ToggleCursorRight` uses `ze`

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
Functions can be called directly from the command line or bound to a key. To temporarily change the scroll off value, a number can also be passed to Top, Bottom, Left and Right functions. Enabling one vertical function will disable any that might currently be active, and when this function is disabled, scroll off will return to whatever you have set to default. The same is also true of horizontal functions.

Some example keybinds would be:
```lua
vim.api.nvim_set_keymap('n', '<leader>zt', ':ToggleCursorTop<CR>',
{ noremap = true, silent = true, desc = "KeepCursor: keep cursor positioned at top on cursor move" })

vim.api.nvim_set_keymap('n', '<leader>zb', ':ToggleCursorBot 2<CR>', -- optional argument, temporarily sets scroll off to 2
{ noremap = true, silent = true, desc = "KeepCursor: keep cursor positioned at bottom on cursor move" })

vim.api.nvim_set_keymap('n', '<leader>zz', ':ToggleCursorMid<CR>',
{ noremap = true, silent = true, desc = "KeepCursor: keep cursor positioned at middle on cursor move" })

vim.api.nvim_set_keymap('n', '<leader>ze', ':ToggleCursorRight 30<CR>', -- optional argument, temporarily sets side scroll off to 30
{ noremap = true, silent = true, desc = "KeepCursor: keep cursor positioned to the right on cursor move" })

vim.api.nvim_set_keymap('n', '<leader>zs', ':ToggleCursorLeft<CR>',
{ noremap = true, silent = true, desc = "KeepCursor: keep cursor positioned to the left on cursor move" })

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


