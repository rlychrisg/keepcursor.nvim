local M = {}

function M.ToggleCursorTop(newscrolloff)
    if _G.CursorTopEnabled then
        -- disable previous autocmd
        vim.cmd[[autocmd! KeepCursor]] -- doing this in lua throws errors sometimes so for now sticking with vimscript
        -- variable to track state
        _G.CursorTopEnabled = false
        -- return to previous value
        vim.opt.scrolloff = _G.prev_scrolloff
        print("KeepCursor: Scrolloff returned to default.")
    else
        -- if the other one is enabled
        if _G.CursorBotEnabled or _G.CursorMidEnabled then
            vim.cmd[[autocmd! KeepCursor]]
            _G.CursorBotEnabled = false
            _G.CursorMidEnabled = false
            _G.CursorTopEnabled = true
        else
            -- if none of them are, get the scrolloff for later
            _G.prev_scrolloff = vim.opt.scrolloff:get()
        end
        -- set new scroll off
        if newscrolloff then
            vim.opt.scrolloff = newscrolloff
        end
        -- create the autocmd
        vim.api.nvim_create_augroup("KeepCursor", { clear = true })
        vim.api.nvim_create_autocmd("CursorMoved", { command = "normal! zt", group = "KeepCursor" })

        _G.CursorTopEnabled = true
        print("KeepCursor: keeping cursor at top.")
    end
end

-- follows the previous function's format
function M.ToggleCursorBot(newscrolloff)
    if _G.CursorBotEnabled then
        vim.cmd[[autocmd! KeepCursor]]
        _G.CursorBotEnabled = false
        vim.opt.scrolloff = _G.prev_scrolloff
        print("KeepCursor: Scrolloff returned to default.")
    else
        if _G.CursorTopEnabled or _G.CursorMidEnabled then
            vim.cmd[[autocmd! KeepCursor]]
            _G.CursorTopEnabled = false
            _G.CursorMidEnabled = false
            _G.CursorBotEnabled = true
        else
            _G.prev_scrolloff = vim.opt.scrolloff:get()
        end
        if newscrolloff then
            vim.opt.scrolloff = newscrolloff
        end
        vim.api.nvim_create_augroup("KeepCursor", { clear = true })
        vim.api.nvim_create_autocmd("CursorMoved", { command = "normal! zb", group = "KeepCursor" })
        _G.CursorBotEnabled = true
        print("KeepCursor: keeping cursor at bottom.")
    end
end

-- and again, only without the new scroll off
function M.ToggleCursorMid()
    if _G.CursorMidEnabled then
        vim.cmd[[autocmd! KeepCursor]]
        _G.CursorMidEnabled = false
        vim.opt.scrolloff = _G.prev_scrolloff
        print("KeepCursor: Scrolloff returned to default.")
    else
        if _G.CursorTopEnabled or _G.CursorBotEnabled then
            vim.cmd[[autocmd! KeepCursor]]
            _G.CursorTopEnabled = false
            _G.CursorBotEnabled = false
            _G.CursorMidEnabled = true
        else
            _G.prev_scrolloff = vim.opt.scrolloff:get()
        end
        vim.api.nvim_create_augroup("KeepCursor", { clear = true })
        vim.api.nvim_create_autocmd("CursorMoved", { command = "normal! zz", group = "KeepCursor" })
        _G.CursorMidEnabled = true
        print("KeepCursor: keeping cursor at middle.")
    end
end


-- disable any cursor autocmd functions
function M.DisableKeepCursor()
    if _G.CursorBotEnabled or _G.CursorTopEnabled or _G.CursorMidEnabled then
        vim.cmd[[autocmd! KeepCursor]]
        _G.CursorTopEnabled = false
        _G.CursorMidEnabled = false
        _G.CursorBotEnabled = false
        -- and return scroll off to default
        vim.opt.scrolloff = _G.prev_scrolloff
        print("KeepCursor: Scrolloff returned to default.")
    end
end

return M
