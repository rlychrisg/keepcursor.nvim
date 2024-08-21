local M = {}

M.config = {
    enabled_on_start_v = "none",
    enabled_on_start_h = "none"
    }

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
        -- set new scroll off, if user provides one
        if newscrolloff then
            vim.opt.scrolloff = newscrolloff
        end
        -- create the autocmd
        vim.api.nvim_create_augroup("KeepCursor", { clear = true })
        vim.api.nvim_create_autocmd("CursorMoved", { command = "normal! zt", group = "KeepCursor" })

        _G.KeepCursorAt = "top"

        -- if func starts on startup then don't show message
        if _G.onstart_v == true then
            _G.onstart_v = false
        else
            print("KeepCursor: keeping cursor at top.")
        end
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

        if _G.onstart_v == true then
            _G.onstart_v = false
        else
            print("KeepCursor: keeping cursor at bottom.")
        end
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

        if _G.onstart_v == true then
            _G.onstart_v = false
        else
            print("KeepCursor: keeping cursor at middle.")
        end
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

-- sideways cursor movement, should be separate from verti
function M.ToggleCursorRight(newscrolloff)
    if _G.KeepSideCursorAt == "right" then
        vim.cmd[[autocmd! KeepSideCursor]] -- doing this in lua throws errors sometimes so for now sticking with vimscript
        _G.KeepSideCursorAt = nil
        vim.opt.sidescrolloff = _G.prev_sidescrolloff
        print("KeepCursor: Scrolloff returned to default.")
    else
        -- if the other one is enabled
        if _G.KeepSideCursorAt == "left" then
            vim.cmd[[autocmd! KeepSideCursor]]
            _G.KeepSideCursorAt = "right"
        else
            _G.prev_sidescrolloff = vim.opt.sidescrolloff:get()
        end

        if newscrolloff then
            vim.opt.sidescrolloff = newscrolloff
        end
        vim.api.nvim_create_augroup("KeepSideCursor", { clear = true })
        vim.api.nvim_create_autocmd("CursorMoved", { command = "normal! ze", group = "KeepSideCursor" })

        _G.KeepSideCursorAt = "right"

        if _G.onstart_h == true then
            _G.onstart_h = false
        else
            print("KeepCursor: keeping cursor to the right.")
        end
    end
end

-- sideways cursor movement, should be separate from verti
function M.ToggleCursorLeft(newscrolloff)
    if _G.KeepSideCursorAt == "left" then
        vim.cmd[[autocmd! KeepSideCursor]] -- doing this in lua throws errors sometimes so for now sticking with vimscript
        _G.KeepSideCursorAt = nil
        vim.opt.sidescrolloff = _G.prev_sidescrolloff
        print("KeepCursor: Scrolloff returned to default.")
    else
        -- if the other one is enabled
        if _G.KeepSideCursorAt == "right" then
            vim.cmd[[autocmd! KeepSideCursor]]
            _G.KeepSideCursorAt = "left"
        else
            _G.prev_sidescrolloff = vim.opt.sidescrolloff:get()
        end

        if newscrolloff then
            vim.opt.sidescrolloff = newscrolloff
        end
        vim.api.nvim_create_augroup("KeepSideCursor", { clear = true })
        vim.api.nvim_create_autocmd("CursorMoved", { command = "normal! zs", group = "KeepSideCursor" })

        _G.KeepSideCursorAt = "left"

        if _G.onstart_h == true then
            _G.onstart_h = false
        else
            print("KeepCursor: keeping cursor to the left.")
        end
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

function M.setup(opts)
    -- if different values are passed to user config, use those instead
    M.config = vim.tbl_deep_extend("force", M.config, opts or {})

    -- vertical
    local enabled_on_start_v = M.config.enabled_on_start_v

    if enabled_on_start_v == "top" then
        _G.onstart_v = true
        M.ToggleCursorTop()
    elseif enabled_on_start_v == "middle" then
        _G.onstart_v = true
        M.ToggleCursorMid()
    elseif enabled_on_start_v == "bottom" then
        _G.onstart_v = true
        M.ToggleCursorBot()
    end

    local enabled_on_start_h = M.config.enabled_on_start_h
    if enabled_on_start_h == "left" then
        _G.onstart_h = true
        M.ToggleCursorLeft()
    elseif enabled_on_start_h == "right" then
        _G.onstart_h = true
        M.ToggleCursorRight()
    end
end

-- create commands for funcs
vim.api.nvim_create_user_command('ToggleCursorTop', function(opts)
    local arg = tonumber(opts.args)
    M.ToggleCursorTop(arg)
end, { nargs = "?", })

vim.api.nvim_create_user_command('ToggleCursorBot', function(opts)
    local arg = tonumber(opts.args)
    M.ToggleCursorBot(arg)
end, { nargs = "?", })

vim.api.nvim_create_user_command('ToggleCursorMid', function()
    M.ToggleCursorMid()
end, {})

vim.api.nvim_create_user_command('DisableKeepCursor', function()
    M.DisableKeepCursor()
end, {})

vim.api.nvim_create_user_command('ToggleCursorRight', function(opts)
    local arg = tonumber(opts.args)
    M.ToggleCursorRight(arg)
end, { nargs = "?", })

vim.api.nvim_create_user_command('ToggleCursorLeft', function(opts)
    local arg = tonumber(opts.args)
    M.ToggleCursorLeft(arg)
end, { nargs = "?", })

return M
