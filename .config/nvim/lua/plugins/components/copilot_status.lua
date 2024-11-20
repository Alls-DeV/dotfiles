local M = {}

local symbols = {
    enabled = "",
    disabled = "",
}

M.copilot_status = function()
    if vim.g.copilot_on then
        return symbols.enabled
    else
        return symbols.disabled
    end
end

return M
