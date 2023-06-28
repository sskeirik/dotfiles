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
vim.opt.background    = 'light'         -- tells vim what the terminal background color is
vim.opt.termguicolors = true            -- use nice colors

-- file options
vim.opt.fileencoding  = "utf-8"         -- always use utf-8 encoding on write

-- keymap options
vim.keymap.set('n',        'Q',  '<Nop>')             -- disable ex mode
vim.keymap.set({'n', 'v'}, 'ga', '<Plug>(EasyAlign)') -- setup EasyAlign with ga

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
vim.opt.history       = 500             -- store N lines of :cmdline history
vim.opt.path:append({ '**' })           -- search paths recursively when use find-family of commands
vim.opt.grepprg       = 'rg --vimgrep'  -- use ripgrep for vim grep command

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

-- load plugins
vim.opt.packpath = { vim.fn.expand('~/.config/nvim/bundle'), unpack(vim.opt.packpath) }
-- require "which-key" { }

-- source legacy vimscript config file
vim.cmd('source ~/.config/nvim/legacy-config.vim')
