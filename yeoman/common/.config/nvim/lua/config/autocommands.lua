local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local filetype_detect = augroup("FiletypeDetect", { clear = true })

local filetype_patterns = {
    { pattern = "*.tmux", filetype = "tmux" },
    { pattern = "*.ssh", filetype = "sshconfig" },
    { pattern = "*.git", filetype = "gitconfig" },
    { pattern = "*.cron", filetype = "crontab" },
}

for _, ft in ipairs(filetype_patterns) do
    autocmd({ "BufRead", "BufNewFile" }, {
        group = filetype_detect,
        pattern = ft.pattern,
        callback = function()
            vim.bo.filetype = ft.filetype
        end,
    })
end
