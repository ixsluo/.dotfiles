" ##########
" # Syntax #
" ##########
syntax on
set nocompatible
filetype on


" ==============
" Format
" ai, ci, si   atuoindent, cindent, smartindent
" sw           shiftwidth   # indent in new line or indent with '<, >'
" ts           tabstop      # to convert space to a tab
" sts          softtabstop  # to insert a <tab> key
" ==============
autocmd FileType bash,python set et ai sw=4 ts=4 sts=4


" ############
" # Beheaver #
" ############
"set paste
set backspace=2


" ######
" # UI #
" ######
set nu
"set relativenumber
let &colorcolumn=81
highlight colorcolumn ctermbg=lightcyan
set laststatus=2
"set ruler
"set statusline=%F%m%r%h%w%=\ [ft=%Y]\ %{\"[fenc=\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"]\"}\ [ff=%{&ff}]\ [asc=%03.3b]\ [hex=%02.2B]\ [pos=%04l,%04v][%p%%]\ [len=%L]
set statusline=%F%m%r%h%w\ [%Y]\ %{&ff}\ »%=«\ %{\"\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"\"}\|%l,%c\|\ \ \ \ %p%%\ %L
"set nowrap
" !!! Color Setting
set t_Co=256  " terminal support 256 color
hi NonText      ctermbg=black    ctermfg=black
hi LineNr       ctermbg=black    ctermfg=grey


" ###################################
" # Special Nonprintable characters #
" ###################################
set list
" for list and listchars
scriptencoding utf-8
set encoding=utf-8
" nontext: eol, extends, precedes
" specialkey: nbsp, tab, trail
"set listchars=tab:‹-›,trail:¬,precedes:«,extends:»
set listchars=tab:›-,trail:¬,precedes:«,extends:»
"hi NonText    ctermfg=darkred ctermbg=grey
hi SpecialKey ctermfg=darkgrey


" ############################################
" # Jump to the last position when reopening #
" ############################################
" Notice   !g`\! rather than !g'\!
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif


" #########################
" # Bracket auto-complete #
" #########################
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap < <><ESC>i
"inoremap " ""<ESC>i
"inoremap ' ''<ESC>i

function! RemovePairs()
    let s:line = getline(".")
    let s:previous_char = s:line[col(".")-1]

    if index(["(","[","{"],s:previous_char) != -1
        let l:original_pos = getpos(".")
        execute "normal %"
        let l:new_pos = getpos(".")
        " only right (
        if l:original_pos == l:new_pos
            execute "normal! a\<BS>"
            return
        end

        let l:line2 = getline(".")
        if len(l:line2) == col(".")
            execute "normal! v%xa"
        else
            execute "normal! v%xi"
        end
    else
        execute "normal! a\<BS>"
    end
endfunction

function! RemoveNextDoubleChar(char)
    let l:line = getline(".")
    let l:next_char = l:line[col(".")]

    if a:char == l:next_char
        execute "normal! l"
    else
        execute "normal! a" . a:char . ""
    end
endfunction

inoremap <BS> <ESC>:call RemovePairs()<CR>a
inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
inoremap ] <ESC>:call RemoveNextDoubleChar(']')<CR>a
inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a
inoremap > <ESC>:call RemoveNextDoubleChar('>')<CR>a

