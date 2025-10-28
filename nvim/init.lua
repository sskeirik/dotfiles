-- # Vimscript-to-Lua
--
-- ## Options and Variables
--
-- :set       <opt> = <val>   => vim.opt.<opt>        = <val>
--                               vim.o.<opt>          = <val>
-- :setglobal <opt> = <val>   => vim.opt_global.<opt> = <val>
--                               vim.go.<opt>         = <val>
-- :setlocal  <opt> = <val>   => vim.opt_local.<opt>  = <val>
--                               vim.wo.<opt>         = <val> -- local to window
--                               vim.bo.<opt>         = <val> -- local to buffer
-- :let <scope>:<var> = <val> => vim.<scope>.<var>    = <val> -- see scopes below
-- :unlet <scope>:<var>       => vim.<scope>.<var>    = nil   -- see scopes below
--
-- where scope is one of: g (global), t (tab-page), w (window), b (buffer), v (special)
--
-- ## Commands and Functions
--
-- - Execute entire snippet <snippet>:           vim.cmd(<snippet>)
-- - If single <cmd>, also can write:            vim.cmd.<cmd>(<args>)
-- - Vimscript built-in or user function <func>: vim.fn.<func>(<args>)
-- - If <func> has special characters, use:      vim.fn[<func>](<args>)
-- - Can also write:                             vim.call(<func>,<args>)
--
-- # Plugin Loading
--
-- Plugins will be autoloaded when their absolute path matches the followings shape:
--
-- <runtimepath>/pack/*/start/<plugin-root-directory>
--
-- Plugins can be loaded using `vim.cmd.packadd(<plugin-root-directory>)` when their absolute path matches the following shape:
--
-- <runtimepath>/pack/*/opt/<plugin-root-directory>
--
-- When doing a Lua `require('mod')`, neovim will search in the following locations:
--
-- 1.  <runtimepath>/mod.lua
-- 2.  <runtimepath>/lua/mod.lua
-- 3.  <runtimepath>/lua/mod/init.lua
-- 4.  <runtimepath>/pack/*/start/*/mod.lua
-- 5.  <runtimepath>/pack/*/start/*/lua/mod.lua
-- 6.  <runtimepath>/pack/*/start/*/lua/mod/init.lua
-- 7.  the standard Lua package lookup locations
--
-- where:
--
-- 1.  <runtimepath> refers to any directory on the runtimepath
-- 2.  asterisk (*) refers to any single directory component name
-- 3.  <plugin-root-directory> refers to the plugin root directory
--
-- NOTE: The runtimepath variable specifies the vim file searchpath.
--       The package.path and package.cpath variables define Lua file searchpath.
--       Neovim automatically prepends vim runtimepath-derived prefixes to its builtin Lua interpreter package search path to obtain the behavior above.
--
-- # Indentation
--
-- If auto-indentation is screwy, check all of the following options:
--
-- 1.  cindent
-- 2.  smartindent
-- 3.  autoindent
-- 4.  indentexpr

-- # Potential Improvements
--
-- 1.  Consider org-mode/notetaking style plugin: possibilities include:
--
--     -   vimwiki
--     -   vim-orgmode
--
-- 2.  Investigate ninja-feet plugin for movement to beginning/end of text objects

-- header/footer visual options
vim.opt.laststatus    = 3               -- use a global statusline
vim.opt.showcmd       = true            -- show incomplete commands on statusline
vim.opt.showmode      = true            -- show current VIM mode on statusline
vim.opt.title         = true            -- change the terminal's title when running neovim
-- vim.opt.shortmess                    -- make statusline messages shorter (if desired)

-- current buffer visual options
vim.opt.number        = true            -- show line numbers in gutter
vim.opt.signcolumn    = "yes"           -- always show extra status column in gutter
vim.opt.wrap          = false           -- do NOT wrap lines
vim.opt.showbreak     = "‥"             -- ... but if lines are wrapped later, indicate it with this symbol
vim.opt.listchars     = { trail = '·',  -- visualize trailing spaces
                          tab   = '>.'  -- visualize tabs
                        }
vim.opt.list          = true            -- enable invisible character visualization
vim.opt.fillchars:append({vert = '|'})  -- use this symbol to fill gaps in UI borders
vim.opt.guicursor     = "a:blinkon500-blinkwait500-blinkoff500" -- always use blinking block cursor

-- editor highlighting options
vim.opt.cursorline    = true            -- highlight current line
vim.opt.showmatch     = true            -- highlight matching bracket
vim.opt.inccommand    = "nosplit"       -- shows effect of substitution commands on buffer before they are committed
vim.opt.hlsearch      = true            -- highlight searched for terms

