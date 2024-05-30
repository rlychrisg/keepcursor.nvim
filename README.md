## What?
KeepCursor.nvim is a set of toggle functions to keep the cursor at the top or bottom of the screen while moving. For example, if you have a long list of search results to cycle through, with `ToggleCursorTop` enabled, you can do so with more new information to react to and work with, rather than old information.

## How to install
Lazy
```
    {
        "rlychrisg/keepcursor.nvim"
    },
```

## How to use
Functions can be called dirrectly from the command line or bound to a key. No configuration is needed, no default keys are set, and any command you have no use for can be safely ignored. The toggle commands can be given a number to temporarily set the scroll off to a new value, until KeepCursor functions are disabled.

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




