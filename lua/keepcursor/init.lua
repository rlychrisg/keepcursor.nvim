local M = {}

function M.ToggleCursorTop(newscrolloff)
    if _G.KeepCursorAt == "top" then
        -- disable previous autocmd
        vim.cmd[[autocmd! KeepCursor]] -- doing this in lua throws errors sometimes so for now sticking with vimscript
        -- variable to track state
        _G.KeepCursorAt = nil
        -- return to previous value
        vim.opt.scrolloff = _G.prev_scrolloff
        print("KeepCursor: Scrolloff returned to default.")
    else
        -- if the other one is enabled
        if _G.KeepCursorAt == "middle" or _G.KeepCursorAt == "bottom" then
            vim.cmd[[autocmd! KeepCursor]]
            _G.KeepCursorAt = "top" -- TODO i might be able to delete this line since var is set later
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

        _G.KeepCursorAt = "top"
        print("KeepCursor: keeping cursor at top.")
    end
end

-- follows the previous function's format
function M.ToggleCursorBot(newscrolloff)
    if _G.KeepCursorAt == "bottom" then
        vim.cmd[[autocmd! KeepCursor]]
        _G.KeepCursorAt = nil
        vim.opt.scrolloff = _G.prev_scrolloff
        print("KeepCursor: Scrolloff returned to default.")
    else
        if _G.KeepCursorAt == "top" or _G.KeepCursorAt == "middle" then
            vim.cmd[[autocmd! KeepCursor]]
            _G.KeepCursorAt = "bottom" -- TODO again may not need
        else
            _G.prev_scrolloff = vim.opt.scrolloff:get()
        end
        if newscrolloff then
            vim.opt.scrolloff = newscrolloff
        end
        vim.api.nvim_create_augroup("KeepCursor", { clear = true })
        vim.api.nvim_create_autocmd("CursorMoved", { command = "normal! zb", group = "KeepCursor" })
        _G.KeepCursorAt = "bottom"
        print("KeepCursor: keeping cursor at bottom.")
    end
end

-- and again, only without the new scroll off
function M.ToggleCursorMid()
    if _G.KeepCursorAt == "middle" then
        vim.cmd[[autocmd! KeepCursor]]
        _G.KeepCursorAt = nil
        vim.opt.scrolloff = _G.prev_scrolloff
        print("KeepCursor: Scrolloff returned to default.")
    else
        if _G.KeepCursorAt == "top" or _G.KeepCursorAt == "bottom" then
            vim.cmd[[autocmd! KeepCursor]]
            _G.KeepCursorAt = "middle" -- and again
        else
            _G.prev_scrolloff = vim.opt.scrolloff:get()
        end
        vim.api.nvim_create_augroup("KeepCursor", { clear = true })
        vim.api.nvim_create_autocmd("CursorMoved", { command = "normal! zz", group = "KeepCursor" })
        _G.KeepCursorAt = "middle"
        print("KeepCursor: keeping cursor at middle.")
    end
end


-- disable any cursor autocmd functions
function M.DisableKeepCursor()
    if _G.KeepCursorAt ~= nil then
        vim.cmd[[autocmd! KeepCursor]]
        _G.KeepCursorAt = nil
        -- and return scroll off to default
        vim.opt.scrolloff = _G.prev_scrolloff
        print("KeepCursor: Scrolloff returned to default.")
    end
end

-- for lualine
function M.KeepCursorStatus()
    if _G.KeepCursorAt == nil then
        return nil
    elseif _G.KeepCursorAt == "top" then
        return "  top"
    elseif _G.KeepCursorAt == "middle" then
        return "  mid"
    elseif _G.KeepCursorAt == "bottom" then
        return "  bot"
    end
end

return M
