" Load custom filetypes
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufNewFile,BufRead *.maude set ft=maude
augroup END
