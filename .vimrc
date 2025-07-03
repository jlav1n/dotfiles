set expandtab tabstop=4 shiftwidth=4 softtabstop=4
set ai ignorecase smartcase smarttab hlsearch incsearch copyindent
set foldcolumn=0
set history=10000
set number

syntax on

let perl_sub_signatures = 1  " this has to be here, above the plugin

set matchpairs+=<:>

map		<F12>	:if exists("syntax_on") <Bar> syntax off <Bar> else <Bar> syntax enable <Bar> endif<CR>
vmap <Leader>b  :<C-U>!git blame -w <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
map  <Leader>l  :!clear && git log %<CR>
map  <Leader>gg :!clear && git grep
map  <Leader>L  :Lost<CR>
vmap <Leader>f  !perl -MText::Autoformat -X -0777 -e 'autoformat {all=>1,break=>break_wrap}'<CR>

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
map <Leader>s :sp <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
"map <Leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>

nmap <leader>h :nohlsearch<CR>
nmap <leader>t :set expandtab<CR>
nmap <leader>T :set noexpandtab<CR>

filetype plugin on 
" http://vim.wikia.com/wiki/Disable_automatic_comment_insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

autocmd FileType css setlocal tabstop=2 shiftwidth=2
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2
"autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

" terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1
autocmd FileType terraform setlocal tabstop=2 shiftwidth=2

augroup mkd
  autocmd BufRead *.md  set ai formatoptions=tcroqn2 comments=n:>
augroup END

au BufNewFile,BufRead *.hbs set filetype=html
"au BufNewFile,BufRead *.tt2 set filetype=html
au BufNewFile,BufRead *.t set filetype=perl
au BufNewFile,BufRead *.psgi set filetype=perl
au BufNewFile,BufRead *.pl6 set filetype=perl6
au BufNewFile,BufRead *.pm6 set filetype=perl6
au BufNewFile,BufRead *.pgsql set filetype=sql

command! Q q " Bind :Q to :q
command! W w
command! Wq wq

" Better? completion on command line
set wildmenu
" What to do when I press 'wildchar'. Worth tweaking to see what feels right.
set wildmode=list:full

" jump to last cursor position - the Enter cmd has issues
au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview

highlight Search ctermfg=Black
highlight DiffAdd ctermfg=Black
highlight DiffChange ctermfg=Black
highlight ColorColumn ctermfg=Black
"highlight SpellCap ctermfg=Black

" Make the omnicomplete text readable
highlight PmenuSel ctermfg=white
" Make it more obvious which paren I'm on
highlight MatchParen ctermfg=black
" Make search wrapping more obvious
highlight WarningMsg ctermfg=white ctermbg=red guifg=White guibg=Red gui=None

set tags=./tags;

execute pathogen#infect()
Helptags

