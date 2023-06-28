" searching via incsearch
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
if exists('$BASE16_THEME') && (!exists('g:colors_name') || g:colors_name != 'base16-$BASE16_THEME')
  let base16colorspace=256
  colorscheme base16-$BASE16_THEME
endif

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
