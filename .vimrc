set expandtab tabstop=4 shiftwidth=4
set ai ignorecase smartcase smarttab hlsearch incsearch copyindent
set autowrite

syntax on

let $BASH_ENV = '~/.bash_aliases_for_vim'

set matchpairs+=<:>
map  <leader>f !G perl -MText::Autoformat -X -e 'autoformat { tabspace => 4 }'
vmap <leader>f !perl -MText::Autoformat -X -0777 -e 'autoformat {all=>1}'
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
"noremap <S-F12> <Esc>:syntax sync fromstart<CR>
"inoremap <S-F12> <C-o>:syntax sync fromstart<CR>

filetype plugin on 
" http://vim.wikia.com/wiki/Disable_automatic_comment_insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

autocmd FileType css setlocal tabstop=2 shiftwidth=2
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

command! Q q " Bind :Q to :q
command! W w
command! Wq wq

" Better? completion on command line
set wildmenu
" What to do when I press 'wildchar'. Worth tweaking to see what feels right.
set wildmode=list:full

command -range=% -nargs=* Tidy <line1>,<line2>!perltidy -q -l=150
noremap <F4> :Tidy<CR>

command -range=% -nargs=* HTMLTidy <line1>,<line2>!tidy -q -wrap 150
noremap <F5> :HTMLTidy<CR>

augroup mkd
  autocmd BufRead *.md  set ai formatoptions=tcroqn2 comments=n:>
augroup END

au BufNewFile,BufRead *.hbs set filetype=html
au BufNewFile,BufRead *.t set filetype=perl
au BufNewFile,BufRead *.pl6 set filetype=perl6
au BufNewFile,BufRead *.pm6 set filetype=perl6

highlight Search ctermfg=Black
"highlight Visual ctermfg=Black
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

" dbext
"let g:dbext_default_buffer_lines = 20
"let g:dbext_default_history_file = '~/.dbext_history'
"let g:dbext_default_history_size = 5000
" profiles:
"let g:dbext_default_profile_mysite = 'type=MYSQL:user=USER:passwd=PASS:dbname=MYSITE'
"let g:dbext_default_profile = 'mysite'
