" Minimal, portable Vim configuration for macOS and Ubuntu.

set number
set autoindent
set smartindent
set expandtab
set shiftwidth=4
set tabstop=4
set ignorecase
set smartcase
set hlsearch
set incsearch

if has('syntax')
  syntax enable
endif

" Send normal yank operations to the terminal clipboard with OSC 52.
" The helper receives the text via stdin, so yanked content is never placed in
" a shell command. A missing or failed helper does not affect Vim registers.
function! s:osc52_yank() abort
  if v:event.operator !=# 'y' || v:event.regname ==# '_'
    return
  endif

  let l:osc52copy = expand('~/.local/bin/osc52copy')
  if !executable(l:osc52copy)
    return
  endif

  let l:text = join(v:event.regcontents, "\n")
  " regcontents omits the final newline of a linewise register.
  if v:event.regtype ==# 'V'
    let l:text .= "\n"
  endif

  silent! call system(shellescape(l:osc52copy), l:text)
endfunction

if exists('##TextYankPost')
  augroup osc52_yank
    autocmd!
    autocmd TextYankPost * call <SID>osc52_yank()
  augroup END
endif
