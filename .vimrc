set expandtab tabstop=4 shiftwidth=4 softtabstop=4
set ai ignorecase smartcase smarttab hlsearch incsearch copyindent
set autowrite

syntax on

let $BASH_ENV = '~/.bash_aliases_for_vim'

let perl_sub_signatures = 1  " this has to be here, above the plugin

set matchpairs+=<:>
map  <leader>f !G perl -MText::Autoformat -X -e 'autoformat { tabspace => 4 }'
vmap <leader>f !perl -MText::Autoformat -X -0777 -e 'autoformat {all=>1,break=>break_wrap}'
vmap    _L      "zxi[L][/L]F["zP
map		<F12>	:if exists("syntax_on") <Bar> syntax off <Bar> else <Bar> syntax enable <Bar> endif<CR>

vmap <Leader>b :<C-U>!git blame -w <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
map <Leader>s :sp <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>

"set formatoptions=tcqn1r
"set flp+=\\\|^\\*\\s*

nmap <leader>h :nohlsearch<CR>
nmap <leader>t :set expandtab<CR>
nmap <leader>T :set noexpandtab<CR>

" fix syntax redraw problems:
autocmd BufEnter * :syntax sync fromstart

filetype plugin on 
" http://vim.wikia.com/wiki/Disable_automatic_comment_insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" move visually-selected blocks up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

autocmd FileType css setlocal tabstop=2 shiftwidth=2
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2
autocmd FileType go setlocal noexpandtab
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

augroup mkd
  autocmd BufRead *.md  set ai formatoptions=tcroqn2 comments=n:>
augroup END

au BufNewFile,BufRead *.hbs set filetype=html
au BufNewFile,BufRead *.tt2 set filetype=html
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

" jump to last cursor position
au BufWinLeave * mkview
au BufWinEnter * silent loadview

set undofile  " Maintain undo history between sessions
set undodir=~/.vim/undodir

highlight Search ctermfg=Black
highlight DiffAdd ctermfg=Black
highlight DiffChange ctermfg=Black
highlight ColorColumn ctermfg=Black

" Make the omnicomplete text readable
highlight PmenuSel ctermfg=white
" Make it more obvious which paren I'm on
highlight MatchParen ctermfg=black
" Make search wrapping more obvious
highlight WarningMsg ctermfg=white ctermbg=red guifg=White guibg=Red gui=None

set tags=./tags;

execute pathogen#infect()

set wildignore+=*/.git/*