set wildignore+=*/.git/*

set updatetime=100  " for gitgutter

"====
"====[ BEGIN Damian configs         ]=========
"====[ https://youtu.be/oka4wcsrg0c ]=========
"====

"====[ Work out what kind of file this is ]========

filetype plugin indent on

augroup FiletypeInference
    autocmd!
    autocmd BufNewFile,BufRead  *.t      setfiletype perl
    autocmd BufNewFile,BufRead  *.pod    setfiletype pod
    autocmd BufNewFile,BufRead  *        call s:infer_filetype()
augroup END

function! s:infer_filetype ()
    for line in getline(1,20)
        if line =~ '^\s*use\s*v\?5\.\S\+\s*;\s*$'
            setfiletype perl
            return
        elseif line =~ '^\s*use\s*v\?6\s*;\s*$'
            setfiletype perl6
            return
        endif
    endfor
endfunction


"=====[ Configure % key (via matchit plugin) ]==============================

" Match angle brackets...
set matchpairs+=<:>,«:»,｢:｣




"=====[ Adjust keyword characters to match Perlish identifiers ]===============

set iskeyword+=$
set iskeyword+=%
set iskeyword+=@-@
set iskeyword+=:
set iskeyword-=,




"=====[ Auto-setup for new files ]===========
" https://youtu.be/oka4wcsrg0c?t=1m42s

"augroup New_File_Setup
"    autocmd!
"    autocmd BufNewFile   *  -1r !vim_file_template <afile>
"    autocmd BufNewFile   *  :silent call search('^[ \t]*[#"].*implementation[ \t]\+here')
"    autocmd BufNewFile   *  :redraw
"augroup END


" =====[ Smart completion via <TAB> and <S-TAB> ]=============
" https://youtu.be/oka4wcsrg0c?t=22m25s

runtime plugin/smartcom.vim

" Add extra completions (mainly for Perl programming)...

let ANYTHING = ""
let NOTHING  = ""
let EOL      = '\s*$'

                " Left     Right      Insert                             Reset cursor
                " =====    =====      ===============================    ============
call SmartcomAdd( '<<',    ANYTHING,  "\<BS>\<BS>«"                                    )
call SmartcomAdd( '>>',    ANYTHING,  "\<BS>\<BS>»"                                    )
call SmartcomAdd( '?',     ANYTHING,  '?',                               {'restore':1} )
call SmartcomAdd( '?',     '?',       "\<CR>\<ESC>O\<TAB>"                             )
call SmartcomAdd( '{{',    ANYTHING,  '}}',                              {'restore':1} )
call SmartcomAdd( '{{',    '}}',      NOTHING,                                         )
call SmartcomAdd( 'qr{',   ANYTHING,  '}xms',                            {'restore':1} )
call SmartcomAdd( 'qr{',   '}xms',    "\<CR>\<C-D>\<ESC>O\<C-D>\<TAB>"                 )
call SmartcomAdd( 'm{',    ANYTHING,  '}xms',                            {'restore':1} )
call SmartcomAdd( 'm{',    '}xms',    "\<CR>\<C-D>\<ESC>O\<C-D>\<TAB>",                )
call SmartcomAdd( 's{',    ANYTHING,  '}{}xms',                          {'restore':1} )
call SmartcomAdd( 's{',    '}{}xms',  "\<CR>\<C-D>\<ESC>O\<C-D>\<TAB>",                )
call SmartcomAdd( '\*\*',  ANYTHING,  '**',                              {'restore':1} )
call SmartcomAdd( '\*\*',  '\*\*',    NOTHING,                                         )

" Handle single : correctly...
call SmartcomAdd( '^:\|[^:]:',  EOL,  "\<TAB>" )

" In the middle of a keyword: delete the rest of the keyword before completing...
                " Left     Right                    Insert
                " =====    =====                    =======================
"call SmartcomAdd( '\k',    '\k\+\%(\k\|\n\)\@!',    "\<C-O>cw\<C-X>\<C-N>",           )
"call SmartcomAdd( '\k',    '\k\+\_$',               "\<C-O>cw\<C-X>\<C-N>",           )

"After an alignable, align...
" https://youtu.be/oka4wcsrg0c?t=21m6s
function! AlignOnPat (pat)
    return "\<ESC>:call EQAS_Align('nmap',{'pattern':'" . a:pat . "'})\<CR>A"
endfunction
                " Left         Right        Insert
                " ==========   =====        =============================
call SmartcomAdd( '=',         ANYTHING,    "\<ESC>:call EQAS_Align('nmap')\<CR>A")
call SmartcomAdd( '=>',        ANYTHING,    AlignOnPat('=>') )
call SmartcomAdd( '\s#',       ANYTHING,    AlignOnPat('\%(\S\s*\)\@<= #') )
call SmartcomAdd( '[''"]\s*:', ANYTHING,    AlignOnPat(':'),                   {'filetype':'vim'} )
call SmartcomAdd( ':',         ANYTHING,    "\<TAB>",                          {'filetype':'vim'} )


                " Left         Right   Insert                                  Where
                " ==========   =====   =============================           ===================
" Perl keywords...
call SmartcomAdd( '^\s*for',   EOL,    " my $___ (___) {\n___\n}\n___",        {'filetype':'perl'} )
call SmartcomAdd( '^\s*if',    EOL,    " (___) {\n___\n}\n___",                {'filetype':'perl'} )
call SmartcomAdd( '^\s*while', EOL,    " (___) {\n___\n}\n___",                {'filetype':'perl'} )
call SmartcomAdd( '^\s*given', EOL,    " (___) {\n___\n}\n___",                {'filetype':'perl'} )
call SmartcomAdd( '^\s*when',  EOL,    " (___) {\n___\n}\n___",                {'filetype':'perl'} )
call SmartcomAdd( '^\s*sub',   EOL,    " ___ (___) {\n___\n}\n___",            {'filetype':'perl'} )

call SmartcomAdd( '^\s*wdd',   ANYTHING, "\<BS>\<BS>\<BS>warn Data::Dumper::Dumper(___);", {'filetype':'perl'} )
call SmartcomAdd( '^\s*dex',   ANYTHING, "\<BS>\<BS>\<BS>diag Data::Dumper::Dumper ___;",  {'filetype':'perl'} )


" Convert between single- and double-quoted string endings...
" https://youtu.be/oka4wcsrg0c?t=24m21s
call SmartcomAdd(      '''[^"]*"',  NOTHING,  "\<ESC>?'\<CR>:nohlsearch\<CR>r\"a",        {'restore':1+1} )
call SmartcomAdd( 'q\@<!q{[^"]*"',  NOTHING,  "\<BS>}\<ESC>?q{\<CR>:nohlsearch\<CR>sqq",  {'restore':1+2} )
call SmartcomAdd(     '"[^'']*''',  NOTHING,  "\<ESC>?\"\<CR>:nohlsearch\<CR>r'a",        {'restore':1+1} )
call SmartcomAdd(   'qq{[^'']*''',  NOTHING,  "\<BS>}\<ESC>?qq{\<CR>:nohlsearch\<CR>2sq", {'restore':1+1} )



"=====[ Correct common mistypings in-the-fly ]=======================

iab    retrun  return
iab     pritn  print
iab      Pelr  Perl
iab      pelr  perl



"=====[ Add or subtract comments ]===============================

" Work out what the comment character is, by filetype...
autocmd FileType             *sh,awk,python,perl,perl6,ruby    let b:cmt = exists('b:cmt') ? b:cmt : '#'
autocmd FileType             vim                               let b:cmt = exists('b:cmt') ? b:cmt : '"'
autocmd FileType             go                                let b:cmt = exists('b:cmt') ? b:cmt : '//'
autocmd BufNewFile,BufRead   *.vim,.vimrc                      let b:cmt = exists('b:cmt') ? b:cmt : '"'
autocmd BufNewFile,BufRead   *                                 let b:cmt = exists('b:cmt') ? b:cmt : '#'
autocmd BufNewFile,BufRead   *.p[lm],.t                        let b:cmt = exists('b:cmt') ? b:cmt : '#'

" Work out whether the line has a comment then reverse that condition...
function! ToggleComment ()
    " What's the comment character???
    let comment_char = exists('b:cmt') ? b:cmt : '#'

    " Grab the line and work out whether it's commented...
    let currline = getline(".")

    " If so, remove it and rewrite the line...
    if currline =~ '^' . comment_char
        let repline = substitute(currline, '^' . comment_char, "", "")
        call setline(".", repline)

    " Otherwise, insert it...
    else
        let repline = substitute(currline, '^', comment_char, "")
        call setline(".", repline)
    endif
endfunction

" Toggle comments down an entire visual selection of lines...
function! ToggleBlock () range
    " What's the comment character???
    let comment_char = exists('b:cmt') ? b:cmt : '#'

    " Start at the first line...
    let linenum = a:firstline

    " Get all the lines, and decide their comment state by examining the first...
    let currline = getline(a:firstline, a:lastline)
    if currline[0] =~ '^' . comment_char
        " If the first line is commented, decomment all...
        for line in currline
            let repline = substitute(line, '^' . comment_char, "", "")
            call setline(linenum, repline)
            let linenum += 1
        endfor
    else
        " Otherwise, encomment all...
        for line in currline
            let repline = substitute(line, '^\('. comment_char . '\)\?', comment_char, "")
            call setline(linenum, repline)
            let linenum += 1
        endfor
    endif
endfunction

" Set up the relevant mappings
nmap     <silent> # :call ToggleComment()<CR>j0
vnoremap <silent> # :call ToggleBlock()<CR>



"=====[ Search folding ]=====================

" Don't start new buffers folded
set foldlevelstart=99

" Highlight folds
highlight Folded  ctermfg=cyan ctermbg=black

" Toggle on and off...
nmap <silent> <expr>  ff  FS_ToggleFoldAroundSearch({'context':1})

" Show only sub defns (and maybe comments)...
let perl_sub_pat = '^\s*\%(sub\|func\|method\|package\)\s\+\k\+'
let vim_sub_pat  = '^\s*fu\%[nction!]\s\+\k\+'
augroup FoldSub
    autocmd!
    autocmd BufEnter * nmap <silent> <expr>  zp  FS_FoldAroundTarget(perl_sub_pat,{'context':1})
    autocmd BufEnter * nmap <silent> <expr>  za  FS_FoldAroundTarget(perl_sub_pat.'\zs\\|^\s*#.*',{'context':0, 'folds':'invisible'})
    autocmd BufEnter *.vim,.vimrc nmap <silent> <expr>  zp  FS_FoldAroundTarget(vim_sub_pat,{'context':1})
    autocmd BufEnter *.vim,.vimrc nmap <silent> <expr>  za  FS_FoldAroundTarget(vim_sub_pat.'\\|^\s*".*',{'context':0, 'folds':'invisible'})
    autocmd BufEnter * nmap <silent> <expr>             zv  FS_FoldAroundTarget(vim_sub_pat.'\\|^\s*".*',{'context':0, 'folds':'invisible'})
augroup END

" Show only 'use' statements
nmap <silent> <expr>  zu  FS_FoldAroundTarget('^\s*use\s\+\S.*;',{'context':1})



"=====[ Smarter interstitial completions of identifiers ]=============
"
" When autocompleting within an identifier, prevent duplications...

augroup Undouble_Completions
    autocmd!
    autocmd CompleteDone *  call Undouble_Completions()
augroup END

function! Undouble_Completions ()
    let col  = getpos('.')[2]
    let line = getline('.')
    call setline('.', substitute(line, '\(\.\?\k\+\)\%'.col.'c\zs\1', '', ''))
endfunction



"=====[ ,, as => without delays ]===================
" https://youtu.be/oka4wcsrg0c?t=21m14s

inoremap <expr><silent>  ,  Smartcomma()

function! Smartcomma ()
    let [bufnum, lnum, col, off, curswant] = getcurpos()
    if getline('.') =~ (',\%' . (col+off) . 'c')
        return "\<C-H>=>"
    else
        return ','
    endif
endfunction


"======[ Breakindenting ]========

set breakindentopt=shift:2,sbr
set showbreak=↪
set breakindent


"=====[ Configure Hier for error highlighting ]===================
" You also need to install the following:  https://github.com/jceb/vim-hier

highlight HierError    ctermfg=red     cterm=bold
highlight HierWarning  ctermfg=magenta cterm=bold

let g:hier_highlight_group_qf  = 'HierError'
let g:hier_highlight_group_qfw = 'HierWarning'

let g:hier_highlight_group_loc  = 'Normal'
let g:hier_highlight_group_locw = 'HierWarning'
let g:hier_highlight_group_loci = 'Normal'


"=====[ Configure ALE for error tracking ]==================
" You also need to install the following:  https://github.com/w0rp/ale

" these 2 lines cause color issues in Go files:
"highlight AleError    ctermfg=red     cterm=bold
"highlight AleWarning  ctermfg=magenta cterm=bold

augroup ALE_Autoconfig
    au!
    autocmd User GVI_Start  silent call Stop_ALE()
    autocmd User PV_Start   silent call Stop_ALE()
    autocmd User PV_End     silent call Start_ALE()
    autocmd User ALELint    silent HierUpdate
augroup END

let g:ale_set_loclist          = 0
let g:ale_set_quickfix         = 1
let g:ale_set_signs            = 0
let g:ale_perl_perl_executable = 'polyperl'
let g:ale_perl_perl_options    = '-cw -Ilib'

nmap <silent> ;m [Toggle automake on Perl files] :call Toggle_ALE()<CR>

function! Start_ALE ()
    ALEEnable
    HierStart
endfunction

function! Stop_ALE ()
    silent call s:ChangeProfile(&filetype)
    ALEDisable
    HierStop
    call setqflist([])
    redraw!
endfunction

function! Toggle_ALE ()
    if g:ale_enabled
        call Stop_ALE()
    else
        call Start_ALE()
    endif
    echo 'Error highlighting ' . (g:ale_enabled ? 'on' : 'off')
endfunction

" cv (change variable) - https://youtu.be/oka4wcsrg0c?t=8m1s
