execute pathogen#infect()

" NB: If help isn't working, run :Helptags

" TODO: consider org-mode/notetaking style plugin
"       possibilities include:
"       [1] vimwiki
"       [2] vim-orgmode
"
"       investigate ninja-feet plugin for movement to
"       beginning/end of text objects

" Thanks to https://github.com/kristijanhusak/neovim-config
let g:loaded_matchit = 1                                     "Do not load matchit, use matchup plugin

let g:mapleader = ','                                        "Change leader to a comma

set termguicolors                                            "use nice colors
set title                                                    "change the terminal's title
set number                                                   "Line numbers are good
" set relativenumber                                           "Show numbers relative to current line
set history=500                                              "Store lots of :cmdline history
set showcmd                                                  "Show incomplete cmds down the bottom
set showmode                                                 "Show vim's mode
set signcolumn=yes                                           "Show sign colum always
" set gdefault                                                 "Set global flag for search and replace
set guicursor=a:blinkon500-blinkwait500-blinkoff500          "Set cursor blinking rate
set cursorline                                               "Highlight current line
set mouse=a                                                  "Enable mouse usage
set showmatch                                                "Highlight matching bracket
" set nostartofline                                            "Jump to first non-blank character
set timeoutlen=1000 ttimeoutlen=0                            "Reduce Command timeout for faster escape and O
set fileencoding=utf-8                                       "Set utf-8 encoding on write
set nowrap                                                   "Word wrap setting
"set linebreak                                                "Wrap lines at convenient points
set showbreak=‥
set listchars=tab:\ \ ,trail:·                               "Set trails for tabs and spaces
set list                                                     "Enable listchars
set lazyredraw                                               "Do not redraw on registers and macros
set background=dark                                          "Set background to dark
set hidden                                                   "Hide buffers in background
" set conceallevel=2 concealcursor=i                           "neosnippets conceal marker
set splitright                                               "Set up new vertical splits positions
set splitbelow                                               "Set up new horizontal splits positions
set path+=**                                                 "Allow recursive search
set inccommand=nosplit                                       "Show substitute changes immidiately in separate split
set fillchars+=vert:\│                                       "Make vertical split separator full line
set pumheight=15                                             "Maximum number of entries in autocomplete popup
" set exrc                                                     "Allow using local vimrc
" set secure                                                   "Forbid autocmd in local vimrc
set grepprg=rg\ --vimgrep                                    "Use ripgrep for grepping
" set tagcase=smart                                            "Use smartcase for tags
" set updatetime=500                                           "Cursor hold timeout
set synmaxcol=300                                            "Use syntax highlighting only for 300 columns
" set shortmess+=c                                             "Disable completion menu messages in command line
" set completeopt-=preview                                     "Disable preview window for autocompletion
set wildmode=longest,list,full                               "Make tab completion nicer
set wildmenu
let g:netrw_home=expand('~/.cache/nvim/')                    "Move netrwhistory file to cache
let g:polyglot_disabled = ['latex']                          "Disable polyglot latex plugin

" searching via incsearch
set hlsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" move undo directory under cache
set undofile
let undo_path = expand('~/.cache/nvim/undo/')
if !isdirectory(undo_path)
  call system('mkdir -p ' . undo_path)
endif
let &undodir = undo_path

" set highligting and indentation
filetype plugin indent on
syntax on

" source colorscheme file
if filereadable(expand("~/.vimrc_background"))
  " let base16colorspace=256
  source ~/.vimrc_background
endif

" disable ex mode
nnoremap Q <Nop>

" configure terminal mode and external command execution
:tnoremap <C-[> <C-\><C-n>
" configure for windows with 64-bit git-bash
if has("win32")
  :nnoremap <Leader>c :tabnew<CR>:term C:\Progra~1\Git\bin\bash<CR>i
  let shell='cmd.exe'
  let shellcmdflag='/c "C:\Progra~1\Git\bin\bash -c"'
else
  :nnoremap <Leader>c :tabnew<CR>:term<CR>i
endif

" general vimtex configuration
let g:tex_flavor = 'latex'
" 0 never auto-open, 1 auto-open on error, 2 auto-open on warning
let g:vimtex_quickfix_mode = 0
" 0 never auto-close, or auto-close afte n events
let g:vimtex_quickfix_autoclose_after_keystrokes = 0
" configure vimtex for windows with 64-bit SumatraPDF
if has("win32")
  " set to nvr for neovim (should be in PATH)
  let g:vimtex_compiler_progname = 'nvr'
  let g:vimtex_view_method = 'general'
  let g:vimtex_view_general_viewer = 'C:\Progra~1\SumatraPDF\SumatraPDF.exe'
  let g:vimtex_view_general_options_latexmk = '-reuse-instance'
  let g:vimtex_view_general_options
      \ = '-reuse-instance -forward-search @tex @line @pdf'
      \ . ' -inverse-search "nvr --servername ' . v:servername
      \ . ' --remote-send \"^<C-\^>^<C-n^>'
      \ . ':drop \%f^<CR^>:\%l^<CR^>:normal\! zzzv^<CR^>'
      \ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
      \ . ':\%l^<CR^>:normal\! zzzv'
      \ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""'
endif
" configure vimtex for OSX
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    let g:vimtex_view_method = 'general'
  endif
endif

" Use spaces instead of tabs for any files that have no tabs
" near the beginning (in the first thousand lines)
function! s:ExpandTabCheck()
    let s:tab = search("\t", "n")", 1000)
    if s:tab == 0
	setlocal expandtab
    endif
endfunction

" setup autocommands
augroup MyCommands
  au!
  " in the Command Window, on <F5> run line and reopen window on current line
  au CmdwinEnter  * nnoremap <buffer> <F5> :let g:CmdWindowLineMark=line(".")<CR><CR>q::<C-R>=CmdWindowLineMark<CR><CR>
  " enable rainbow parentheses when a filetype is detected
  au FileType     * RainbowParentheses
  " jump to last remembered position in file (except for git commits)
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") && &filetype != "gitcommit" | exe "normal! g'\"" | endif
  " set tabs to spaces for any files with tabs
  au BufEnter * call s:ExpandTabCheck()
augroup END


" mappings for Easy Align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" add some fun digraphs
"
" digraphs for subscript letters
execute "digraphs as " . 0x2090
execute "digraphs es " . 0x2091
execute "digraphs hs " . 0x2095
execute "digraphs is " . 0x1D62
execute "digraphs ks " . 0x2096
execute "digraphs ls " . 0x2097
execute "digraphs ms " . 0x2098
execute "digraphs ns " . 0x2099
execute "digraphs os " . 0x2092
execute "digraphs ps " . 0x209A
execute "digraphs rs " . 0x1D63
execute "digraphs ss " . 0x209B
execute "digraphs ts " . 0x209C
execute "digraphs us " . 0x1D64
execute "digraphs vs " . 0x1D65
execute "digraphs xs " . 0x2093
" digraph for logical true
execute "digraphs +T " . 0x22A4
execute "digraphs rt " . 0x22A2