-- navigation options
vim.opt.hidden        = true            -- implicitly save buffer contents when switching buffers instead of warning
vim.opt.splitright    = true            -- vertical splits open on the right
vim.opt.splitbelow    = true            -- horizontal splits open on the bottom

-- input device options
vim.opt.mouse         = "a"             -- always enable mouse
vim.opt.timeoutlen    = 1000            -- faster command timeout on escape
vim.opt.ttimeoutlen   = 0               --

-- color options
vim.opt.termguicolors = true            -- use nice colors
-- NOTE: the following command mysteriously causes neovim to
-- re-insert previously deleted lines into the current buffer
-- when opening neovim for the first time --- it's so weird
-- and I have NO IDEA what causes it
-- vim.opt.background = 'light'         -- tells vim what the terminal background color is

-- file options
vim.opt.fileencoding  = "utf-8"         -- always use utf-8 encoding on write

-- keymap options
vim.keymap.set('n',        'Q',     '<Nop>')             -- disable ex mode
vim.keymap.set({'n', 'v'}, 'ga',    '<Plug>(EasyAlign)') -- setup EasyAlign with ga
vim.keymap.set('t',        '<C-[>', '<C-\\><C-n>')       -- ??? port terminal mode binding

-- digraph options
---- subscript digraphs
vim.fn.digraph_set('as', 'ₐ')
vim.fn.digraph_set('es', 'ₑ')
vim.fn.digraph_set('hs', 'ₕ')
vim.fn.digraph_set('is', 'ᵢ')
vim.fn.digraph_set('ks', 'ₖ')
vim.fn.digraph_set('ls', 'ₗ')
vim.fn.digraph_set('ms', 'ₘ')
vim.fn.digraph_set('ns', 'ₙ')
vim.fn.digraph_set('os', 'ₒ')
vim.fn.digraph_set('ps', 'ₚ')
vim.fn.digraph_set('rs', 'ᵣ')
vim.fn.digraph_set('ss', 'ₛ')
vim.fn.digraph_set('ts', 'ₜ')
vim.fn.digraph_set('us', 'ᵤ')
vim.fn.digraph_set('vs', 'ᵥ')
vim.fn.digraph_set('xs', 'ₓ')
---- logic digraphs
vim.fn.digraph_set('+T', '⊤')
vim.fn.digraph_set('rt', '⊢')

-- misc options
vim.opt.history       = 500            -- store N lines of :cmdline history
vim.opt.path:append({ '**' })          -- search paths recursively when use find-family of commands
vim.opt.grepprg       = 'rg --vimgrep' -- use ripgrep for vim grep command

-- documented unset options
vim.opt.lazyredraw     = false          -- disable redrawing when exeucting macros
vim.opt.linebreak      = false          -- when wrapping long lines, break on words (useful for prose editing)
vim.opt.relativenumber = false          -- do not show line numbers relative to the current line
vim.opt.conceallevel   = 0              -- 0 - do not conceal text
                                        -- 1 - represent concealed text groups by single char
                                        -- 2 - hide concealed text groups unless specific replacement char is defined
                                        -- 3 - fully hide concealed text groups

-- set global variables
vim.g.loaded_matchit                       = 1                               -- do not load matchit, use matchup plugin
vim.g.mapleader                            = ' '                             -- change leader to a space
vim.g.netrw_home                           = vim.fn.expand('~/.cache/nvim/') -- move netrwhistory file to cache
vim.g.polyglot_disabled                    = { 'latex' }                     -- disable polyglot latex plugin
vim.g.vim_markdown_no_default_key_mappings = 1                               -- disable polyglot markdown keybindings; why does this even come with bindings?
vim.g.vim_markdown_math                    = 1                               -- enable latex math highlighting in markdown

-- initialize lua plugins
require("which-key").setup { }
require("gitsigns").setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
-- require("colorscheme-file").setup {
--   path   = vim.fn.expand('~/.base16_theme_id'),
--   silent = true
-- }
-- TODO: extract highlight loader plugin; fix colorscheme detection
-- TODO: integrate nvim templates into my templater
require('tinted-colorscheme').setup('base24-ayu-dark', {
  supports = { tinty = false, live_reload = false },
})
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  -- ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- load everforest colorscheme
vim.cmd.packadd('everforest')

-- source legacy vimscript config file
vim.cmd('source ~/.config/nvim/legacy-config.vim')
