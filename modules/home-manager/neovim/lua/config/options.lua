-- Set leader key before lazy
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General
vim.opt.mouse = "a"                -- Enable mouse support
vim.opt.clipboard = "unnamedplus"  -- Use system clipboard
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.conceallevel = 3           -- Hide * markup for bold and italic
vim.opt.confirm = true            -- Confirm to save changes before exiting modified buffer
vim.opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"

-- UI
vim.opt.termguicolors = true      -- True color support
vim.opt.number = true             -- Print line number
vim.opt.relativenumber = true     -- Relative line numbers
vim.opt.showmode = false          -- Don't show mode since we have a statusline
vim.opt.signcolumn = "yes"        -- Always show signcolumn
vim.opt.cursorline = true         -- Enable highlighting of the current line
vim.opt.colorcolumn = "80"        -- Line length marker
vim.opt.cmdheight = 1             -- Height of command bar
vim.opt.laststatus = 3            -- Global statusline

-- Indenting
vim.opt.expandtab = true          -- Use spaces instead of tabs
vim.opt.shiftwidth = 2            -- Shift 2 spaces when tab
vim.opt.tabstop = 2               -- 1 tab == 2 spaces
vim.opt.smartindent = true        -- Autoindent new lines
vim.opt.autoindent = true         -- Copy indent from current line when starting new one

-- Files
vim.opt.backup = false            -- No backup file
vim.opt.swapfile = false          -- No swap file
vim.opt.undofile = true          -- Enable persistent undo
vim.opt.undolevels = 10000
vim.opt.writebackup = false       -- No backup file

-- Search
vim.opt.ignorecase = true         -- Ignore case when searching
vim.opt.smartcase = true          -- Don't ignore case with capitals
vim.opt.hlsearch = true           -- Highlight search results
vim.opt.incsearch = true          -- Show search matches as you type

-- Windows
vim.opt.splitbelow = true         -- Put new windows below current
vim.opt.splitright = true         -- Put new windows right of current

-- Better buffer handling
vim.opt.hidden = true             -- Enable modified buffers in background

-- Decrease update time
vim.opt.updatetime = 250          -- Faster completion
vim.opt.timeout = true
vim.opt.timeoutlen = 300          -- Time to wait for a mapped sequence to complete

-- Wild menu
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.wildmenu = true               -- Command-line completion
vim.opt.wildignore = {
  "*.pyc",
  "**/.git/*",
  "**/.svn/*",
  "**/.hg/*",
  "**/CVS/*",
  "**/.DS_Store",
  "**/node_modules/*",
  "**/dist/*",
}

-- Fold settings
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
vim.opt.foldlevel = 99

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 2