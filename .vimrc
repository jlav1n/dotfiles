set expandtab tabstop=4 shiftwidth=4
set ai hlsearch copyindent

set matchpairs+=<:>
map  !G perl -MText::Autoformat -e 'autoformat { tabspace => 4 }'
vmap    _L      "zxi[L][/L]F["zP
vmap          !perl -MText::Autoformat -0777 -e 'autoformat {all=>1}'
map		<F12>	:if exists("syntax_on") <Bar> syntax off <Bar> else <Bar> syntax enable <Bar> endif<CR>
syntax on

"set formatoptions=tcqn1r
"set flp+=\\\|^\\*\\s*

nmap <leader>h :nohlsearch<CR>
nmap <leader>t :set expandtab<CR>
nmap <leader>T :set noexpandtab<CR>

" fix screen syntax redraw problems:
noremap <S-F12> <Esc>:syntax sync fromstart<CR>
inoremap <S-F12> <C-o>:syntax sync fromstart<CR>

" need following for ft plugins, except we get weird auto comment insertion:
" http://vim.wikia.com/wiki/Disable_automatic_comment_insertion
filetype plugin on 
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set keywordprg=perldoc\ -f

command -range=% -nargs=* Tidy <line1>,<line2>!perltidy -q -l=150
noremap <F4> :Tidy<CR>

command -range=% -nargs=* HTMLTidy <line1>,<line2>!tidy -q -wrap 150
noremap <F5> :HTMLTidy<CR>

au BufNewFile,BufRead *.t set filetype=perl

" dbext
"let g:dbext_default_buffer_lines = 20
"let g:dbext_default_history_file = '~/.dbext_history'
"let g:dbext_default_history_size = 5000
" profiles:
"let g:dbext_default_profile_mysite = 'type=MYSQL:user=USER:passwd=PASS:dbname=MYSITE'
"let g:dbext_default_profile = 'mysite'
