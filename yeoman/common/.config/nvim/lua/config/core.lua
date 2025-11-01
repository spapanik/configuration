local opt = vim.opt
local g = vim.g

-- Leader Keys
g.mapleader = " "
g.maplocalleader = ","

-- UI & Display
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true
opt.showmode = false
opt.cmdheight = 1
opt.pumheight = 10
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Special characters
opt.list = true
opt.listchars = {
    tab = "» ",
    trail = "·",
    nbsp = "␣",
    extends = "›",
    precedes = "‹",
}
opt.showbreak = "↪ "
opt.fillchars = {
    fold = "-",
    foldopen = "-",
    foldclose = "+",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}

-- Editor Behavior
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.confirm = true
opt.autoread = true
opt.undofile = true

-- Indentation & Formatting
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"

-- Splits & Windows
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "screen"

-- Folding
opt.foldmethod = "expr"
--opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevelstart = 99

-- Spelling
opt.spelllang = "en_gb"
opt.spelloptions = "camel"

-- Files & Backups
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- Completion & Wildmenu
opt.wildmode = "longest:full,full"
opt.wildignore:append({
    "*.pyc",
    "*.pyo",
    "*/__pycache__/*",
    "*.o",
    "*/out/*",
    "*/node_modules/*",
    "*/.git/*",
    "*/dist/*",
    "*/build/*",
    "*/target/*",
    "*/.next/*",
    "*.class",
})

-- Timing & Performance
opt.updatetime = 250
opt.timeoutlen = 300
opt.timeout = true
opt.ttimeout = true
opt.ttimeoutlen = 10

-- Navigation
opt.whichwrap:append("<,>,[,],h,l")
opt.suffixesadd = { ".js", ".jsx", ".ts", ".tsx", ".lua", ".tex" }

-- Miscellaneous
opt.shortmess:append("WcC")
opt.background = "dark"
